# Source snapshots
Preserve raw source files unchanged. All implementations should read the same snapshots; cleaned and joined outputs are generated separately. [sources.csv](sources.csv) records input origins, selections, row counts, sizes and available acquisition metadata.

The initial snapshot is [raw/nyc-dogs-2024.csv](raw/nyc-dogs-2024.csv): 105,974 NYC dog-license records with `extract_year` equal to 2024, all eight published columns, and 11,139,556 bytes. It is a selected CSV export from the [NYC Dog Licensing Dataset](https://data.cityofnewyork.us/Health/NYC-Dog-Licensing-Dataset/nu7n-tubp). The explicit 200,000-row request limit exceeds the independently checked extract count; the saved CSV has the expected 105,974 rows, rather than a default-limited sample.

Each raw row represents a license period, not a guaranteed unique dog. The R pipeline handles names, missingness, ZIP representation and estimated-dog grouping in separate derived files. The original source remains unchanged.

The [SSA national baby-name source](https://www.ssa.gov/oact/babynames/limits.html) is saved as the unmodified annual text files in [raw/ssa/](raw/ssa/), alongside SSA's NationalReadMe.pdf. These 146 annual files cover 1880–2025 and contain 2,181,032 name/sex/year records. Together with the readme they occupy 28,255,978 bytes. The underlying tabulation dates to March 1, 2026.

The files were extracted byte for byte from the official national archive downloaded on November 5, 2026. That acquisition was 7,860,026 bytes with SHA-256 cd78e975ed7bb358e018dd62fbe14ced89295e9581c49172ca4eedcb011b3724. The source inventory describes the extracted directory and leaves its checksum field empty. Git retains the earlier archive version in history.

The baby-name notebook reads the 140 annual files for 1880–2019 directly. All rankings and overall name recognition use those 14 complete decades.

The character vector `missing_name_labels` beside the missing-name step in [dog-names.qmd](../dog-names.qmd#missing-name-labels) contains the six agreed labels. Count their occurrences overall and by ZIP, then exclude those licenses before formatting names and dates or adding quality flags. `BABY` remains a name.

[birth_year_corrections.csv](lookups/birth_year_corrections.csv) contains six approved, inferred replacements for specific source records: ROCKY 223 → 2023, SIMBA 222 → 2022, BILLIE 202 → 2020, MILO 204 → 2024, and HONEY and BROWNIE 1022 → 2022. The lookup includes name, breed, sex and the original year so the notebook applies each correction to the reviewed record. Apply these after dog grouping; preserve the raw source and all existing groups. The notebook displays the lookup as part of the cleaning explanation. The birth-year quality counts describe the original values before these inferences. After applying them, exclude dogs whose birth years are not four digits within 1990–2024. The resulting 92,927 dogs represent 100,125 named licenses. The audit retains all 105,974 source rows, marking the 39 licenses belonging to the 36 excluded dogs as `excluded_birth_year`. The NYC income selection follows this preparation stage.
## Geography and income inputs
[nyc-zcta-list.csv](raw/nyc-zcta-list.csv) is the unmodified CSV response for the `zcta5` column of [NYC Open Data's ZIP Code Tabulation Areas](https://data.cityofnewyork.us/City-Government/ZIP-Code-Tabulation-Areas/35j5-n34v), retrieved November 9, 2026. It contains 221 area codes and occupies 1,776 bytes. Use the published list as the study boundary, accepting that some listed areas extend outside NYC. Owner ZIPs do not establish precise residence within those areas.

[zip_zcta_income_ny_acs2024.csv](lookups/zip_zcta_income_ny_acs2024.csv) is a saved handoff reproduced from [Shweta's income script at PR #9 head `eb7ecc0`](https://github.com/Barkonomics-DataWrangling/barkonomics-pet-names/blob/eb7ecc0cbe336740d872d340aae8f95f760f57e3/R/income_zcta.R). It contains 2,150 New York ZIPs and occupies 208,948 bytes. The November 9 reproduction used the official HRSA 2024 crosswalk and ACS 2024 B19013 downloads saved during the November 5 review; its output matched the earlier run byte for byte. Regenerate with that script's `2024 NY` arguments, then copy its `data/processed/zip_zcta_income_ny_acs2024.csv` output to the lookup path. The analysis reads this saved handoff directly and requires no downloads or Census API access.

The income comparison keeps 92,547 dogs representing 99,725 licenses. It includes 364 dogs in areas reported as $250,000+; their exact numeric income is empty in the analysis table and `income_status = top_coded` preserves the known range. The 380 excluded dogs are reported separately: 275 map to areas outside the city list, 88 have no ZIP match in the NY lookup, and 17 map to city-listed areas without income. The earlier inspection found that the 88 unmatched ZIP cases comprise 72 outside New York State and 16 absent from the national crosswalk. Both counting-unit comparisons use the same selected dogs. Income-group boundaries remain an open decision.
## Generate and check the handoff
Open the repository as the editor workspace and run each notebook’s R chunks from top to bottom. Run dog preparation and baby-name preparation before analysis, then run the separate checks. Preparation and checking need only code execution. Render the analysis when an HTML deliverable is needed.

```sh
quarto render analysis.qmd
```

- [Dog preparation](../dog-names.qmd) writes dogs_prepared_2024.csv, the source-to-dog mapping, missing-name summaries and quality flags.
- [Baby-name preparation](../baby-names.qmd) writes the name reference, decade table, and cutoff counts.
- [Analysis](../analysis.qmd) writes the full dog/name handoff, the selected NYC income table, exclusions and their counts, and matching shares for the selected dogs weighted once per dog or once per license.
- [Checks](../dog-names-checks.qmd) independently reads the sources and outputs to check the saved result.

The notebooks need Quarto and the R packages tidyverse, knitr and rmarkdown. Their shared preview and ZIP-formatting functions live in [R/helpers.R](../R/helpers.R). The [data dictionary](dog-name-data-dictionary.md) defines the output fields. Aslan used Codex for assistance with implementation and checks.

Keep the generated CSVs with this contribution for review and offline use. Regenerate the checks after changing a processing result. The [spike](../docs/active-spikes/dog-baby-name-data.md) records decisions and work history.
