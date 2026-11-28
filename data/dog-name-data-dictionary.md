# Dog-name data dictionary
These are in-memory objects created by dog-names.qmd, baby-names.qmd, dog-baby-matching.qmd and the optional license-consolidation sensitivity appendix; they are not exported CSVs. dogs_prepared contains 96,810 eligible named estimated dogs after early exclusion of missing names and unusable birth years. Baby preparation supplies separate decade and overall name lists. Matching produces dogs_with_baby_name_measures with one row per estimated dog, name recognition, decade lists and weighted average baby birth year. There is no geographic or income selection in this pipeline.

The notebook imports ZIP codes as text and infers the other types, using standard missing-value and whitespace handling, numbers source rows, gives fields clear working names, and counts and excludes existing missing values and the agreed missing-name labels without recoding them. It records compound names before formatting. ZIP strings stay as recorded. source_row_id points to the original license in the source CSV. No duplicate original_ columns are carried through the comparison tables.
## Dog columns
| Column | Type | Meaning |
| --- | --- | --- |
| `source_row_id` | Integer | One-based data row of the retained license in the raw CSV, excluding its header. |
| `name` | Text | Full name uppercased with spaces and hyphens removed; no first-token, nickname or title substitution. |
| `sex` | Text | Recorded dog sex (`F` or `M` in this snapshot). Dog sex does not constrain SSA name matching. |
| `birth_year` | Number | Recorded birth year, with no inferred replacements. Issue year minus recorded birth year must be from 0 through 25. This approximate-age cutoff is a judgment call. |
| `breed` | Text | Recorded breed, including `Unknown`; no breed-alias consolidation. |
| `zipcode` | Text | ZIP recorded on the earliest observed license in the estimated dog group, without added zeros or a geographic lookup. |

The provisional consolidation removes repeated identity/date records, then prioritizes likely license-term changes: matching name, sex, birth year, breed and ZIP, issues 1–14 days apart, and shared expiry month/day with a later expiry year. Unambiguous term-change pairs retain the later license for renewal matching; all source rows remain in the correspondence table. It then considers pairs sharing `name`, `sex`, `birth_year` and `breed`. A renewal requires a strictly later issue date within 30 days of the earlier expiry in the same ZIP, or 7 days across ZIPs, and a later expiry. Same-ZIP renewal and correction candidates are assessed first. Unambiguous accepted connections take priority; cross-ZIP candidates then compete only for directions not already assigned. Both endpoints must have a unique candidate counterpart in the relevant direction within that stage. Accepted links form chronological chains; the earliest observed license supplies the retained fields and ZIP. This is a proxy for location around naming, not a verified first license or naming location; this extract can omit earlier records, ownership can change, and neighborhood income is not individual owner income. Same-day differing records and competing links are not automatically resolved. Possible expiry corrections are allowed within five days in the same ZIP, with unchanged formatted name, sex, birth year and breed and a changed expiry. The window is provisional. Different names are excluded even from correction inspection. These are identity assumptions, not verified individual dogs. The optional [birth-year reference](../appendices/birth-year-inferences.qmd) preserves considered inferences but does not apply them to these tables. A name can appear in several decade lists; those lists are not mutually exclusive.
## Tables used in the pipeline
| R object | One row represents | Purpose |
| --- | --- | --- |
| dogs_prepared | One estimated dog | Cleaned fields before baby-name matching. |
| dogs_with_baby_name_measures | One estimated dog | Original dog fields plus name_appears_in_ssa, top100_decades, peak_birth_count_decades, best_rank_decades and average_baby_birth_year. Decade columns contain numeric lists; unmatched lists are NULL and unmatched average years are NA. |
| baby_names_yearly_prepared | One published name/sex/year record | Formatted name, year, decade and published birth count. |
| baby_names_rank_by_decade_prepared | One name/decade | Combined birth counts and ranks. |
| baby_names_peak_birth_count_decade | One name and a decade tied for its largest birth count | `peak_birth_count_decade` and `peak_birth_count` across the selected years. |
| baby_names_best_rank_decade | One name and a decade tied for its highest rank | Highest-ranked decades under the existing alphabetically tie-broken ranking. |
| baby_names_average_birth_year | One recorded SSA name | Birth-count-weighted average birth year across 1880–2019 and both sex categories. |
| all_distinct_baby_names | One recorded SSA name | 99,538 distinct formatted names in a one-column table, including names outside the top 100. |
| baby_names_top100_by_decade_prepared | One name in one decade's top 100 | 1,400 rows containing only decade and name. |
| excluded_birth_year_licenses | One excluded named license | The 59 excluded licenses, with recorded fields and approximate ages. |
| missing_by_zip | One recorded ZIP | Source-license counts, missing-name counts and missing-name shares for the 2024 extract, combining the six agreed labels. |
| license_links | One candidate link | Reason, dates, ZIP agreement, competing-candidate counts and whether the working rule accepts it. |
| license_groups_table | One distinct prepared license | Source-row identifier and its estimated-dog group, updated through table lookups. |
| license_membership | One eligible source license | Its internal group, including correspondence for repeated copies; not exported in the dog table. |
| consolidation_sensitivity | One alternative rule, in the appendix | Windows, estimated dogs, records consolidated, cross-ZIP links and licenses with competing options. |
| possible_identity_corrections | Appendix: one pair differing in sex, birth year or breed, with matching name and other identity fields | Both values and license dates, within 14 days; inspection only. |
| possible_license_corrections | Appendix: one same-identity pair issued within 14 days | ZIP/expiry differences, including same-day records; inspection only. |
| consolidation_example_outcomes | Appendix: one displayed license under one rule | Retained source row and whether the displayed record supplies the final values; allows comparisons between rules. |
| license_timeline_records | Appendix: one displayed license | Exact source rows and dates for the aligned timeline plot. |
| consolidation_summary | One overall summary | 100,105 eligible licenses, 96,810 estimated dogs and 3,295 additional license records consolidated. |

The dog-level cleaning summary counts these characteristics on each estimated dog's retained license. Its per-record report fields are left out of the comparison tables. The birth-year section separately reports the excluded licenses.

| Report column | Meaning |
| --- | --- |
| `dogs_with_unknown_breed` | Number of estimated dogs whose breed is recorded as `Unknown`, the only unknown-breed spelling in this snapshot. |
| `dogs_with_compound_names` | Number of estimated dogs whose recorded name contains internal whitespace or an internal ASCII hyphen, counted before name formatting. |

In baby_names_rank_by_decade_prepared, `births` sums published counts across sex and all ten years in that decade. `rank` numbers names within each decade after sorting by descending birth count and then alphabetically. baby_names_top100_by_decade_prepared keeps rows with `rank <= 100`, retaining just the decade and name.
