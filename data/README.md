# Source snapshots
Preserve raw source files unchanged. All implementations should read the same snapshots; cleaned and joined outputs are generated separately. [sources.csv](sources.csv) records the source query, retrieval time, selection, row count, byte size and SHA-256 checksum for each acquired file.

The initial snapshot is [raw/nyc-dogs-2024.csv](raw/nyc-dogs-2024.csv): 105,974 NYC dog-license records with `extract_year` equal to 2024, all eight published columns, and 11,139,556 bytes. It is a selected CSV export from the [NYC Dog Licensing Dataset](https://data.cityofnewyork.us/Health/NYC-Dog-Licensing-Dataset/nu7n-tubp). The explicit 200,000-row request limit exceeds the independently checked extract count; the saved CSV has the expected 105,974 rows, rather than a default-limited sample.

Each raw row represents a license period, not a guaranteed unique dog. The R pipeline handles names, missingness, ZIP representation and estimated-dog grouping in separate derived files. The original source remains unchanged.

The [SSA national baby-name archive](https://www.ssa.gov/oact/babynames/limits.html) is preserved as [raw/ssa-names.zip](raw/ssa-names.zip). Downloaded from the official National data link in a browser on November 5, 2026 after command-line requests returned 403, it contains 146 annual files for 1880–2025 and `NationalReadMe.pdf`. The archive is 7,860,026 bytes, expands to 28,255,978 bytes, and contains 2,181,032 annual name/sex/count records. Its readme dates the underlying tabulation to March 1, 2026. The ZIP integrity check passed; its exact URL, retrieval time and SHA-256 are in the manifest. No third-party substitute was used.

The R pipeline reads only 1920–1929, 1970–1979 and 2010–2019 from that archive, extracting them into a temporary directory. The unmodified ZIP remains the source snapshot. Do not re-download a moving source to reproduce this handoff; use the saved bytes.

The [missing-name lookup](lookups/missing_name_labels.csv) is project-owned data recording the six selected labels. It maps alternate missing-name labels to `not_recorded`; `BABY` is deliberately absent. This lookup is not an additional external source.
## Generate and check the handoff
Run from the repository root:

```sh
quarto render dog-names.qmd
```

The [R notebook](../dog-names.qmd) needs Quarto plus the R packages `tidyverse`, `knitr` and `rmarkdown`. It reads the saved sources, writes the CSVs, then re-reads them to check the output contract and record runtime versions. The source manifest retains acquisition checksums as provenance; the R workflow does not calculate or verify them. The [data dictionary](dog-name-data-dictionary.md) defines columns and types.

The generated CSVs in `derived/` are the inspectable first handoff snapshot and should travel with this contribution. They total about 31 MB; the main dog CSV is 16.10 MB. Keeping these outputs alongside the roughly 19 MB of raw sources lets a collaborator inspect the result immediately and regenerate it offline. Temporary SSA extraction and R session files do not belong in Git. A new processing result must regenerate the saved validation results too.

The [dog and baby-name spike](../docs/active-spikes/dog-baby-name-data.md) records the selected decisions and work history. These are estimated dogs under the documented five-field rule; income and geographic joins are later work.
