# Dog-name data dictionary
These are R tables created during one execution of analysis.qmd; they are not exported CSVs. dogs_prepared contains 92,921 eligible named estimated dogs after early exclusion of missing names and unusable birth years. dogs adds baby-name matches to those same rows. There is no geographic or income selection in this pipeline.

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
| `zipcode` | Text | Recorded ZIP string, without added zeros or a geographic lookup. |
| `license_issue_date` | Date | Issue date of the retained license, `YYYY-MM-DD`. |
| `license_expiry_date` | Date | Expiry date of the retained license, `YYYY-MM-DD`. |
| `license_record_count` | Integer | Number of named source license records assigned to this estimated dog. |
| `ssa_recognized` | Boolean | Full normalized name appears in a published SSA record in any selected year: 1880–2019. |
| `top100_1880` … `top100_2010` | Boolean | One column per complete decade. True when the name is among its 100 largest combined-sex birth counts. |

The five-field group key uses `name`, `sex`, the recorded `birth_year`, `breed` and `zipcode`. Exclude missing-name and unusable-year licenses before grouping. Select greatest issue date, then greatest expiry date, then smallest `source_row_id`. The optional [birth-year reference](../appendices/birth-year-inferences.qmd) preserves considered inferences but does not apply them to these tables. The 14 decade flags can overlap, and percentages using them need not sum to 100%. A false recognition flag means absent from this reference, not proven non-human.
## Tables used in the pipeline
| R object | One row represents | Purpose |
| --- | --- | --- |
| dogs_prepared | One estimated dog | Cleaned fields before baby-name matching. |
| dogs | One estimated dog | Dog fields plus SSA recognition and decade matches. |
| ssa_decades | One name/decade | Combined birth counts, ranks and shares before making a wide reference. |
| ssa_reference | One formatted name | Recognition and 14 decade measures; each dog joins to at most one row. |
| ssa_cutoffs | One decade | Names and birth counts at ranks 100 and 101. |
| excluded_birth_year_licenses | One excluded named license | The 45 recorded rows with unusable years. |
| missing_by_zip | One recorded ZIP | Source-license counts, missing-name counts and missing-name shares for the 2024 extract, combining the six agreed labels. |
| quality_summary | One unit/measure | Counts of unknown breeds, compound names, excluded years and tied latest licenses. |

The cleaning report contains these measures; their per-record fields are left out of the comparison tables.

| Measure | Meaning |
| --- | --- |
| `breed_unknown` | Breed is `Unknown` or blank, ignoring case and outer whitespace. |
| `excluded_birth_year` | Named licenses whose recorded years are not four digits within 1990–2024: 45 licenses excluded before grouping. |
| `compound_name` | Recorded name contains internal whitespace or an internal ASCII hyphen. For estimated dogs, this uses the retained license. |
| `latest_issue_ties` | Number of estimated dogs with multiple licenses sharing their latest issue date. The expiry-date and source-row sorting resolves the tie. This measure is reported only at dog level. |

In the SSA tables, `births` sums published counts across sex and all ten years in that decade. `share` divides by the decade's total published counts; suppressed names are not part of that denominator. `rank` orders descending counts and then alphabetically in C locale. `top100` is `rank <= 100`. The wide table uses decade suffixes from `_1880` through `_2010`; an absent decade has zero births/share, false membership and an empty rank. Every reference row has `ssa_recognized = TRUE`.
