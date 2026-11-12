# Dog-name data dictionary
The primary file is [dogs_2024.csv](derived/dogs_2024.csv), one row per eligible named estimated dog under the five-field rule: 92,921 dogs after early exclusion of missing names and unusable birth years. Read ZIP codes and birth years as text. Empty fields in the audit represent missing links for excluded records; use `na = ""` when importing the saved outputs.
The notebook reads the six missing-name labels as missing values, renames the working fields once, and records compound names before changing their formatting. ZIP strings stay as recorded. source_row_id links every retained dog or excluded license to its original values in the unchanged source CSV. The exported dog tables do not contain duplicate original_ fields.
## Dog columns
| Column | Type | Meaning |
| --- | --- | --- |
| `estimated_dog_id` | Text | `dog2024-` plus the retained source row number, padded to six digits. Stable within this snapshot and rule, not an official ID or a cross-year identity. |
| `source_row_id` | Integer | One-based data row of the retained license in the raw CSV, excluding its header. |
| `extract_year` | Integer | Selected NYC extract, 2024; not necessarily the license issue year. |
| `name` | Text | Full name uppercased with spaces and hyphens removed; no first-token, nickname or title substitution. |
| `sex` | Text | Recorded dog sex (`F` or `M` in this snapshot). Dog sex does not constrain SSA name matching. |
| `birth_year` | Text | Recorded birth year, with no inferred replacements. Only four-digit years from 1990–2024 enter grouping and export. |
| `breed` | Text | Recorded breed, including `Unknown`; no breed-alias consolidation. |
| `zipcode` | Text | Recorded ZIP string, without added zeros. The selected NYC comparison contains only five-digit ZIPs; the broader prepared table also retains 40 short ZIP strings outside that comparison. |
| `license_issue_date` | Date | Issue date of the retained license, `YYYY-MM-DD`. |
| `license_expiry_date` | Date | Expiry date of the retained license, `YYYY-MM-DD`. |
| `license_record_count` | Integer | Number of named source license records assigned to this estimated dog. |
| `ssa_recognized` | Boolean | Full normalized name appears in a published SSA record in any selected year: 1880–2019. |
| `top100_1880` … `top100_2010` | Boolean | One column per complete decade. True when the name is among its 100 largest combined-sex birth counts. |

The five-field group key uses `name`, `sex`, the recorded `birth_year`, `breed` and `zipcode`. Exclude missing-name and unusable-year licenses before grouping. Select greatest issue date, then greatest expiry date, then smallest `source_row_id`. The optional [birth-year reference](../birth-year-inferences.qmd) preserves considered inferences but does not apply them to these tables. The 14 decade flags can overlap, and percentages using them need not sum to 100%. A false recognition flag means absent from this reference, not proven non-human.
## Income comparison columns
[dogs_income_2024.csv](derived/dogs_income_2024.csv) contains 92,541 selected dogs with all the dog/name fields above and the following income fields. Their ZIPs map to areas on the published city list and have an ordinary or open-ended income estimate. Boundary overlap with areas outside NYC is accepted. This table supplies both counting-unit comparisons; the broader dog/name handoff remains available separately.

| Column | Type | Meaning |
| --- | --- | --- |
| `income_group` | Text | Area median household income band: `Under $50,000`, `$50,000–99,999`, `$100,000–149,999` or `$150,000+`. An exact boundary value belongs to the higher band; `top_coded` belongs to `$150,000+`. R uses this low-to-high display order. |
| `zcta` | Text | Five-character Census area code from the ZIP crosswalk. Several ZIPs may share one area. |
| `median_household_income` | Number or missing | ACS median household income in dollars when an ordinary estimate is available. Empty for an open-ended amount; consult `income_status`. |
| `income_margin_of_error` | Number or missing | Published ACS margin of error in dollars where available. |
| `income_status` | Text | `estimate` is an ordinary estimate; `top_coded` means $250,000+; `bottom_coded` means the source's $2,500- category. The selected snapshot has no bottom-coded dogs. Capped cases remain included even though their exact numeric estimate is empty. |
| `acs_release` | Integer | ACS release used, 2024. |
| `acs_period` | Text | Five-year period represented by that release, 2020–2024. |

