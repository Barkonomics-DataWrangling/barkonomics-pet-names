# Barkonomics: join ZIP codes to ZCTA median household income (issue #2)
#
# Builds one ZIP-level table: HRSA ZIP-to-ZCTA crosswalk (2024 UDS workbook,
# TIGER 2023 ZCTAs, June 2023 ZIPs) left-joined to ACS 5-year table B19013
# (median household income, estimate and margin of error per ZCTA).
#
# The ACS release is a parameter. 2024 is the proposal's candidate, not a
# settled choice; pick it to match the license extract year.
#
# ACS comes from the Census table-based summary file, which needs no API key.
# Raw downloads go to data/raw/ and output to data/processed/; both are
# ignored by Git and re-created by running this script from the repo root:
#
#   Rscript R/income_zcta.R            # 2024 release, New York ZIPs
#   Rscript R/income_zcta.R 2023 NY    # another release / state

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(readxl)
  library(stringr)
})

args <- commandArgs(trailingOnly = TRUE)
acs_release <- if (length(args) >= 1) as.integer(args[[1]]) else 2024L
state_filter <- if (length(args) >= 2) args[[2]] else "NY"

raw_dir <- file.path("data", "raw")
out_dir <- file.path("data", "processed")
dir.create(raw_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

crosswalk_url <- "https://data.hrsa.gov/DataDownload/GeoCareNavigator/ZIPCodetoZCTACrosswalk2024UDS.xlsx"
acs_url <- sprintf(
  "https://www2.census.gov/programs-surveys/acs/summary_file/%d/table-based-SF/data/5YRData/acsdt5y%d-b19013.dat",
  acs_release, acs_release
)

download_once <- function(url, dest) {
  if (!file.exists(dest)) {
    message("Downloading ", url)
    download.file(url, dest, mode = "wb", quiet = TRUE)
  }
  dest
}

crosswalk_path <- download_once(crosswalk_url, file.path(raw_dir, basename(crosswalk_url)))
acs_path <- download_once(acs_url, file.path(raw_dir, basename(acs_url)))

# ---- Crosswalk: one row per ZIP, keys kept as 5-character text -------------
crosswalk_all <- read_excel(crosswalk_path, sheet = "ZiptoZCTA", col_types = "text") |>
  transmute(
    zip_code = str_pad(str_trim(ZIP_CODE), 5, pad = "0"),
    po_name = PO_NAME,
    state = STATE,
    zip_type = ZIP_TYPE,
    zip_join_type = ZIP_JOIN_TYPE,
    zcta = if_else(is.na(ZCTA) | str_trim(ZCTA) == "", NA_character_,
                   str_pad(str_trim(ZCTA), 5, pad = "0"))
  )

stopifnot(
  "ZIP keys must be unique" = !anyDuplicated(crosswalk_all$zip_code),
  "ZIP codes must be 5 digits" = all(str_detect(crosswalk_all$zip_code, "^[0-9]{5}$")),
  "ZCTAs must be 5 digits or missing" = all(is.na(crosswalk_all$zcta) | str_detect(crosswalk_all$zcta, "^[0-9]{5}$"))
)

crosswalk <- if (is.na(state_filter) || state_filter == "ALL") crosswalk_all else
  filter(crosswalk_all, state == state_filter)

# ---- ACS B19013: one row per ZCTA, special values kept as status flags -----
# Census annotation codes: -666666666 = estimate not computable (too few
# sample cases); -222222222 = MOE not computable; -333333333 = median falls
# in an open-ended interval, so 250001 means "250,000+" and 2499 "2,500-".
acs <- read_delim(acs_path, delim = "|", col_types = cols(.default = col_character())) |>
  filter(str_starts(GEO_ID, "860Z200US")) |>
  transmute(
    zcta = str_remove(GEO_ID, "^860Z200US"),
    estimate_raw = as.numeric(B19013_E001),
    moe_raw = as.numeric(B19013_M001)
  ) |>
  mutate(
    income_status = case_when(
      estimate_raw < 0 ~ "not_available",
      estimate_raw >= 250001 ~ "top_coded",
      estimate_raw <= 2499 ~ "bottom_coded",
      TRUE ~ "estimate"
    ),
    median_hh_income = if_else(estimate_raw < 0, NA_real_, estimate_raw),
    median_hh_income_moe = if_else(moe_raw < 0, NA_real_, moe_raw)
  ) |>
  select(zcta, median_hh_income, median_hh_income_moe, income_status)

stopifnot("ZCTA keys in ACS must be unique" = !anyDuplicated(acs$zcta))

# ---- Join: many ZIPs may share a ZCTA; ZIP rows must not multiply ----------
zip_income <- crosswalk |>
  left_join(acs, by = "zcta", relationship = "many-to-one") |>
  mutate(
    income_status = case_when(
      is.na(zcta) ~ "no_zcta",
      is.na(income_status) ~ "zcta_not_in_acs",
      TRUE ~ income_status
    ),
    acs_release = acs_release,
    acs_period = sprintf("%d-%d", acs_release - 4L, acs_release)
  ) |>
  arrange(zip_code)

stopifnot("join must keep one row per ZIP" = nrow(zip_income) == nrow(crosswalk))

out_path <- file.path(out_dir, sprintf("zip_zcta_income_%s_acs%d.csv", tolower(state_filter), acs_release))
write_csv(zip_income, out_path, na = "")

# ---- Report counts rather than silently dropping anything -------------------
message("ACS release: ", acs_release, " (", acs_release - 4L, "-", acs_release, ")")
message("Crosswalk ZIPs (all states): ", nrow(crosswalk_all), "; kept for ", state_filter, ": ", nrow(crosswalk))
message("Distinct ZCTAs among kept ZIPs: ", n_distinct(zip_income$zcta, na.rm = TRUE))
message("ZIP rows by income_status:")
print(count(zip_income, income_status))
message("Wrote ", out_path, " (", nrow(zip_income), " rows)")
