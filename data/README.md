# Source snapshots
Preserve raw source files unchanged. All implementations should read the same snapshots. The R pipeline keeps preparation tables and name lists in memory and renders one HTML report. [sources.csv](sources.csv) records input origins, selections, row counts, sizes and available acquisition metadata.

The initial snapshot is [raw/nyc-dogs-2024.csv](raw/nyc-dogs-2024.csv): 105,974 NYC dog-license records with `extract_year` equal to 2024, all eight published columns, and 11,139,556 bytes. It is a selected CSV export from the [NYC Dog Licensing Dataset](https://data.cityofnewyork.us/Health/NYC-Dog-Licensing-Dataset/nu7n-tubp). The explicit 200,000-row request limit exceeds the independently checked extract count; the saved CSV has the expected 105,974 rows, rather than a default-limited sample.

Each raw row represents a license period, not a guaranteed unique dog. The R pipeline handles names, missingness, ZIP representation and estimated-dog grouping in named R tables. The original source remains unchanged.

The [SSA national baby-name source](https://www.ssa.gov/oact/babynames/limits.html) is saved as the unmodified annual text files in [raw/ssa/](raw/ssa/), alongside SSA's NationalReadMe.pdf. These 146 annual files cover 1880–2025 and contain 2,181,032 name/sex/year records. Together with the readme they occupy 28,255,978 bytes. The underlying tabulation dates to March 1, 2026.

The files were extracted byte for byte from the official national archive downloaded on November 5, 2026. That acquisition was 7,860,026 bytes with SHA-256 cd78e975ed7bb358e018dd62fbe14ced89295e9581c49172ca4eedcb011b3724. The source inventory describes the extracted directory and leaves its checksum field empty. Git retains the earlier archive version in history.

The baby-name notebook reads the 140 annual files for 1880–2019 directly. All rankings and overall name recognition use those 14 complete decades.

The character vector `missing_name_labels` in the [missing-name cleanup step](../dog-names.qmd#count-missing-names-by-zip) contains the six agreed labels: `UNKNOWN`, `NAME NOT PROVIDED`, `NONE`, `NA`, `.`, and `NONAME`. Import uses the standard missing-value and whitespace handling: "NA" and empty fields become missing values, and surrounding spaces are trimmed. The cleanup counts existing missing values and remaining text labels together, then excludes both without recoding. Report one combined missing-name count overall and by recorded ZIP, then exclude those licenses before formatting names or adding report fields. The source CSV retains the original labels.

Keep ZIP strings as recorded. The shared report joins recorded ZIPs to the proposed income lookup without padding or exclusions.

Count and exclude named licenses whose approximate age at issuance (issue year minus recorded birth year) falls outside 0–25 before formatting or grouping. The maximum is a judgment call, not a biological limit. This removes 59 licenses and leaves 96,810 estimated dogs representing 100,105 named licenses. The in-memory excluded_birth_year_licenses table preserves the 59 excluded rows and their age calculations. Each retained dog has a source_row_id pointing to the corresponding row in the unchanged input CSV.

The optional [birth-year inference reference](../appendices/birth-year-inferences.qmd) preserves the six considered replacements, their rationale and the original lookup operation. [birth_year_corrections.csv](../appendices/birth_year_corrections.csv) is used only by that reference. It does not affect the main preparation.
## Run the analysis
From the repository root, render the dog and baby-name preparation:

```sh
quarto render final-analysis.qmd
```

The template-based [final-analysis.qmd](../final-analysis.qmd) includes [dog-baby-matching.qmd](../dog-baby-matching.qmd), which runs [dog preparation](../dog-names.qmd) and [baby-name preparation](../baby-names.qmd) once each. Those notebooks load tidyverse and [helpers.R](../helpers.R). Dog preparation shows its pair construction, date comparisons, decisions, competing-match counts and renewal-chain loop directly in the notebook. The optional [sensitivity appendix](../appendices/license-consolidation-sensitivity.qmd) keeps the reusable scenario functions and extended inspection outside the main walkthrough. The matching notebook produces dogs_with_baby_name_measures; the shared report then attaches the proposed ZIP-to-income lookup and reports coverage. The include lines insert the sections and execute their code in the same R session. The project renders only final-analysis.qmd. Its single self-contained final-analysis.html contains the preparation, explanations, cleaning summaries and name matching. It reads the saved dog, SSA, HRSA crosswalk and ACS income snapshots. No input downloads run during rendering.

Intermediate tables stay in memory. No dog handoff, report CSVs, separate chart PNGs or checks notebook are part of this workflow. Each preparation notebook runs independently from its packages-and-helpers chunk downward. General previews show six rows. Focused displays show example name changes, the licenses retained during consolidation, and year-to-decade assignments; summary displays show their reported counts. For a full interactive table, run View(dogs_prepared) or View(baby_names_top100_by_decade_prepared) in the console for that notebook. View() opens the editor’s Data Explorer; it does not produce an inline report table. dog-baby-matching.qmd runs its preparation includes before looking up overall name recognition.

In Positron, enable quarto.inlineOutput.enabled in Settings to display chunk results beneath the code. Inline mode gives each QMD its own R session, so running one preparation file does not populate the other file’s session. Run each file from its setup chunk when using inline mode. Rendering final-analysis.qmd includes the preparation in one R session and produces the combined report; the include lines are not themselves interactive R chunks. [Positron inline-output documentation](https://positron.posit.co/quarto-inline-output.html) explains the session behavior.

The optional [birth-year reference](../appendices/birth-year-inferences.qmd) and its small correction lookup live in appendices/. The reference is outside the main report and changes no analysis tables. Run its chunks from the repository root when inspecting those examples.

The notebooks need Quarto and the R packages tidyverse, knitr, rmarkdown, readxl and jsonlite. The [data dictionary](dog-name-data-dictionary.md) describes the R objects and their columns. The [spike](../docs/active-spikes/dog-baby-name-data.md) records decisions and work history. Development checks may be run temporarily when needed; they are not persistent report inputs or outputs.

## License consolidation review
Dog preparation removes repeated copies, then uses matching name/sex/birth-year/breed and license timing to estimate renewals. The provisional rule allows issue dates within 30 days of expiry in the same ZIP and 7 days across ZIPs. It leaves competing links unresolved and permits possible expiry corrections within five days when name, sex, birth year, breed and ZIP match. Different names are never considered correction candidates. The earliest observed license supplies the prepared values. The optional sensitivity appendix compares eight window combinations, records possible one-field corrections without applying them, and plots aligned license periods plus a per-rule retained-source grid. Its setup extracts the main notebook’s R chunks to a temporary script, runs that script and removes it, allowing a separate Positron session to reuse the preparation. It does not render another HTML file; the project still renders only final-analysis.qmd. Tables and plots remain in memory; no additional HTML or CSV is written. Review the chosen windows before sharing the reconciliation packet.

## Income source provenance
The crosswalk workbook and ACS JSON are unchanged snapshots from Shweta’s income contribution, recorded in [sources.csv](sources.csv). Retrieval timestamps are left blank where not established here. The [shared-analysis record](../docs/active-spikes/shared-final-analysis.md#inputs-and-provenance) identifies the source commits for these files and the proposed preparation notebook.
