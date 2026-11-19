# Dog-name data dictionary
These are in-memory objects created by dog-names.qmd and baby-names.qmd; they are not exported CSVs. dogs_prepared contains 92,908 eligible named estimated dogs after early exclusion of missing names and unusable birth years. Baby preparation supplies separate decade and overall name lists. Matching awaits review and is not executed in final-analysis.qmd. There is no geographic or income selection in this pipeline.

The notebook imports ZIP codes as text and infers the other types, using standard missing-value and whitespace handling, numbers source rows, gives fields clear working names, and converts the remaining missing-name labels before reporting and excluding them. It records compound names before formatting. ZIP strings stay as recorded. source_row_id points to the original license in the source CSV. No duplicate original_ columns are carried through the comparison tables.
## Dog columns
| Column | Type | Meaning |
| --- | --- | --- |
| `source_row_id` | Integer | One-based data row of the retained license in the raw CSV, excluding its header. |
| `name` | Text | Full name uppercased with spaces and hyphens removed; no first-token, nickname or title substitution. |
| `sex` | Text | Recorded dog sex (`F` or `M` in this snapshot). Dog sex does not constrain SSA name matching. |
| `birth_year` | Number | Recorded birth year, with no inferred replacements. Issue year minus recorded birth year must be from 0 through 25. This approximate-age cutoff is a judgment call. |
| `breed` | Text | Recorded breed, including `Unknown`; no breed-alias consolidation. |
| `zipcode` | Text | Recorded ZIP string, without added zeros or a geographic lookup. |

The five-field group key uses `name`, `sex`, the recorded `birth_year`, `breed` and `zipcode`. Exclude missing-name and unusable-year licenses before grouping. Select the latest issue date; if dates tie, keep the first license in source-file order. The optional [birth-year reference](../appendices/birth-year-inferences.qmd) preserves considered inferences but does not apply them to these tables. A name can appear in several decade lists; those lists are not mutually exclusive.
## Tables used in the pipeline
| R object | One row represents | Purpose |
| --- | --- | --- |
| dogs_prepared | One estimated dog | Cleaned fields before baby-name matching. |
| ssa_decades | One name/decade | Combined birth counts, ranks and top-100 membership. |
| ssa_top100_names | One name in one decade's top 100 | 1,400 rows containing only decade and name. |
| excluded_birth_year_licenses | One excluded named license | The 59 excluded licenses, with recorded fields and approximate ages. |
| missing_by_zip | One recorded ZIP | Source-license counts, missing-name counts and missing-name shares for the 2024 extract, combining the six agreed labels. |
| consolidation_summary | One overall summary | 100,105 eligible licenses, 92,908 estimated dogs and 7,197 additional license records consolidated. |

The dog-level cleaning summary counts these characteristics on each estimated dog's retained license. Its per-record report fields are left out of the comparison tables. The birth-year section separately reports the excluded licenses.

| Report column | Meaning |
| --- | --- |
| `dogs_with_unknown_breed` | Number of estimated dogs whose breed is recorded as `Unknown`, the only unknown-breed spelling in this snapshot. |
| `dogs_with_compound_names` | Number of estimated dogs whose recorded name contains internal whitespace or an internal ASCII hyphen, counted before name formatting. |

The character vector `ssa_all_names` contains each of the 99,538 formatted names found in the selected SSA years once, including names outside the top 100. It is separate from the tables above.

In ssa_decades, `births` sums published counts across sex and all ten years in that decade. `rank` numbers names within each decade after sorting by descending birth count and then alphabetically. `top100` is `rank <= 100`. ssa_top100_names keeps those selected names by decade.
