# Source snapshots
Preserve raw source files unchanged. All implementations should read the same snapshots. The R pipeline keeps cleaned and joined tables in memory and renders one HTML report. [sources.csv](sources.csv) records input origins, selections, row counts, sizes and available acquisition metadata.

The initial snapshot is [raw/nyc-dogs-2024.csv](raw/nyc-dogs-2024.csv): 105,974 NYC dog-license records with `extract_year` equal to 2024, all eight published columns, and 11,139,556 bytes. It is a selected CSV export from the [NYC Dog Licensing Dataset](https://data.cityofnewyork.us/Health/NYC-Dog-Licensing-Dataset/nu7n-tubp). The explicit 200,000-row request limit exceeds the independently checked extract count; the saved CSV has the expected 105,974 rows, rather than a default-limited sample.

Each raw row represents a license period, not a guaranteed unique dog. The R pipeline handles names, missingness, ZIP representation and estimated-dog grouping in named R tables. The original source remains unchanged.

The [SSA national baby-name source](https://www.ssa.gov/oact/babynames/limits.html) is saved as the unmodified annual text files in [raw/ssa/](raw/ssa/), alongside SSA's NationalReadMe.pdf. These 146 annual files cover 1880–2025 and contain 2,181,032 name/sex/year records. Together with the readme they occupy 28,255,978 bytes. The underlying tabulation dates to March 1, 2026.

The files were extracted byte for byte from the official national archive downloaded on November 5, 2026. That acquisition was 7,860,026 bytes with SHA-256 cd78e975ed7bb358e018dd62fbe14ced89295e9581c49172ca4eedcb011b3724. The source inventory describes the extracted directory and leaves its checksum field empty. Git retains the earlier archive version in history.

The baby-name notebook reads the 140 annual files for 1880–2019 directly. All rankings and overall name recognition use those 14 complete decades.

The character vector `missing_name_labels` beside the import in [dog-names.qmd](../dog-names.qmd#read-the-license-records) contains the six agreed labels: `UNKNOWN`, `NAME NOT PROVIDED`, `NONE`, `NA`, `.`, and `NONAME`. The import reads all six as missing values. Report one combined missing-name count overall and by recorded ZIP, then exclude those licenses before formatting names and dates or adding report fields. The source CSV retains the original labels.

Keep ZIP strings as recorded. Geographic matching and income integration are deferred.

Count and exclude named licenses whose recorded birth year is not a four-digit year from 1990–2024 before formatting or grouping. This removes 45 licenses and leaves 92,921 estimated dogs representing 100,119 named licenses. The in-memory excluded_birth_year_licenses table preserves the 45 recorded rows under short column names. Each retained dog has a source_row_id pointing to the corresponding row in the unchanged input CSV.

The optional [birth-year inference reference](../appendices/birth-year-inferences.qmd) preserves the six considered replacements, their rationale and the original lookup operation. [birth_year_corrections.csv](../appendices/birth_year_corrections.csv) is used only by that reference. It does not affect the main preparation.
## Run the analysis
From the repository root, render the dog and baby-name preparation and matching:

```sh
quarto render analysis.qmd
```

[analysis.qmd](../analysis.qmd) loads tidyverse and [helpers.R](../helpers.R), includes [dog preparation](../dog-names.qmd), includes [baby-name preparation](../baby-names.qmd), and then matches their R tables by name. The include lines insert the sections and execute their code in the same R session. The project renders only analysis.qmd. Its single self-contained analysis.html contains the preparation, explanations, cleaning summaries and name matches. It reads only the dog and SSA source snapshots; income work is deferred.

Intermediate tables stay in memory. No dog handoff, report CSVs, separate chart PNGs or checks notebook are part of this workflow. For an interactive walkthrough, run the packages chunk in analysis.qmd, the dog and baby-name chunks, and then the name-matching chunk in that order in one R session.

The optional [birth-year reference](../appendices/birth-year-inferences.qmd) and its small correction lookup live in appendices/. The reference is outside the main report and changes no analysis tables. Run its chunks from the repository root when inspecting those examples.

The notebooks need Quarto and the R packages tidyverse, knitr and rmarkdown. The [data dictionary](dog-name-data-dictionary.md) describes the R objects and their columns. The [spike](../docs/active-spikes/dog-baby-name-data.md) records decisions and work history. Development checks may be run temporarily when needed; they are not persistent report inputs or outputs.
