# Dog-name data dictionary
The primary file is [dogs_2024.csv](derived/dogs_2024.csv), one row per named estimated dog under the five-field rule. Read ZIP codes and birth years as text. In the reference and audit files, an empty field means a missing value. Use `na = ""` to keep a name written with the two letters `NA` as text.
The notebook keeps a source-stage table, dogs_original, with consistent original_ column names. The preparation uses original names and ZIPs to compare spelling and padding. The exported dog tables contain the working fields. source_row_id links every retained dog to the original license and its recorded values.
## Dog columns
| Column | Type | Meaning |
| --- | --- | --- |
| `estimated_dog_id` | Text | `dog2024-` plus the retained source row number, padded to six digits. Stable within this snapshot and rule, not an official ID or a cross-year identity. |
| `source_row_id` | Integer | One-based data row of the retained license in the raw CSV, excluding its header. |
| `extract_year` | Integer | Selected NYC extract, 2024; not necessarily the license issue year. |
| `name` | Text | Full name uppercased with spaces and hyphens removed; no first-token, nickname or title substitution. |
| `sex` | Text | Recorded dog sex (`F` or `M` in this snapshot). Dog sex does not constrain SSA name matching. |
| `birth_year` | Text | Recorded birth year except for the four approved inferences in [birth_year_corrections.csv](lookups/birth_year_corrections.csv). Other malformed values remain as recorded. |
| `breed` | Text | Recorded breed, including `Unknown`; no breed-alias consolidation. |
| `zipcode` | Text | Five-character ZIP representation: digit-only source values of up to five digits are left-padded with zeros. This is not confirmation of valid NYC geography. |
| `license_issue_date` | Date | Issue date of the retained license, `YYYY-MM-DD`. |
| `license_expiry_date` | Date | Expiry date of the retained license, `YYYY-MM-DD`. |
| `license_record_count` | Integer | Number of named source license records assigned to this estimated dog. |
| `ssa_recognized` | Boolean | Full normalized name appears in a published SSA record in any selected year: 1880–2019. |
| `top100_1880` … `top100_2010` | Boolean | One column per complete decade. True when the name is among its 100 largest combined-sex birth counts. |

The five-field group key uses `name`, `sex`, the recorded `birth_year`, `breed` and `zipcode`. Select greatest issue date, then greatest expiry date, then smallest `source_row_id`. Apply the four birth-year inferences only after grouping; they do not merge license groups or change their ZIPs. The correction lookup records the original and inferred years beside each specific source record, name, breed and sex. The 14 decade flags can overlap, and percentages using them need not sum to 100%. A false recognition flag means absent from this reference, not proven non-human.
## Supporting tables
| File | Row unit and key | Purpose |
| --- | --- | --- |
| [dogs_prepared_2024.csv](derived/dogs_prepared_2024.csv) | One estimated dog | Prepared dog fields before baby-name matching. |
| [ssa_name_reference.csv](derived/ssa_name_reference.csv) | One normalized name; `name` unique | Recognition across 1880–2019 and 14 decade measures. Join many dogs to one reference row. |
| [ssa_name_decades.csv](derived/ssa_name_decades.csv) | One observed name/decade; `(name, decade)` unique | Long version showing aggregation, ranking and the input to the wide reference. |
| [license_to_dog.csv](derived/license_to_dog.csv) | One raw license record; `source_row_id` unique | Maps every source record to its estimated dog and retained row, or to `missing_name` with empty IDs. Other statuses are `retained` and `consolidated`. |
| [missing_names_by_zip.csv](derived/missing_names_by_zip.csv) | One extract/ZIP | Counts all source license records, missing-name records, named records and missing-name share. These are record counts, not dog counts. |
| [missing_name_labels.csv](derived/missing_name_labels.csv) | One missing label | Counts the six selected source labels. |
| [quality_flags.csv](derived/quality_flags.csv) | One unit/measure | Counts preparation findings among named license records and estimated dogs, plus estimated dogs with tied latest issue dates. |
| [matching_by_counting_unit.csv](derived/matching_by_counting_unit.csv) | One unit/measure | Recognition and decade shares when weighting estimated dogs equally versus weighting by their license-record counts. |
| [ssa_top100_cutoffs.csv](derived/ssa_top100_cutoffs.csv) | One decade | Names and counts at ranks 100/101 and whether the cutoff is tied. |
| [stage_counts.csv](derived/stage_counts.csv) | One processing stage/measure | Counts measured from the source and saved tables in the checks notebook. |
| [validation_checks.csv](derived/validation_checks.csv) | One check | Pass/fail results from independently re-reading saved files. |
| [runtime_versions.csv](derived/runtime_versions.csv) | One package/runtime | Versions used for validation. |

The cleaning report contains these measures; their per-record fields are not exported in the dog tables.

| Measure | Meaning |
| --- | --- |
| `breed_unknown` | Breed is `Unknown` or blank, ignoring case and outer whitespace. |
| `birth_year_suspect` | Recorded birth year is not four digits or lies outside 1990–2024, counted before the four approved inferences. This is a screening choice, not a correction or exclusion rule. |
| `zipcode_padded` | ZIP gained leading zeros during preparation. Five digits do not establish a geographic match. |
| `compound_name` | Recorded name contains internal whitespace or an internal ASCII hyphen. For estimated dogs, this uses the retained license. |
| `latest_issue_ties` | Number of estimated dogs with multiple licenses sharing their latest issue date. The expiry-date and source-row sorting resolves the tie. This measure is reported only at dog level. |

In the SSA tables, `births` sums published counts across sex and all ten years in that decade. `share` divides by the decade's total published counts; suppressed names are not part of that denominator. `rank` orders descending counts and then alphabetically in C locale. `top100` is `rank <= 100`. The wide table uses decade suffixes from `_1880` through `_2010`; an absent decade has zero births/share, false membership and an empty rank. Every reference row has `ssa_recognized = TRUE`.

## Import the dog table in R
Read ZIP codes and recorded birth years as text. Treat empty fields as missing values.

```r
library(tidyverse)

dogs <- read_csv(
  "data/derived/dogs_2024.csv", na = "",
  col_types = cols(
    zipcode = col_character(),
    birth_year = col_character()
  )
)
```