The input lookup preserves Shweta's source values, including reporting codes such as `250001`. The selected table clears those codes from the numeric estimate so they are not treated as exact incomes. Income describes the area associated with the recorded owner's ZIP, not the owner's personal wealth.
## Supporting tables
| File | Row unit and key | Purpose |
| --- | --- | --- |
| [dogs_income_2024.csv](derived/dogs_income_2024.csv) | One selected estimated dog | Dog/name fields plus income for the 92,541 dogs in the NYC comparison. |
| [income_group_counts.csv](derived/income_group_counts.csv) | One income group | Estimated-dog count and distinct-ZCTA neighborhood count in each of the four selected bands; totals are 92,541 dogs and 190 neighborhoods. |
| [income_exclusions.csv](derived/income_exclusions.csv) | One excluded estimated dog; `estimated_dog_id` unique | Source row, name, ZIP, available lookup details and exclusion reason for each of the 380 dogs omitted from income comparisons. |
| [income_comparison_counts.csv](derived/income_comparison_counts.csv) | One inclusion/exclusion status | Counts included dogs and each exclusion reason, totaling the 92,921 prepared dogs. |
| [dogs_prepared_2024.csv](derived/dogs_prepared_2024.csv) | One estimated dog | Prepared dog fields before baby-name matching. |
| [ssa_name_reference.csv](derived/ssa_name_reference.csv) | One normalized name; `name` unique | Recognition across 1880–2019 and 14 decade measures. Join many dogs to one reference row. |
| [ssa_name_decades.csv](derived/ssa_name_decades.csv) | One observed name/decade; `(name, decade)` unique | Long version showing aggregation, ranking and the input to the wide reference. |
| [license_to_dog.csv](derived/license_to_dog.csv) | One raw license record; `source_row_id` unique | Usable records link to their estimated dog and retained row as `retained` or `consolidated`. The 5,810 missing-name licenses have `missing_name`; the 45 named licenses with unusable years have `excluded_birth_year`. Both excluded categories have empty dog IDs and retained-source IDs because they do not enter grouping. |
| [excluded_birth_year_licenses.csv](derived/excluded_birth_year_licenses.csv) | One excluded named license; `source_row_id` unique; 45 rows | Short column names with the unmodified recorded values, including name, birth year, ZIP and date text. These rows do not enter formatting or dog grouping. |
| [missing_names_by_zip.csv](derived/missing_names_by_zip.csv) | One extract/recorded ZIP | Counts all source license records, missing-name records, named records and missing-name share. Combines the six labels `UNKNOWN`, `NAME NOT PROVIDED`, `NONE`, `NA`, `.`, and `NONAME`. These are record counts, not dog counts. |
| [quality_flags.csv](derived/quality_flags.csv) | One unit/measure | Counts formatting and breed findings among usable licenses and estimated dogs, plus dogs with tied latest issue dates. `excluded_birth_year` separately counts the 45 named licenses removed before grouping. |
| [name_matches_by_income.csv](derived/name_matches_by_income.csv) | One income group/name measure; 60 rows | `matching_dogs` counts matches once per estimated dog; `dogs` is the full selected dog count in that income group; `neighborhoods` counts distinct ZCTAs; `share = matching_dogs / dogs`. Measures are overall SSA recognition and 14 overlapping decade flags. |
| [dog_names_by_income.csv](derived/dog_names_by_income.csv) | One observed name/income group; 24,864 rows | `dogs_with_name` counts estimated dogs with the name; `dogs` and `neighborhoods` are full income-band totals; `share = dogs_with_name / dogs`. `rank` orders descending name counts, breaking ties alphabetically. Names absent from a band have no row. |
| [decade_name_contributions.csv](derived/decade_name_contributions.csv) | One name/decade among top-100 names observed in either extreme income band; 1,153 rows | `lowest_income_share` and `highest_income_share` use all dogs in their respective bands; absence from one band supplies zero. `difference_percentage_points = 100 * (highest_income_share - lowest_income_share)`. Summing contributions within a decade reproduces its total group difference. A name can contribute to several decades. |
| [name_matches_by_neighborhood.csv](derived/name_matches_by_neighborhood.csv) | One ZCTA/name measure; 2,850 rows | Each of the 190 represented neighborhoods has all 15 measures. `dogs` is its selected dog count; `matching_dogs` counts matches within it; `share = matching_dogs / dogs`. This descriptive table does not change the main charts' equal-dog weighting. |
| [matching_by_counting_unit.csv](derived/matching_by_counting_unit.csv) | One unit/measure | Recognition and decade shares for the 92,541 NYC income-comparison dogs, weighted equally or by their license-record counts. |
| [ssa_top100_cutoffs.csv](derived/ssa_top100_cutoffs.csv) | One decade | Names and counts at ranks 100/101 and whether the cutoff is tied. |
| [stage_counts.csv](derived/stage_counts.csv) | One processing stage/measure | Counts measured from the source and saved tables in the checks notebook. |
| [validation_checks.csv](derived/validation_checks.csv) | One check | Pass/fail results from independently re-reading saved files. |
| [runtime_versions.csv](derived/runtime_versions.csv) | One package/runtime | Versions used for validation. |

The income exclusion reasons are `zip_not_in_ny_lookup` (88 dogs), `outside_nyc_area_list` (275) and `income_unavailable` (17). They are assigned in that order, so each excluded dog appears once. Lookup failures do not establish invalid ZIPs. The selected dog table omits this temporary classification.

The cleaning report contains these measures; their per-record fields are not exported in the dog tables.

| Measure | Meaning |
| --- | --- |
| `breed_unknown` | Breed is `Unknown` or blank, ignoring case and outer whitespace. |
| `excluded_birth_year` | Named licenses whose recorded years are not four digits within 1990–2024: 45 licenses excluded before grouping. The independent stage-count check finds 42 distinct five-field keys among them. |
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
