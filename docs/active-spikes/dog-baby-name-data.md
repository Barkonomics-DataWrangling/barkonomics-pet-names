---
attention: live
reviewed: 2026-11-12
tags: [barkonomics, dog-data, baby-names, r]
---
# Dog and baby-name data
## Purpose and ownership
Prepare Aslan's dog-license and SSA baby-name portion under [issue #1](https://github.com/Barkonomics-DataWrangling/barkonomics-pet-names/issues/1), starting in R. This spike belongs to the agent working in the current planning conversation. [Tasks and evidence](dog-baby-name-data.todo.md) track execution. Shweta owns income and ZIP–ZCTA preparation under [issue #2](https://github.com/Barkonomics-DataWrangling/barkonomics-pet-names/issues/2); shared research definitions and the integration contract remain joint decisions.

Aslan authorized completing the first handoff after selecting the research and cleaning rules, including retaining recorded identifying attributes and reporting preparation findings separately. The R contribution uses simple, explainable course techniques for his individual interview. The assignment prioritizes demonstrating data cleaning and preparation; finding a statistical association is not required. The user requires branch-based work, spike records, and eventual publication through an issue-linked PR that makes changes, review and acceptance inspectable to Shweta. The [three notebooks](../../data/README.md#generate-and-check-the-handoff) contain the implementation, with checks in a separate notebook; issue #1 and its eventual PR own coordination and review. This does not establish that Shweta has reviewed or accepted any choices.
## Research frame
Ask whether dog names differ across higher- and lower-income NYC neighborhoods, and whether their names match different baby-name decades. Diffusion between socioeconomic groups and eventually to dog names is the motivating hypothesis. The available national baby-name counts and 2024 dog licenses can describe generational associations. They do not identify a historical sequence of naming by household income.

Use the top 100 names in every complete SSA decade from 1880–2019. Sum across years and sex, rank by birth count and break ties alphabetically. A name may match multiple decades. Overall recognition uses published records across those complete decades. Keep one reference row per formatted name when joining to dogs.
## Contribution context
The local contribution branch is `aslan/dog-name-review`, created from verified remote main `992bc8b1c2b96d030da7c9c5ad63b330b8a6e53c`. The existing issue is the shared outcome and acceptance record; this spike holds the detailed reasoning and execution evidence. Keep public-source findings and project decisions here; private meeting material remains with its owner.

Use the project's adopted contribution, spike and commit procedures and selected GitHub tooling. Preserve original atomic commits and include the spike records in review. A draft PR should describe its scope, source acquisition, transformations, validation, unresolved choices and remaining issue acceptance. Partial work references issue #1 without claiming completion. Check current formal-link and auto-close behavior before publication; merge, issue acceptance and spike closure are distinct steps. No commit, push, GitHub mutation or integration has been performed for this contribution.
## Acquisition and storage discussion
Data can live inside the project folder independently of whether Git tracks it. Reproducibility requires the same source snapshot across collaborators and the eventual R, pandas, DuckDB and Power Query implementations. Re-downloading an evolving source URL is not a guarantee of the same bytes.

Implemented layout; source snapshots and the generated handoff remain separate:

```text
data/
  README.md          # Source descriptions, acquisition and regeneration instructions.
  sources.csv        # Exact source URLs, selection, retrieval date, checksums and counts.
  raw/               # Preserved source downloads or selected exports.
  derived/           # Regenerable cleaned and joined outputs.
dog-names.qmd        # Prepare estimated dogs.
baby-names.qmd       # Prepare baby-name decades.
analysis.qmd         # Match names and compare areas.
dog-names-checks.qmd # Independently check saved results.
birth-year-inferences.qmd # Optional reference; never writes prepared data.
helpers.R           # Shared table preview function.
```

Keep fixed source snapshots and generated results in Git. The dog CSV is 11,139,556 bytes. All 146 annual SSA text files and the source readme are saved directly in data/raw/ssa/, totaling 28,255,978 bytes. Analysis reads those files directly. Acquisition details are in the data README and source inventory.

Use 2024 as the starting dog extract, following Aslan's November 5 direction. This is the initial working choice, not a decision to pool years or claim unique dogs. For SSA, the national bulk download offers the reference source; preserve its readme and derive the chosen time window explicitly. Initial profiling should report schema, row counts, missingness and duplicate-looking records before adopting irreversible cleaning assumptions.
## Implementation approach
The [R notebook](../../dog-names.qmd) uses named tidyverse transformations with inspectable intermediate tables. The [course R introduction](https://howisonlab.github.io/datawrangling/current/rtidyverse/tidyverse_intro.html) supplies filtering/selecting, new columns, lookup joins, grouped aggregation and ranking/windowing. The [grouping material](https://howisonlab.github.io/datawrangling/current/data_transforms/group_aggregate.html) explains how a group is reduced to a summary or a selected set of rows. Comments explain the purpose of each step, and the [separate checks notebook](../../dog-names-checks.qmd) re-reads the saved outputs. Walk through the input grain, transformation and output grain so Aslan can explain each step.

Use descriptive names and direct pipelines in this contribution. String transformations read in order through pipes, and lookup tables are named before joins. Use explicit five-field grouping and keep validation descriptions beside their calculations. Avoid single-letter iteration variables, generated column-name indexing and deeply nested transformations. The small package metadata table uses `rowwise()` because package version lookup takes one package at a time; the dog and SSA transformations operate on columns and groups.

Keep all extracted annual SSA files so the reference can be revised from the saved inputs. Build and explain any selected decade lists using the course's grouping, aggregation and ranking techniques, then use lookup joins for matching. Discuss one operational choice at a time within the proposal's research frame.

The complete decades produce 328,552 name/decade rows. An independent calculation from the annual source files agrees with every count, rank, share and dog match. The expanded reference recognizes 74,587 estimated dogs. The largest generated CSV is 24,836,711 bytes.
## Selected full-name matching rule
Aslan approved formatting normalization, complete-name matching and compound-name flags on November 5. Keep the source table unchanged, record compound-name findings before formatting, then replace the working name with consistent case and removal of spaces and hyphens to align with SSA's source formatting. Match the complete resulting key: `LOLA ROSE` becomes `LOLAROSE`. Derive compound-name flags from the original string before removing its separators, with missing-name labels handled separately. The name-format inspection identifies 299 records (0.282% of the extract) with internal spaces or hyphens after separating the exact `NAME NOT PROVIDED` label.

The observed patterns include apparent double names, character names, repeated syllables and an apparent alias. Do not add automatic first-word selection, inferred surname/title stripping, nickname expansion or other punctuation removal under this formatting rule. Any individual exception needs a documented basis.
## Selected missing-name rule
Aslan approved treating the six exact values below as missing names for name-based analysis on November 5, preserving all source rows and reporting missingness separately, including by geography when available. The import reads all six labels as missing values. Use is.na() to count missing names overall and by recorded ZIP, then exclude those licenses before name formatting. The report combines the labels into one missing-name category; the raw source retains their recorded spelling.

| Missing-name marker | License records |
| --- | ---: |
| `UNKNOWN` | 3,054 |
| `NAME NOT PROVIDED` | 1,682 |
| `NONE` | 555 |
| `NA` | 423 |
| `.` | 95 |
| `NONAME` | 1 |
| Total | 5,810 |

These six values account for 5.48% of the 105,974 records, leaving 100,164 named records before any other eligibility checks. There are no empty name strings in this snapshot. Classifying labels is an operational rule rather than proof of individual owner intent.

For the overall share matching the selected name reference, use named, eligible estimated dogs after the selected five-field grouping as the denominator; a present name that fails to match remains in that denominator. Missing names should have no match classification. Report source missingness separately using all source license records as its denominator; do not combine that record count with the estimated-dog denominator. This does not settle the separate denominator for any later distribution among matched generations.

Aslan explicitly selected keeping `BABY` (120 records) as a name. Titles such as `MR.` (89), `MRS.` (5), `MS.` (5) and `DR.` (9), and the four once-occurring strings `UNKNOWNMOR`, `UNKNOWNMS`, `UNKNOWNCOCK` and `UNKNOWNSHIBA`, remain review cases; exact membership keeps the exclusions limited to the six agreed labels. The selected list does not establish that every remaining name has been verified.
## Selected estimated-dog rule
Use the five-field rule and retain the latest license: group usable named records by normalized full name, sex, recorded birth year, breed and ZIP. Select greatest issue date, then greatest expiry date, then smallest source row number. Count and exclude missing names and unusable birth years before these transformations. This yields 92,921 estimated dogs from 100,119 eligible licenses. The public fields lack a stable dog identifier: the rule can merge different dogs with matching attributes and split renewals when attributes change. The source audit links usable licenses to a dog and reports early exclusions with empty dog IDs.

The selected missing-name rule still governs eligibility for name analysis. Its 5,810 missing-name records and 5.48% missingness describe source license records, not an estimated dog population. Missing-name labels cannot serve as identifying names: preserve these records for source missingness reporting, outside the named-dog grouping and name-rate denominator. The generated record-weighted comparison reports SSA recognition of 78.78%, versus 78.65% among estimated dogs; this citywide comparison does not establish neighborhood sensitivity.

A read-only inspection on November 5 found the following exact-value repetitions. No name normalization or inferred identity matching was applied, and no rows were removed:

| Fields compared | Records inspected | Repeated-value groups | Records in those groups | Rows beyond the first per group |
| --- | ---: | ---: | ---: | ---: |
| All eight published fields | 105,974 | 823 | 1,666 | 843 |
| All eight fields, named records only | 100,164 | 774 | 1,567 | 793 |
| Name, sex, birth year, breed and ZIP, named records only | 100,164 | 6,904 | 14,105 | 7,201 |

Of the repeated five-attribute groups, 6,255 contain more than one issued/expiry date pair. This is consistent with possible renewals but does not establish identity. Even equality on all published fields cannot prove whether separate source rows represent accidental duplication or distinct dogs whose identifiers are omitted. Grouping the named records on these five raw attributes yields 92,963 groups; this is not a verified unique-dog count or a result using normalized names.

A further date inspection found a male Shih Tzu named `MAX`, born in 2013, in ZIP `10456`, with periods issued February 25, 2019 and expiring February 25, 2024, and issued January 30, 2024 and expiring February 25, 2027. The second period beginning near the first expiry is consistent with renewal, without proving identity. All extract records expire in 2024 or later, while issue years range from 2017 through 2024; selecting only licenses issued in 2024 would exclude older licenses still represented in the chosen extract. No rows were removed.
## Selected overlapping decade matches
Keep a separate membership flag for each complete decade from 1880–2019. A name can match several decades. Each dog still contributes one row to the joined table.

For an initial area comparison, report each decade's matching share among eligible named estimated dogs. The same estimated dog can contribute to multiple decade numerators while appearing only once in the table and denominator; the percentages therefore need not sum to 100%. Retain ranks or proportions in the SSA reference for later examination of relative popularity. Overall SSA recognition uses the separate rule below.
## Selected overall human-name recognition rule
Set ssa_recognized when a formatted dog name appears in any published SSA record from 1880–2019. The fourteen top-100 flags describe popularity by decade. A name can be recognized while missing every top-100 list.

Read the 140 annual files for the 14 complete decades from 1880–2019. Each name has one reference row for joining to dogs.
## Selected first data handoff
The first deliverable is a CSV with one row per eligible named estimated dog. Retain the normalized name, sex, recorded birth year without inferred replacements, breed, ZIP as recorded text, representative license dates, extract year and source row number. Add SSA recognition, the 14 overlapping decade flags and the number of source license records consolidated into that estimated dog. Keep the SSA reference separately inspectable. Report missingness and preparation findings separately, with explicit row units.

The analysis joins dog ZIP to a saved snapshot of Shweta's ZIP–ZCTA income handoff, preserving rows through the join, then selects areas on the published city list with income information. This yields 92,541 dogs and 380 reported exclusions. Aggregate by ZCTA when comparing areas so several postal ZIPs mapping to one Census area contribute to the same area summary. Four round-dollar income bands and equal weight per estimated dog are selected; shared acceptance with Shweta remains pending.
## Selected uncertainty treatment
The major source, name-reference, counting and output choices are selected. A further read-only inspection of the 100,164 named source records found 8,287 with breed exactly `Unknown`, 33 with birth years that are not four digits, 12 with four-digit birth years before 1990, and 40 with numeric ZIP strings shorter than five digits. There are no empty sex, birth-year, breed, ZIP or license-date strings among these records; sex values are `F` and `M`. Among the unknown-breed records, the five raw attributes form 7,732 groups, with 555 records beyond the first; these are not normalized or verified dog identities.

Keep recorded identifying values in the five-field grouping. Unknown breeds remain eligible, but named licenses with birth years outside the exact text values 1990–2024 are counted and excluded first. The 45 excluded licenses have 42 distinct five-field keys in the independent check. The main preparation applies no inferred years. The optional birth-year-inferences.qmd preserves the six considered corrections and their join operation for discussion. Usable licenses produce 92,921 estimated dogs, including 7,729 with unknown breed. The report counts missing names, excluded years, unknown breeds, compound names and tied latest licenses separately; no report-only fields enter dog exports. Geographic eligibility remains a later lookup step.

Birth-year candidate inspection, November 9: search all licenses for the same formatted name, exact breed label and sex, allowing different ZIPs. Compare non-four-digit years with four-digit years no later than either record's issue year. Of 31 estimated dogs with malformed years, 10 have such candidates; 8 have a candidate year that could produce the recorded value by deleting digits without reordering them. Five have one distinct compatible year and three have several. Removing the exploratory 1990 lower bound does not change the compatible candidates. All compatible candidates are in different ZIPs. A unique candidate year in this extract does not establish that the records identify the same dog.

Among the nine dogs recorded with year 202, PENNY (female Cockapoo) has candidate years 2020, 2023 and 2024; ELLIE (female Goldendoodle) has 2020, 2021 and 2023; BILLIE (female American Pit Bull Terrier/Pit Bull) has 2020. The other six have no compatible candidate under this rule. PENNY and ELLIE have several compatible years and remain unresolved. BILLIE receives the approved inference described below.

The official SSA archive was acquired through its browser download link after command-line 403 responses. Column types, file names, tie rules and count checks are documented in the notebook and dictionary. None of the SSA rank-100/rank-101 boundaries is tied; alphabetical ordering handles equal counts elsewhere reproducibly. Income comparisons, plots and extensions remain later shared analysis.
## Remaining checks and later decisions
- **Shared interpretation:** inspect the retained uncertain groups and the citywide record-weighted comparison before interpreting neighborhood differences. The first output is verified under the selected rules, but dog identities remain estimates.
- **Name exceptions:** full-name matching, formatting normalization, compound flags and the exact missing-name list are selected. Consider any evidence-backed individual exceptions without treating a spelling difference as proof that two names mean the same thing.
- **SSA reference sensitivity:** reference uniqueness and all complete-decade cutoff boundaries are checked. Any later threshold sensitivity checks must remain explicit rather than silently changing the selected recognition rule.
- **Generational reporting and extensions:** overlapping top-100 membership covers every complete decade from the 1880s through the 2010s. Retain comparable proportions/ranks and avoid interpreting membership as exclusive association. Rarity and diversity remain proposed extensions. Implementation can proceed in stages without silently dropping the generational question.
- **Integration:** agree the handoff table's row unit, ZIP string representation, year fields, join keys and validation evidence with Shweta. Her geography work owns ZIP-to-ZCTA mapping; the analysis uses a saved snapshot of her current output and will aggregate by ZCTA when comparing areas.
- **Course synonym requirement:** the import maps the six missing-name labels to one missing category. Confirm the requirement's intended coverage alongside the geographic work; case conversion alone does not demonstrate synonym handling, and ZIPs/ZCTAs are not interchangeable names.
## Public-source observations — 2026-11-04
[NYC's dataset metadata](https://data.cityofnewyork.us/api/views/nu7n-tubp.json) describes each record as an active license period and explicitly warns that renewal can create more than one record for a dog. The inspected eight published fields contain no dog identifier. `extract_year` is text, and `zipcode` is published as numeric; the analysis must deliberately preserve postal codes as strings.

A live grouped count through the published resource API returned extracts 2016, 2017, 2018, 2022, 2023, 2024 and 2026. The 2024 extract contains 105,974 records, consistent with the proposal's earlier feasibility count. An extract label alone does not establish comparability or completeness across years; selecting the newest available extract automatically would be an additional research choice.

[SSA's national download page](https://www.ssa.gov/oact/babynames/limits.html) provides a bulk ZIP with format documentation. Its [qualifications](https://www.ssa.gov/oact/babynames/background.html) explain incomplete early coverage, suppression of small counts, removal of spaces/hyphens, separate spelling variants, and retention of entries such as Baby and Unknown. These facts affect matching and placeholder handling; they do not settle the project's cleaning rules.

The initial direct HTTP header request returned 403. The official archive was subsequently acquired through the browser's National data link on November 5; the saved snapshot removes that network dependency from reproduction.
## Source-size evidence — 2026-11-05
The complete selected dog CSV was downloaded, checked for the expected 105,974 records and exclusive 2024 membership, and preserved at [data/raw/nyc-dogs-2024.csv](../../data/raw/nyc-dogs-2024.csv). Its 11,139,556 bytes have SHA-256 `b4f05b3b04a18d3c9765590ab3a75c08f7e23990c7462619d7e735a3b83538ce`. The [source manifest](../../data/sources.csv) records the exact query and retrieval time; [data instructions](../../data/README.md) describe its scope.

SSA's full official ZIP was downloaded through its browser link on November 5 after command-line GET attempts returned 403. The snapshot at [acquired archive in Git history](https://github.com/Barkonomics-DataWrangling/barkonomics-pet-names/blob/abab797/data/raw/ssa-names.zip) is 7,860,026 bytes with SHA-256 `cd78e975ed7bb358e018dd62fbe14ced89295e9581c49172ca4eedcb011b3724`. All 147 members passed ZIP integrity checking; 146 annual files contain 2,181,032 records for 1880–2025, and the remaining member is `NationalReadMe.pdf`. Total uncompressed size is 28,255,978 bytes. The official readme dates the tabulation to March 1, 2026. No third-party source was substituted.
## Name examples inspected — 2026-11-05
A read-only inspection of the preserved dog CSV found compound names including `LOLA ROSE`, `COOPER SEAMUS` and `BAILEY J`, plus hyphenated names such as `WALL-E`. These ground the full-name matching discussion; no source values have been changed. Potential missing-value markers include `UNKNOWN` (3,054 records), `NAME NOT PROVIDED` (1,682), and `.` (95). The source also contains `BABY` (120), whose meaning cannot be determined from the string alone. These are observations for later placeholder review, not an exclusion list.
## Compound-name prevalence — 2026-11-05
Inspected all 105,974 license-period records in the preserved 2024 CSV, with its manifest checksum verified. Counts describe the published name field and retained license periods, not unique dogs or an independently verified complete name. Percentages below use all 105,974 raw records as the denominator, including missing-name labels.

| Pattern | License records | Distinct raw strings | Percent of all records |
| --- | ---: | ---: | ---: |
| Internal whitespace, excluding exact `NAME NOT PROVIDED` | 18 | 17 | 0.016985% |
| Internal ASCII hyphen | 281 | 218 | 0.265159% |
| Either of these patterns | 299 | 235 | 0.282145% |
| Trailing hyphen without an internal hyphen | 6 | 6 | 0.005662% |
| Exact `NAME NOT PROVIDED` label | 1,682 | 1 | 1.587182% |

Detection used `\S\s+\S` for internal whitespace and `[^\s-]-[^\s-]` for an internal hyphen. No record matched both compound-looking patterns. The 1,700 records with internal whitespace consist of 1,682 exact missing-name labels plus 18 other records. No leading/trailing whitespace, non-space whitespace or Unicode dash characters were found. The six trailing-hyphen strings are `CHLOE-`, `WAFFLES-`, `ASIA-`, `MAYBACH-`, `SOFIA-` and `MIO-`, each once. All these observations leave the source unchanged; separating a label in this inspection does not adopt the pipeline's full missing-value rules.

Examples and frequencies:

| Observed pattern | Examples (license records) |
| --- | --- |
| Words separated by spaces | `BAILEY J` (2), `LOLA ROSE` (1), `COOPER SEAMUS` (1), `MAGGIE GYLLENPAW` (1) |
| Hyphenated human-name forms | `JEAN-LUC` (2), `LUNA-MARIE` (2), `CHARLOTTE-LUCY` (1) |
| Character or phrase forms | `WALL-E` (11), `OBI-WAN` (5), `SCOOBY-DOO` (3) |
| Repeated syllables | `CHI-CHI` (7), `BAM-BAM` (3) |
| Apparent alias notation | `WINTER-AKA-WINNIE` (1) |

Pattern descriptions are interpretations of the recorded text, not verified owner intent. The [complete inspection inventory](dog-baby-name-data.name-format-inspection.csv) retains all 242 distinct strings in these groups, their frequencies and structural categories, covering 1,987 records including the missing-name label and trailing-hyphen cases. Reproduce the inventory by grouping the unmodified `animalname` column, counting license rows and applying the detection rules above. Overall rarity does not establish that the affected records are evenly distributed across neighborhoods; no geographic sensitivity result is claimed.

## R readability
Load `tidyverse` as a suite. Use descriptive names and readable sequential transformations. Define shared objects with `<-`; use `->` for self-contained pipeline results, and pipe directly from single-use reads unless a meaningful named object supports inspection or expected reuse. Split long transformations into inspectable named stages; straightforward loops remain acceptable. The analysis gives the NYC columns consistent names in `dogs_original` and uses `preview()` to display six example rows. These are Aslan’s implementation instructions for this contribution. A proposed READABLE-R policy (maintained in the separate local policy contribution) records the candidate durable obligation; it is not yet adopted. No existing policy owns R coding style, and review found no conflicting obligation or incoming dependency for the new ID.

The R policy proposal is a separate contribution with its own commit and eventual issue-linked PR. Prepare its issue and PR from the policy diff and commits when publication is requested. The dog/name PR remains focused on issue #1 and the implementation/data handoff.

## Verification scope
Use the separate checks notebook to compare the saved dog table with the source licenses, missing-name list and SSA reference. The R notebook does not calculate source or output checksums and does not depend on `digest`. Acquisition provenance lives in the source inventory and data README. Keep `sources <- read_csv(...)` as the named inventory for inspection and expected reuse. The handoff and analysis have eighteen output CSVs; output checksum generation is outside its scope.

## Quarto implementation
Use [dog-names.qmd](../../dog-names.qmd) for dogs, [baby-names.qmd](../../baby-names.qmd) for SSA preparation, [analysis.qmd](../../analysis.qmd) for the combined analysis and [dog-names-checks.qmd](../../dog-names-checks.qmd) for independent checks on the saved files. Render from the repository root. Durable output definitions live beside the data. Issue #1 owns shared coordination and acceptance; its PR will own change review. Documentation placement is project-specific, not a universal ban on code documentation under docs. Consumer workflow pins stay unchanged until the shared workflow guidance is settled.

## Prepared issue update
Unpublished preparation for issue #1; this is not a second shared acceptance record.

1. **Shweta's interface:** review the use of her current ZIP–ZCTA income output as a versioned input. Dog `zipcode` joins to its unique `zip_code`; the NYC selection and exclusion report use the agreed city list. Confirm the shared income groups and preserve her input provenance. Aggregate by ZCTA when comparing areas.
2. **Shared review:** inspect the five-field identity approximation and flag summaries before interpreting neighborhood patterns. The retained source records and lineage permit a different consolidation rule without reacquiring data. No rule change is necessary to inspect this handoff.
3. **Course synonym coverage:** the import maps the six missing-name labels to one missing category. Confirm the course synonym requirement alongside the geographic crosswalk. ZIPs and ZCTAs are related geographies rather than interchangeable names, and case normalization alone is not synonym handling. If another example is required, use an evidenced alias lookup; do not invent dog-name equivalences to satisfy the rubric.

These questions concern integration, shared interpretation and course acceptance; the dog-level CSV is usable independently. Income grouping, plots, rarity/diversity extensions and equivalent pandas/SQL/Power Query workflows remain later work. Issue #1 stays open through the agreed review and acceptance; this first contribution does not claim completion of the full project.

## Prepared PR description
Unpublished preparation for the eventual data PR.

Contributes to #1. Prepares one row per named estimated dog from NYC's 2024 license extract, with normalized names, source-row traceability, broad SSA recognition and overlapping top-100 decade memberships. Preparation findings are reported separately. The saved handoff contains 92,927 estimated dogs after six approved birth-year inferences and exclusion of 36 dogs with unresolved years. All 105,974 source records remain accounted for in the lineage and exclusion outputs.

Includes the fixed NYC and official SSA source snapshots with checksums, the six-label missing-name list, three Quarto notebooks for preparation and analysis plus separate saved-file checks, generated CSVs, and `dog-names.qmd`, `data/dog-name-data-dictionary.md` and `docs/active-spikes/dog-baby-name-data.md`. The official SSA archive was acquired through the browser after command-line downloads returned 403.

All 28 saved-file checks pass, covering latest-license selection and deterministic ties, unique five-field dog keys, complete source-to-dog lineage, unchanged dog count through the SSA join, exactly 100 names per decade, birth-year exclusions, retention of eligible unknown-breed records and matching flags. An independent calculation from both raw sources agrees with every dog representative and SSA flag. The analysis also supplies 92,547 dogs selected through the accepted NYC list and income rule, with 380 exclusions reported separately and capped incomes retained. Executing the notebooks produces eighteen output CSVs including the income-group counts, dog-weighted name comparisons and check results; HTML rendering is reserved for the final analysis. Runtime versions, per-stage counts and quality summaries are included.

Review the documented identity approximation and the CSV interface for Shweta's ZIP–ZCTA and income work. Missingness is a license-record measure, and decade memberships can overlap. Income-group comparisons, plots, other-language implementations and shared acceptance remain separate work. Keep issue #1 open after this partial contribution; integration does not imply project acceptance.

The R style policy requires a separate issue and PR. Keep the policy commit out of this PR’s change set; integrate the policy PR first and compare this contribution against the updated target before publication.

## Missing-name implementation
Define missing_name_labels with c() beside the import in dog-names.qmd and pass it to read_csv() as na. All six labels become missing values; BABY stays a name. Build name_missing by piping licenses through pull(name) and is.na(). Count exclusions overall and by recorded ZIP, then use filter(!name_missing) on that same table and row order. Report the six possible labels without maintaining separate counts for each. The checks notebook independently reads the original labels and verifies the exclusions. Preserve ZIPs as recorded: every selected NYC dog already has a five-digit ZIP, and padding the 40 short named-license ZIPs would not change the comparison. No missing-name status or boolean column enters the dog export.

## Source and working columns
Rename publisher fields once to short working names in licenses. Use source_row_id to find every recorded value in the unchanged source CSV; do not carry duplicate original_ columns. Count and exclude missing names and unusable years before further preparation. Record compound names before changing their formatting. Display missing-name exclusions and quality summaries together in the cleaning report.

Execute preparation and checking chunks directly while developing. Render analysis.qmd when the final HTML deliverable is needed.

## Quality-flag review
Keep breed_unknown and compound_name in preparation and the cleaning report, outside both exported dog tables. Report the number of estimated dogs with tied latest issue dates using latest_issue_ties, without exporting that per-dog count. Count unusable birth years as early exclusions. Retain sex, breed, the recorded ZIP and birth year, and license_record_count, which the analysis uses for the license-weighted comparison. The separate checks notebook verifies that selected NYC ZIPs have five digits and that prepared ZIPs match the source.

## Approved birth-year inferences
Aslan approved six record-specific inferences on November 9: ROCKY 223 → 2023, SIMBA 222 → 2022, BILLIE 202 → 2020, MILO 204 → 2024, and HONEY and BROWNIE 1022 → 2022. The [correction lookup](../../data/lookups/birth_year_corrections.csv) identifies each source row and its name, known breed, sex, original year and inferred year. Matching names, breeds and sex with a compatible year on another license support five inferences. BROWNIE has no matching license recording 2022; its inference uses the likely first-digit typo and the shared 1022 value, breed, ZIP and license dates with HONEY. These details suggest a possible shared entry error, not shared dog identity, household or litter membership. HONEY and BROWNIE remain separate dogs. BETTY is not included because its breed is unknown.

Supporting license rows in the raw snapshot, numbered from the first data row after the header:

- ROCKY: row 61720 receives 2023; matching rows 52427, 53882 and 58489 record 2023.
- SIMBA: row 62878 receives 2022; matching rows 28918, 61815 and 103334 record 2022.
- BILLIE: row 63559 receives 2020; matching row 72246 records 2020.
- MILO: row 99337 receives 2024; matching row 90224 records 2024.
- HONEY: row 102214 receives 2022; matching row 64126 records 2022.
- BROWNIE: row 101787 receives 2022; the inference uses the shared typo pattern with HONEY, not an independently matching BROWNIE record.

Apply the lookup after the original five-field grouping and source-to-dog mapping. Preserve the raw records, group membership, representative rows and ZIPs. Do not apply replacements to every occurrence of a malformed year. The cleaning report counts original birth-year problems and displays the inferred corrections separately. The checks notebook independently states the expected replacements. The six approved inferences complete the manual repair pass; do not infer further birth years. After those corrections, exclude the remaining 36 dogs whose years fail the four-digit, 1990–2024 rule. Use the resulting 92,927-dog set consistently across analyses and retain the excluded source rows and group IDs in the audit.

## Income match inspection — November 9
Inspected [Shweta's PR #9](https://github.com/Barkonomics-DataWrangling/barkonomics-pet-names/pull/9) at head `eb7ecc0cbe336740d872d340aae8f95f760f57e3`, still open and draft. Its generated CSV is not committed. The saved script's Git blob matches the current PR exactly (`33e65395d41efd9be26321c5b836bd2745075418`). Re-executed that script with release 2024 and state NY using the official source downloads saved during the November 5 review. Its 2,150-row output matches the earlier generated file byte for byte. This inspection uses the 92,927 prepared dogs at `bd8a31d`; it adopts no geographic or income exclusion rule.

Joining dog `zipcode` to the output's unique `zip_code` keeps all 92,927 dog rows without duplication. The statewide results are:

| Income result | Estimated dogs |
| --- | ---: |
| Ordinary income estimate | 92,447 |
| Income reported as $250,000+ | 366 |
| Matched ZIP/ZCTA, income unavailable | 21 |
| Matched ZIP/ZCTA, ZCTA absent from the ACS file | 5 |
| ZIP absent from the NY-filtered lookup | 88 |

Thus 92,813 dogs (99.877%) have income information before defining NYC scope. Of the 88 absent from the NY lookup, 72 have national-crosswalk entries outside New York State and 16 have no national-crosswalk entry. The latter are unmatched in this source, not established invalid ZIPs.

For a provisional NYC screen, matched ZCTAs were compared with the 221 unique codes in [NYC Open Data's ZIP Code Tabulation Areas dataset](https://data.cityofnewyork.us/City-Government/ZIP-Code-Tabulation-Areas/35j5-n34v), retrieved November 9. There are 92,183 dogs with ordinary estimates on that list, 364 with $250,000+ incomes, 17 on the list without income, 275 in NY lookup areas absent from the city list, 72 outside the NY lookup's state coverage, and 16 without a national ZIP match. Using city-list membership and available income would retain 92,547 dogs (99.591%) and exclude 380. This is a candidate rule, not an implemented filter.

| Example | Source row | ZIP → ZCTA | Finding |
| --- | ---: | --- | --- |
| MOWGLI, Labrador Retriever | 23918 | 10020 → 10020 | NYC-listed area, income unavailable; six dogs have ZIP 10020. |
| CHLOE, Goldendoodle | 14599 | 10163 → 10170 | NYC-listed area, income unavailable; three dogs have ZIP 10163. |
| ZOE, American Staffordshire Terrier | 26923 | 10048 → no match | No national-crosswalk entry; two dogs have this ZIP. |
| CHOCO, Cavalier King Charles Spaniel | 36450 | 11315 → no match | No national-crosswalk entry; two dogs have this ZIP. |
| STELLA, American Pit Bull Terrier/Pit Bull | 13628 | 07302 → absent from NY output | National crosswalk labels the ZIP Jersey City, NJ. |
| BELLA, Bull Dog, English | 13445 | 11003 → 11003 | Income available; Elmont is absent from the city ZCTA list. |

City-list membership is not proof of an individual dog's location inside municipal boundaries. It includes ZCTA 11040, labeled New Hyde Park in the crosswalk, with 27 dogs; it also includes 10704 and 10705, labeled Yonkers, with 12 dogs in total. ZIPs supply no street address with which to resolve those cases. Decide whether to use the published list with this geographic limitation or a stricter borough-based area definition before adopting exclusions. The $250,000+ cases remain useful for the proposed open-ended highest income group; they should not be treated as exact $250,001 incomes or as missing observations.

Independent CSV calculations agree with the R counts and confirm unchanged dog order and identifying fields. Production notebooks, dog exports, raw snapshots and shared PR comments remain unchanged by this inspection.

## Selected NYC income scope — November 9
Aslan approved the published city ZCTA list as the geographic rule, accepting that listed areas can extend beyond NYC's municipal boundary. Keep dogs whose recorded owner ZIP maps to that list and has an ordinary or open-ended income estimate. Explain the overlap in the analysis, without claiming precise residential locations or inferring personal wealth, second homes or reasons for outside-city addresses.

The saved inputs are the 221-code city list and the reproduced 2,150-row New York income handoff from Shweta's PR #9. `analysis.qmd` writes 92,547 selected dogs representing 99,725 license records and a separate table of 380 exclusions. Retain all 364 dogs with $250,000+ area incomes; their exact numeric estimate is empty and the status preserves the open-ended amount. Exclusions are classified once, in order: no ZIP match in the NY lookup (88), area outside the city list (275), and city-listed area without income (17). All later comparison calculations use the selected table; the full 92,927-row dog/name handoff remains separately inspectable.

The analysis documents the boundary limitation beside the selection code. It uses the four approved round-dollar income bands and counts every estimated dog once in the name-matching summaries. Shweta's source script is unchanged, and no PR merge or publication is implied by using its reproduced handoff.

## Income-band options inspected — November 9
Inspection only; no income groups are adopted or added to analysis outputs. The selected table at `669a065` contains 92,547 estimated dogs in 190 distinct ZCTAs. Count each ZCTA once as a neighborhood, including when several ZIPs map to it. These counts concern represented neighborhoods, not every area in the city list. Four ZCTAs containing 364 dogs have $250,000+ incomes and belong in the highest group under every option below.

The recommended starting option uses round-dollar boundaries on area median household income. Lower bounds are inclusive and upper bounds exclusive. These are descriptive bands, not official social-class categories.

| Income band | Dogs | Neighborhoods |
| --- | ---: | ---: |
| Under $50,000 | 9,414 | 24 |
| $50,000 to under $100,000 | 41,344 | 94 |
| $100,000 to under $150,000 | 25,232 | 46 |
| $150,000+ | 16,557 | 26 |
| Total | 92,547 | 190 |

An alternative ranks the 190 neighborhoods by income and divides them into four groups as evenly as possible (48, 48, 47 and 47 areas). Capped areas rank above all ordinary estimates without assigning them a fictitious exact income. There are no equal-income ties across the proposed quarter boundaries. The ranges below describe observed values; no neighborhoods fall in the small gaps between them.

| Neighborhood quarter | Observed income range | Dogs | Neighborhoods |
| --- | --- | ---: | ---: |
| Lowest | $24,086–$67,897 | 20,424 | 48 |
| Second | $67,918–$89,931 | 19,079 | 48 |
| Third | $90,046–$120,230 | 21,981 | 47 |
| Highest | $121,062 through $250,000+ | 31,063 | 47 |

Round bands are easier to state in dollars and reproduce across samples. Neighborhood quarters balance the number of represented areas, but their boundaries depend on this sample and their dog counts remain unequal. Compare name proportions rather than raw totals under either choice. This inspection uses incomes and group sizes, not dog-name outcomes, to frame the choice.

Splitting the recommended highest band at $200,000 would yield 15,563 dogs in 18 areas at $150,000–$199,999, and 994 dogs in eight areas at $200,000+. A simpler three-band alternative gives 25,762 dogs in 60 areas below $75,000, 50,228 in 104 areas from $75,000 to under $150,000, and 16,557 in 26 areas at $150,000+. These alternatives remain available; the recommendation is the four round-dollar bands.

ACS estimates have margins of error, so a small difference around a cutoff does not establish a sharp economic distinction. For example, area 11420 has an estimate of $100,006 with a margin of error of $5,819. [Census guidance](https://www.census.gov/help/topics/faq.do-i-need-to-consider-the-margins-of-error-when-comparing-acs-estimates.html) explains why those margins matter. Treat bands as presentation choices, not certainty about an area's rank or its residents' individual incomes.

Independent Python calculations and a tidyverse count agree on both four-group options and reconcile to all 92,547 dogs and 190 areas. No notebook, source snapshot, generated analysis table, or PR was changed by this inspection.

## Selected income bands — November 9
Aslan approved the recommended four round-dollar bands after reviewing their dog and neighborhood counts. Assign ordinary estimates below $50,000 to the lowest band, $50,000 to under $100,000 to the second, $100,000 to under $150,000 to the third, and $150,000 or more to the highest. Handle `top_coded` first so all 364 dogs with $250,000+ area incomes enter the highest band; no exact income is invented. The analysis table retains all 92,547 dogs and appends `income_group`. The group-count table reports 9,414/41,344/25,232/16,557 dogs and 24/94/46/26 distinct ZCTAs in that order. A ZCTA shared by several ZIPs counts once.

Aslan approved pooling dogs within each income band so every estimated dog receives equal weight. The main comparisons concern dogs' naming patterns; neighborhoods with more recorded dogs contribute more. Equal-neighborhood weighting remains an optional later comparison, not the primary rule. This is separate from the earlier consolidation of licenses into estimated dogs.

## Selected income-group comparison — November 9
For each income band, count the selected dogs whose names match each decade's top 100, then divide by all selected dogs in that band. Use the same denominator for the secondary overall SSA-recognition measure. The four denominators are 9,414, 41,344, 25,232 and 16,557. One dog may match several decades, so these shares need not sum to 100%. Each dog has one vote in a given measure; do not weight by its license count or normalize neighborhood contributions in the main results.

`name_matches_by_income.csv` has 60 rows: four income bands by 15 name measures. It preserves matching counts, denominator counts, represented-neighborhood counts and shares. The next step is to review the complete generational comparison before choosing follow-up interpretations. The SSA source provides national name popularity by time, not parents' incomes; these results cannot establish the proposed rich-to-poor-to-dog diffusion chain.

## First charts for review — November 9
Aslan requested separate charts for decade matching and overall baby-name recognition. The line chart uses all 14 decades, the four approved bands and equal weight per estimated dog. Its horizontal axis is the baby-name decade, not time passing in the dog sample. A second chart shows recognition anywhere in the 1880–2019 reference. Both are reproducible from analysis.qmd and saved under figures/.

Descriptively, the four income groups appear in ascending order of matching share for every decade from the 1880s through the 1950s. The highest and lowest groups match 7.03% versus 3.45% for the 1880s and 4.20% versus 1.82% for the 1920s. All groups dip around the 1960s–1980s, then rise for recent decades, which do not follow a consistent income order. Overall recognition rises from 78.08% through 79.80% and 80.58% to 82.14%, a highest-minus-lowest difference of 4.07 percentage points. These are descriptive differences in the selected licensed-dog sample, not evidence of individual wealth or a diffusion chain. Reviewing the contributing names is the proposed next investigation; no explanation of the pattern has been adopted.

## Names and neighborhood follow-up — November 9
Aslan authorized completing the descriptive first pass before his R-code walkthrough. The follow-up preserves every selected dog, income group, matching rule and primary weight. It adds observed name counts/ranks for all four bands, individual-name contributions to each of the 14 highest-minus-lowest decade differences, and all 15 matching measures within each of the 190 represented neighborhoods. The 1880s and 1920s examples were selected after seeing the chart to explain its pattern; they are exploratory illustrations, not independent confirmation.

LUNA ranks first in all four groups. CHARLIE ranks ninth in the lowest band and second in the highest. The five largest positive 1880s contributions are DAISY, HENRY, STELLA, GEORGE and LUCY, accounting for 41.44% of the 3.58-percentage-point difference. The five largest 1920s contributions are HENRY, GEORGE, RUBY, HARRY and BETTY, accounting for 41.81% of its 2.38-point difference. Contributions include negative values as well as positive ones, so their sum is the net group difference. HENRY also ranks 47th in the combined-sex 2010s reference; an old-list match is not a claim that a name belongs exclusively to the past.

Neighborhood median shares increase across the four bands for the 1880s (2.99%, 4.29%, 5.28%, 6.73%) and 1920s (1.58%, 2.14%, 2.48%, 4.06%). Neighborhoods overlap and a few have very small dog counts. A separate one-area-at-a-time omission inspection leaves the 1880s share between 3.15% and 3.53% in the lowest band and between 6.97% and 7.11% in the highest; corresponding 1920s ranges are 1.53%–1.88% and 4.15%–4.26%. This rules out any single neighborhood accounting for those pooled differences; it is not a significance test and does not adjust for other neighborhood characteristics.

The broad SSA measure also recognizes ROCKY, LUCKY and BUDDY. Its 4.07-percentage-point income-band gap is an overlap measure, not a classification of human-sounding names or owners' intentions. The record supports descriptive naming differences associated with neighborhood income. It does not distinguish diffusion from continuing use of classic names, revivals or other neighborhood differences; no causal explanation has been adopted. The descriptive R pass is ready for Aslan's readability walkthrough and shared review; course synonym handling and cross-language implementations remain outside this completed pass.

## Preparation walkthrough — November 12
Aslan requested moving helpers.R to the repository root and questioned the need for import missing-value handling, intermediate original_ columns, ZIP preparation and the six bespoke birth-year corrections. The helper move and simplified ZIP formatter preserve results. All 105,974 source ZIP values contain one to five digits, so the formatter can directly pad to five characters without a separate validity test. There are no blank or missing-marker ZIPs. Short ZIP strings occur in 56 raw licenses and 40 named licenses; all 40 named cases are outside the selected income-comparison cohort.

The source has 423 dog-name cells containing the text NA. read_csv's default converts those to R missing values before the six-label membership check, so simply deleting na = character() would change exclusion behavior. Preserving the supplied text lets one agreed label list count and remove all 5,810 missing-name records. An alternative could convert all six labels during import and count missing values, but would lose the per-label breakdown unless separately retained. No import rule changed during this inspection.

A single rename directly to short working column names could replace the original_-then-short naming sequence. Raw values would remain in dogs_raw and the saved source, linked by source_row_id. Report fields that require an unmodified name or ZIP could be computed before replacing those values. This remains a proposed simplification while the walkthrough discusses its structure.

Removing the six inferred birth-year replacements would exclude ROCKY, SIMBA, BILLIE, MILO, BROWNIE and HONEY under the existing year rule. Each represents one license. Total year exclusions would be 42 estimated dogs and 45 named licenses, leaving 92,921 prepared dogs and 92,541 income-comparison dogs. Across all 60 income-group/name measures, the largest absolute share change is 0.006989 percentage points, for overall recognition in the lowest income band. Removing these bespoke inferences is the recommended simplification; no recorded year, selection rule or analysis output changed in this inspection. The main reason is a uniform, explainable cleaning rule, rather than preservation of a particular statistical result.

## Early exclusion and reference preservation — November 12
Aslan approved renaming directly to the short working column names, counting and excluding unusable records early, and removing all six birth-year inferences from the main preparation. The optional birth-year-inferences.qmd preserves the six explicit source-row/name/year replacements and the original correction operation verbatim. It runs independently, displays the examples and writes no prepared outputs. The birth-year exclusion comment links this reference and gives the measured maximum chart-share difference as 0.007 percentage points, rather than percent relative change.

The main flow keeps dogs_raw unchanged, reports and excludes 5,810 missing-name licenses, then reports and excludes 45 licenses whose recorded years are not among the text values 1990–2024. Only the remaining 100,119 licenses undergo name formatting, ZIP padding, date conversion and grouping. Retained dog identifiers, fields, row order and license counts are unchanged from the preceding result apart from removing the six reviewed dogs. The 92,921 prepared dogs yield 92,541 selected income-comparison dogs representing 99,719 licenses. The income bands contain 9,411, 41,341, 25,232 and 16,557 dogs across the same 190 areas. The 380 geographic/income exclusions are unchanged.

The audit keeps all 105,974 source rows. Unusable-year exclusions now have a source row and reason but no dog or retained-row IDs, because these records do not enter grouping. excluded_birth_year_licenses.csv preserves all 45 recorded rows under short headings. Compound and ZIP-padding findings are collected before changing the working values, so no original_ duplicate columns are needed. The redundant birth_year_suspect flag is replaced by the exclusion count; the other cleaning findings describe the eligible population.

All 28 saved-file checks pass. An independent comparison confirms the exact six removals, unchanged retained values, complete audit, preserved excluded-source values and every regenerated name/group/area share and rank. The maximum difference across the 60 plotted group measures is 0.006989 percentage points. Missingness by ZIP, the SSA reference and geographic exclusions remain unchanged. The code walkthrough continues; shared review and publication remain separate.

The six missing-name labels have identical exclusion treatment. Retaining their distinction only supplies the optional per-label cleaning breakdown; it is not needed for the analysis. The current explicit membership implementation and import setting remain in use while that presentation is discussed. There is no missing-ZIP exclusion filter. Source inspection found no missing ZIPs, and the full saved HRSA crosswalk confirms the example 07024 → Fort Lee, NJ, ZCTA 07024: zero-padding makes a compatible text key, rather than merely changing display. All short ZIP cases fall outside the current selected NYC income sample.

## Import and ZIP simplification — November 12
Aslan approved combining the six missing-name markers and removing ZIP padding. The import now uses na = missing_name_labels; a pull(name) → is.na() pipeline supplies the counting and exclusion answers. The overall and recorded-ZIP missingness report remains, with all six labels documented and no per-label count table. Inspection of the fixed source found none of those labels in other columns and no blank cells. BABY remains a name.

Removed the ZIP-formatting helper, transformation stage and report flag. The broader prepared tables and income-exclusion report retain the source spelling of 40 short ZIPs. Those dogs already have zip_not_in_ny_lookup as their exclusion reason; all selected NYC ZIPs have five digits. The 92,541 selected dogs, every comparison summary and both chart PNGs are byte-identical to the preceding checkpoint. The five-field grouping, dog IDs, license audit and birth-year exclusions are unchanged. All 28 saved-file checks pass, and an independent source comparison reconciles all 5,810 missing-name exclusions by recorded ZIP.
