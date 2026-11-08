# Source snapshots
Preserve raw source files unchanged. All implementations should read the same snapshots; cleaned and joined outputs are generated separately. [sources.csv](sources.csv) records the source query, retrieval time, selection, row count, byte size and SHA-256 checksum for each acquired file.

The initial snapshot is [raw/nyc-dogs-2024.csv](raw/nyc-dogs-2024.csv): 105,974 NYC dog-license records with `extract_year` equal to 2024, all eight published columns, and 11,139,556 bytes. It is a selected CSV export from the [NYC Dog Licensing Dataset](https://data.cityofnewyork.us/Health/NYC-Dog-Licensing-Dataset/nu7n-tubp). The explicit 200,000-row request limit exceeds the independently checked extract count; the saved CSV has the expected 105,974 rows, rather than a default-limited sample.

Each raw row represents a license period, not a guaranteed unique dog. The R pipeline handles names, missingness, ZIP representation and estimated-dog grouping in separate derived files. The original source remains unchanged.

The [SSA national baby-name source](https://www.ssa.gov/oact/babynames/limits.html) is saved as the unmodified annual text files in [raw/ssa/](raw/ssa/), alongside SSA's NationalReadMe.pdf. These 146 annual files cover 1880–2025 and contain 2,181,032 name/sex/year records. Together with the readme they occupy 28,255,978 bytes. The underlying tabulation dates to March 1, 2026.

The files were extracted byte for byte from the official national archive downloaded on November 5, 2026. That acquisition was 7,860,026 bytes with SHA-256 cd78e975ed7bb358e018dd62fbe14ced89295e9581c49172ca4eedcb011b3724. The source inventory describes the extracted directory and leaves its checksum field empty. Git retains the earlier archive version in history.

The baby-name notebook reads the 140 annual files for 1880–2019 directly. All rankings and overall name recognition use those 14 complete decades.

The character vector `missing_name_labels` beside the missing-name step in [dog-names.qmd](../dog-names.qmd#missing-name-labels) contains the six agreed labels. Count their occurrences overall and by ZIP, then exclude those licenses before formatting names and dates or adding quality flags. `BABY` remains a name.
## Generate and check the handoff
Open the repository as the editor workspace and run each notebook’s R chunks from top to bottom. Run dog preparation and baby-name preparation before analysis, then run the separate checks. Preparation and checking need only code execution. Render the analysis when an HTML deliverable is needed.

```sh
quarto render analysis.qmd
```

- [Dog preparation](../dog-names.qmd) writes dogs_prepared_2024.csv, the source-to-dog mapping, missing-name summaries and quality flags.
- [Baby-name preparation](../baby-names.qmd) writes the name reference, decade table, and cutoff counts.
- [Analysis](../analysis.qmd) writes dogs_2024.csv with all 14 decade flags and the comparison of dog and license counts. Geography and income joins belong in this notebook once the agreed tables are available.
- [Checks](../dog-names-checks.qmd) independently reads the sources and outputs to check the saved result.

The notebooks need Quarto and the R packages tidyverse, knitr and rmarkdown. Their shared preview and ZIP-formatting functions live in [R/helpers.R](../R/helpers.R). The [data dictionary](dog-name-data-dictionary.md) defines the output fields. Aslan used Codex for assistance with implementation and checks.

Keep the generated CSVs with this contribution for review and offline use. Regenerate the checks after changing a processing result. The [spike](../docs/active-spikes/dog-baby-name-data.md) records decisions and work history.
