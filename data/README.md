# Source snapshots
Preserve raw source files unchanged. All implementations should read the same snapshots. The R pipeline keeps cleaned and joined tables in memory and renders one HTML report. [sources.csv](sources.csv) records input origins, selections, row counts, sizes and available acquisition metadata.

The initial snapshot is [raw/nyc-dogs-2024.csv](raw/nyc-dogs-2024.csv): 105,974 NYC dog-license records with `extract_year` equal to 2024, all eight published columns, and 11,139,556 bytes. It is a selected CSV export from the [NYC Dog Licensing Dataset](https://data.cityofnewyork.us/Health/NYC-Dog-Licensing-Dataset/nu7n-tubp). The explicit 200,000-row request limit exceeds the independently checked extract count; the saved CSV has the expected 105,974 rows, rather than a default-limited sample.

Each raw row represents a license period, not a guaranteed unique dog. The R pipeline handles names, missingness, ZIP representation and estimated-dog grouping in named R tables. The original source remains unchanged.

The [SSA national baby-name source](https://www.ssa.gov/oact/babynames/limits.html) is saved as the unmodified annual text files in [raw/ssa/](raw/ssa/), alongside SSA's NationalReadMe.pdf. These 146 annual files cover 1880–2025 and contain 2,181,032 name/sex/year records. Together with the readme they occupy 28,255,978 bytes. The underlying tabulation dates to March 1, 2026.

The files were extracted byte for byte from the official national archive downloaded on November 5, 2026. That acquisition was 7,860,026 bytes with SHA-256 cd78e975ed7bb358e018dd62fbe14ced89295e9581c49172ca4eedcb011b3724. The source inventory describes the extracted directory and leaves its checksum field empty. Git retains the earlier archive version in history.

The baby-name notebook reads the 140 annual files for 1880–2019 directly. All rankings and overall name recognition use those 14 complete decades.

The character vector `missing_name_labels` beside the import in [dog-names.qmd](../dog-names.qmd#read-the-license-records) contains the six agreed labels: `UNKNOWN`, `NAME NOT PROVIDED`, `NONE`, `NA`, `.`, and `NONAME`. The import reads all six as missing values. Report one combined missing-name count overall and by recorded ZIP, then exclude those licenses before formatting names and dates or adding report fields. `BABY` remains a name; the source CSV retains the original labels.

Keep ZIP strings as recorded. All selected NYC dogs already have five-digit ZIPs. The 40 named licenses with short ZIPs fall outside the selected comparison, so preparation does not pad them with zeros.

Count and exclude named licenses whose recorded birth year is not a four-digit year from 1990–2024 before formatting or grouping. This removes 45 licenses and leaves 92,921 estimated dogs representing 100,119 named licenses. The in-memory excluded_birth_year_licenses table preserves the 45 recorded rows under short column names. Each retained dog has a source_row_id pointing to the corresponding row in the unchanged input CSV.

The optional [birth-year inference reference](../appendices/birth-year-inferences.qmd) preserves the six considered replacements, their rationale and the original lookup operation. [birth_year_corrections.csv](../appendices/birth_year_corrections.csv) is used only by that reference. It does not affect the main preparation. The greatest change in a plotted income-group share from excluding those six cases rather than keeping the inferences is about 0.007 percentage points.
## Geography and income inputs
[nyc-zcta-list.csv](raw/nyc-zcta-list.csv) is the unmodified CSV response for the `zcta5` column of [NYC Open Data's ZIP Code Tabulation Areas](https://data.cityofnewyork.us/City-Government/ZIP-Code-Tabulation-Areas/35j5-n34v), retrieved November 9, 2026. It contains 221 area codes and occupies 1,776 bytes. Use the published list as the study boundary, accepting that some listed areas extend outside NYC. Owner ZIPs do not establish precise residence within those areas.

[zip_zcta_income_ny_acs2024.csv](lookups/zip_zcta_income_ny_acs2024.csv) is a temporary input reproduced from [Shweta's income script at PR #9 head `eb7ecc0`](https://github.com/Barkonomics-DataWrangling/barkonomics-pet-names/blob/eb7ecc0cbe336740d872d340aae8f95f760f57e3/R/income_zcta.R). It contains 2,150 New York ZIPs and occupies 208,948 bytes. The November 9 reproduction used the official HRSA 2024 crosswalk and ACS 2024 B19013 downloads saved during the November 5 review; its output matched the earlier run byte for byte. Regenerate with that script's `2024 NY` arguments, then copy its `data/processed/zip_zcta_income_ny_acs2024.csv` output to the lookup path. PR #9 is unmerged as of the November 12 review. Running its script separately did not integrate her code or imply acceptance. The analysis currently reads this saved input without downloads or Census API access. Her income preparation still needs reviewed integration into the final report; the dog and baby-name preparation already runs inside it.

The income comparison keeps 92,541 dogs representing 99,719 licenses. It includes 364 dogs in areas reported as $250,000+; their exact numeric income is empty in the analysis table and `income_status = top_coded` preserves the known range. The 380 excluded dogs are reported separately: 275 map to areas outside the city list, 88 have no ZIP match in the NY lookup, and 17 map to city-listed areas without income. The earlier inspection found that the 88 unmatched ZIP cases comprise 72 outside New York State and 16 absent from the national crosswalk. Both counting-unit comparisons use the same selected dogs. The selected bands are under $50,000, $50,000–99,999, $100,000–149,999 and $150,000+. Their dog/neighborhood counts are 9,411/24, 41,341/94, 25,232/46 and 16,557/26, respectively. Each estimated dog receives equal weight within its band. The name-matching summary reports counts and shares for overall SSA recognition and each of the 14 decades, using all selected dogs in the band as the denominator. A dog can contribute to several decade numerators. The separate license-counted summary remains a check on the effect of repeat licenses.
## Run the analysis
From the repository root, render the complete dog and baby-name workflow and its comparisons:

```sh
quarto render analysis.qmd
```

[analysis.qmd](../analysis.qmd) loads tidyverse and [helpers.R](../helpers.R), includes [dog preparation](../dog-names.qmd), includes [baby-name preparation](../baby-names.qmd), and then uses their R tables for matching and comparisons. The include lines insert the sections and execute their code in the same R session. The project renders only analysis.qmd. Its single self-contained analysis.html contains the preparation, explanations, summary tables and charts. It still reads the temporary income lookup described above pending integration of Shweta's preparation.

Intermediate tables stay in memory. No dog handoff, report CSVs, separate chart PNGs or checks notebook are part of this workflow. For an interactive walkthrough, run the packages chunk in analysis.qmd, the dog and baby-name chunks, and then the comparison chunks in that order in one R session.

The optional [birth-year reference](../appendices/birth-year-inferences.qmd) and its small correction lookup live in appendices/. The reference is outside the main report and changes no analysis tables. Run its chunks from the repository root when inspecting those examples.

The notebooks need Quarto and the R packages tidyverse, knitr and rmarkdown. The [data dictionary](dog-name-data-dictionary.md) describes the R objects and their columns. The [spike](../docs/active-spikes/dog-baby-name-data.md) records decisions and work history. Development checks may be run temporarily when needed; they are not persistent report inputs or outputs.
