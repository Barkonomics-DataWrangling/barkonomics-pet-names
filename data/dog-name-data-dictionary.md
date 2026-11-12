# Dog-name data dictionary
These are R tables created during one execution of analysis.qmd; they are not exported CSVs. dogs_prepared contains 92,921 eligible named estimated dogs after early exclusion of missing names and unusable birth years. dogs adds baby-name matches, and dogs_for_income_comparison selects 92,541 dogs with the required geography and income information.

The notebook reads the six missing-name labels as missing values, gives fields clear working names, and records compound names before formatting. ZIP strings stay as recorded. source_row_id points to the original license in the source CSV. No duplicate original_ columns are carried through the comparison tables.
## Dog columns
| Column | Type | Meaning |
| --- | --- | --- |
| `estimated_dog_id` | Text | `dog2024-` plus the retained source row number, padded to six digits. Stable within this snapshot and rule, not an official ID or a cross-year identity. |
| `source_row_id` | Integer | One-based data row of the retained license in the raw CSV, excluding its header. |
| `extract_year` | Integer | Selected NYC extract, 2024; not necessarily the license issue year. |
| `name` | Text | Full name uppercased with spaces and hyphens removed; no first-token, nickname or title substitution. |
| `sex` | Text | Recorded dog sex (`F` or `M` in this snapshot). Dog sex does not constrain SSA name matching. |
| `birth_year` | Text | Recorded birth year, with no inferred replacements. Only four-digit years from 1990–2024 enter grouping. |
| `breed` | Text | Recorded breed, including `Unknown`; no breed-alias consolidation. |
| `zipcode` | Text | Recorded ZIP string, without added zeros. The selected NYC comparison contains only five-digit ZIPs; the broader prepared table also retains 40 short ZIP strings outside that comparison. |
| `license_issue_date` | Date | Issue date of the retained license, `YYYY-MM-DD`. |
| `license_expiry_date` | Date | Expiry date of the retained license, `YYYY-MM-DD`. |
| `license_record_count` | Integer | Number of named source license records assigned to this estimated dog. |
| `ssa_recognized` | Boolean | Full normalized name appears in a published SSA record in any selected year: 1880–2019. |
| `top100_1880` … `top100_2010` | Boolean | One column per complete decade. True when the name is among its 100 largest combined-sex birth counts. |

The five-field group key uses `name`, `sex`, the recorded `birth_year`, `breed` and `zipcode`. Exclude missing-name and unusable-year licenses before grouping. Select greatest issue date, then greatest expiry date, then smallest `source_row_id`. The optional [birth-year reference](../appendices/birth-year-inferences.qmd) preserves considered inferences but does not apply them to these tables. The 14 decade flags can overlap, and percentages using them need not sum to 100%. A false recognition flag means absent from this reference, not proven non-human.
## Income comparison columns
dogs_for_income_comparison contains 92,541 selected dogs with all the dog/name fields above and the following income fields. Their ZIPs map to areas on the published city list and have an ordinary or open-ended income estimate. Boundary overlap with areas outside NYC is accepted. This table supplies both counting-unit comparisons; the broader dogs table remains available in the same R session.

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
## Tables used in the pipeline
| R object | One row represents | Purpose |
| --- | --- | --- |
| dogs_prepared | One estimated dog | Cleaned fields before baby-name matching. |
| dogs | One estimated dog | Dog fields plus SSA recognition and decade matches. |
| dogs_for_income_comparison | One selected estimated dog | Dog/name fields and income for the 92,541 dogs in the comparison. |
| ssa_decades | One name/decade | Combined birth counts, ranks and shares before making a wide reference. |
| ssa_reference | One formatted name | Recognition and 14 decade measures; each dog joins to at most one row. |
| ssa_cutoffs | One decade | Names and birth counts at ranks 100 and 101. |
| excluded_birth_year_licenses | One excluded named license | The 45 recorded rows with unusable years. |
| missing_by_zip | One extract/recorded ZIP | License counts and missing-name shares, combining the six agreed labels. |
| quality_summary | One unit/measure | Counts of unknown breeds, compound names, excluded years and tied latest licenses. |
| income_exclusions | One excluded estimated dog | Source row, name, ZIP, available lookup details and reason for each of the 380 exclusions. |
| income_comparison_counts | One inclusion/exclusion status | Counts accounting for all 92,921 prepared dogs. |
| income_group_counts | One income group | Dog and distinct-ZCTA counts for each band. |
| matching_comparison | One counting unit/name measure | Matching shares with equal dog weights or license-record weights. |
| name_matches_by_income | One income group/name measure | Matching dogs, all dogs in the group and their matching share; 60 rows. |
| dog_names_by_income | One observed name/income group | Count, share and rank of each name within its group. |
| decade_name_contributions | One name/decade | Each name's contribution to the highest-minus-lowest income-group difference, in percentage points. |
| name_matches_by_neighborhood | One ZCTA/name measure | Matching dogs and shares within each represented area. |

The income exclusion reasons are `zip_not_in_ny_lookup` (88 dogs), `outside_nyc_area_list` (275) and `income_unavailable` (17). They are assigned in that order, so each excluded dog appears once. Lookup failures do not establish invalid ZIPs. The selected dog table omits this temporary classification.

The cleaning report contains these measures; their per-record fields are left out of the comparison tables.

| Measure | Meaning |
| --- | --- |
| `breed_unknown` | Breed is `Unknown` or blank, ignoring case and outer whitespace. |
| `excluded_birth_year` | Named licenses whose recorded years are not four digits within 1990–2024: 45 licenses excluded before grouping. |
| `compound_name` | Recorded name contains internal whitespace or an internal ASCII hyphen. For estimated dogs, this uses the retained license. |
| `latest_issue_ties` | Number of estimated dogs with multiple licenses sharing their latest issue date. The expiry-date and source-row sorting resolves the tie. This measure is reported only at dog level. |

In the SSA tables, `births` sums published counts across sex and all ten years in that decade. `share` divides by the decade's total published counts; suppressed names are not part of that denominator. `rank` orders descending counts and then alphabetically in C locale. `top100` is `rank <= 100`. The wide table uses decade suffixes from `_1880` through `_2010`; an absent decade has zero births/share, false membership and an empty rank. Every reference row has `ssa_recognized = TRUE`.
