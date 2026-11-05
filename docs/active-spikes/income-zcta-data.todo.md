---
attention: live
tags: [barkonomics, data, income, zcta, r]
---
# Income and ZIP–ZCTA data tasks
## Background
Work for [issue #2](https://github.com/Barkonomics-DataWrangling/barkonomics-pet-names/issues/2) on branch `shweta/income-zcta-data`, created from `main` at `992bc8b`. [Concept, sources and open questions](income-zcta-data.md).

## Current state
`R/income_zcta.R` builds one ZIP-level table joining the HRSA crosswalk to ACS B19013 for a chosen release (default 2024, a candidate) and state (default NY). Run from the repo root with `Rscript R/income_zcta.R [release] [state|ALL]`; it writes `data/processed/zip_zcta_income_<state>_acs<release>.csv`. Local R 4.6.1 with tidyverse and readxl is enough; no new packages and no Census API key.

## To Do
- Draft the integration table shape for Aslan's review (columns, keys, one row per ZIP or per ZCTA).
- Bring progress and questions to the November 5 review.
- Prepare a draft PR so Aslan can see scope and the integration plan.
- Decide with Aslan which ACS release matches the license extract, then rerun with that release.
- Decide how top-coded, bottom-coded and not-available incomes are treated in income groupings.

## Ready for Human QA

## Done
- Decide with Shweta where raw downloads and cleaned outputs live, and add ignore rules if raw data stays out of Git. — Agent default applied, open to change: `/data/` is ignored and re-created by the script, since both sources are public downloads. Committing the processed CSV instead remains a human choice.
- Write an R script that downloads the HRSA crosswalk, keeps New York ZIPs, stores ZIP and ZCTA as five-character strings and checks that ZIP keys are unique. — In `R/income_zcta.R`. 41,061 ZIPs, all unique and 5-digit; 2,150 in NY. Eight territory ZIPs have no ZCTA and get `income_status = no_zcta` when included.
- Write an R script that gets ACS B19013 estimate and margin of error for the relevant ZCTAs, once the release and API-key handling are settled. — The Census API rejects keyless requests (redirects to missing_key), so the script reads the keyless table-based summary file `acsdt5y<release>-b19013.dat` instead; no key handling needed. 33,772 ZCTAs. Census codes become NA plus a status: 3,225 `not_available` (-666666666), 118 top-coded at 250001, 15 bottom-coded at 2499 (MOE -333333333).
- Join crosswalk to income and report ZCTAs with missing or suppressed income estimates. — Many-to-one left join; row count asserted unchanged. NY 2024: 1,826 distinct ZCTAs; ZIP rows 1,918 estimate, 29 top_coded, 1 bottom_coded, 200 not_available, 2 zcta_not_in_acs (11717 Brentwood, 11798 Wyandanch, ZCTAs absent from the ACS file). Spot-checked 10001, 10002, 10007, 10314, 10451, 11201 against the raw ACS file.
- Shweta: run `Rscript R/income_zcta.R` from the repo root and open `data/processed/zip_zcta_income_ny_acs2024.csv`; check that a few ZIPs you know look plausible. — QA passed 2026-11-05: Shweta ran the script locally (same 2,150 rows and status counts) and confirmed the output.
