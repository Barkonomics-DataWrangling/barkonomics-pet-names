# Dog-name data dictionary
The primary file is [dogs_2024.csv](derived/dogs_2024.csv), one row per named estimated dog under the five-field rule. CSV does not store types: explicitly import ZIP codes and birth years as text. Empty fields in the reference/audit outputs represent missing values; read with `na = ""` to preserve literal name keys such as `NA`.
## Dog columns
| Column | Type | Meaning |
| --- | --- | --- |
| `estimated_dog_id` | Text | `dog2024-` plus the retained source row number, padded to six digits. Stable within this snapshot and rule, not an official ID or a cross-year identity. |
| `source_row_id` | Integer | One-based data row of the retained license in the raw CSV, excluding its header. |
| `extract_year` | Integer | Selected NYC extract, 2024; not necessarily the license issue year. |
| `name_original` | Text | Name on the retained license, unchanged. |
| `name_key` | Text | Full name uppercased with spaces and hyphens removed; no first-token, nickname or title substitution. |
| `sex` | Text | Recorded dog sex (`F` or `M` in this snapshot). Dog sex does not constrain SSA name matching. |
| `birth_year` | Text | Recorded birth year, including malformed values; never guessed or repaired. |
| `breed` | Text | Recorded breed, including `Unknown`; no breed-alias consolidation. |
| `zipcode_original` | Text | ZIP as published on the retained license. |
| `zipcode` | Text | Five-character ZIP representation: digit-only source values of up to five digits are left-padded with zeros. This is not confirmation of valid NYC geography. |
| `license_issue_date` | Date | Issue date of the retained license, `YYYY-MM-DD`. |
| `license_expiry_date` | Date | Expiry date of the retained license, `YYYY-MM-DD`. |
| `license_record_count` | Integer | Number of named source license records assigned to this estimated dog. |
| `original_name_variants` | Integer | Distinct original name strings within the five-field group; all are 1 in this snapshot. |
| `latest_issue_ties` | Integer | Number of group records sharing its latest issue date; values above 1 invoke the expiry/date-row tie rule. |
| `compound_name` | Boolean | Retained original name has internal whitespace or an internal ASCII hyphen. |
| `any_compound_name` | Boolean | At least one source name in the group has that pattern. This equals `compound_name` for the current snapshot. |
| `breed_unknown` | Boolean | Recorded breed is `Unknown` or blank, ignoring case and outer whitespace for this flag only. |
| `birth_year_suspect` | Boolean | Birth year is not four digits or lies outside 1990–2024. This is a screening flag, not an age exclusion or a correction. |
| `sex_unknown` | Boolean | Recorded sex is neither `F` nor `M`. |
| `zipcode_padded` | Boolean | The five-character representation differs from the published ZIP. |
| `zipcode_invalid` | Boolean | The resulting ZIP is not exactly five digits. Valid syntax does not imply a geographic match. |
| `identity_uncertain` | Boolean | Any of `breed_unknown`, `birth_year_suspect`, `sex_unknown` or `zipcode_invalid` is true. Records remain in the output. All other identities are still estimates. |
| `ssa_recognized` | Boolean | Full normalized name appears in a published SSA record in any selected year: 1920–1929, 1970–1979 or 2010–2019. |
| `top100_1920` | Boolean | Name is among the 100 largest combined-sex SSA birth counts summed over 1920–1929. |
| `top100_1970` | Boolean | Same definition for 1970–1979. |
| `top100_2010` | Boolean | Same definition for 2010–2019. |

The five-field group key is `name_key`, `sex`, `birth_year`, `breed`, `zipcode`. Select greatest issue date, then greatest expiry date, then smallest `source_row_id`. No uncertain field is imputed. The three decade flags can overlap, and percentages using them need not sum to 100%. A false recognition flag means absent from this reference, not proven non-human.
## Supporting tables
| File | Row unit and key | Purpose |
| --- | --- | --- |
| [ssa_name_reference.csv](derived/ssa_name_reference.csv) | One normalized name; `name_key` unique | Broad recognition and three decade measures. Join many dogs to one reference row. |
| [ssa_name_decades.csv](derived/ssa_name_decades.csv) | One observed name/decade; `(name_key, decade)` unique | Long version showing aggregation, ranking and the input to the wide reference. |
| [license_to_dog.csv](derived/license_to_dog.csv) | One raw license record; `source_row_id` unique | Maps every source record to its estimated dog and retained row, or to `missing_name` with empty IDs. Other statuses are `retained` and `consolidated`. |
| [missing_names_by_zip.csv](derived/missing_names_by_zip.csv) | One extract/ZIP | Counts all source license records, missing-name records, named records and missing-name share. These are record counts, not dog counts. |
| [missing_name_labels.csv](derived/missing_name_labels.csv) | One missing label | Counts the six selected source labels. |
| [quality_flags.csv](derived/quality_flags.csv) | One unit/flag | Compares flagged counts among named license records and estimated dogs. |
| [matching_by_counting_unit.csv](derived/matching_by_counting_unit.csv) | One unit/measure | Recognition and decade shares when weighting estimated dogs equally versus weighting by their license-record counts. |
| [ssa_top100_cutoffs.csv](derived/ssa_top100_cutoffs.csv) | One decade | Names and counts at ranks 100/101 and whether the cutoff is tied. |
| [stage_counts.csv](derived/stage_counts.csv) | One processing stage/measure | Count reconciliation from source to handoff. |
| [validation_checks.csv](derived/validation_checks.csv) | One check | Pass/fail results from independently re-reading saved files. |
| [runtime_versions.csv](derived/runtime_versions.csv) | One package/runtime | Versions used for validation. |

In the SSA tables, `births` sums published counts across sex and all ten years in that decade. `share` divides by the decade's total published counts; suppressed names are not part of that denominator. `rank` orders descending counts and then alphabetically in C locale. `top100` is `rank <= 100`. The wide table uses suffixes `_1920`, `_1970`, `_2010`; an absent decade has zero births/share, false membership and an empty rank. Every reference row has `ssa_recognized = TRUE`.

## Import the dog table in R
Read ZIP codes and recorded birth years as text. Use an empty string as the missing-value marker so a literal name such as `NA` survives import.

```r
library(tidyverse)

dogs <- read_csv(
  "data/derived/dogs_2024.csv", na = "",
  col_types = cols(
    zipcode = col_character(),
    zipcode_original = col_character(),
    birth_year = col_character()
  )
)
```
