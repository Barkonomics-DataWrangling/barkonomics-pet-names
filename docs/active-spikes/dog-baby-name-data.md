---
attention: live
reviewed: 2026-11-08
tags: [barkonomics, dog-data, baby-names, r]
---
# Dog and baby-name data
## Purpose and ownership
Prepare Aslan's dog-license and SSA baby-name portion under [issue #1](https://github.com/Barkonomics-DataWrangling/barkonomics-pet-names/issues/1), starting in R. This spike belongs to the agent working in the current planning conversation. [Tasks and evidence](dog-baby-name-data.todo.md) track execution. Shweta owns income and ZIP–ZCTA preparation under [issue #2](https://github.com/Barkonomics-DataWrangling/barkonomics-pet-names/issues/2); shared research definitions and the integration contract remain joint decisions.

Aslan authorized completing the first handoff after selecting the research and cleaning rules, including retaining uncertain identifying attributes with flags. The R contribution uses simple, explainable course techniques for his individual interview. The user requires branch-based work, spike records, and eventual publication through an issue-linked PR that makes changes, review and acceptance inspectable to Shweta. The [three notebooks](../../data/README.md#generate-and-check-the-handoff) contain the implementation, with checks in a separate notebook; issue #1 and its eventual PR own coordination and review. This does not establish that Shweta has reviewed or accepted any choices.
## Research frame
Ask whether dog names differ across higher- and lower-income NYC neighborhoods, and whether their names match different baby-name decades. Diffusion between socioeconomic groups and eventually to dog names is the motivating hypothesis. The available national baby-name counts and 2024 dog licenses can describe generational associations. They do not identify a historical sequence of naming by household income.

Use the top 100 names in every complete SSA decade from 1880–2019. Sum across years and sex, rank by birth count and break ties alphabetically. A name may match multiple decades. Overall recognition uses published records across those complete decades. Save the partial 2020–2025 period separately because it is incomplete and includes births after the dog snapshot. Keep one reference row per formatted name when joining to dogs.
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
  lookups/           # Project-owned missing-name label mapping.
  derived/           # Regenerable cleaned and joined outputs.
dog-names.qmd        # Prepare estimated dogs.
baby-names.qmd       # Prepare baby-name decades.
analysis.qmd         # Match names and compare areas.
dog-names-checks.qmd # Independently check saved results.
R/helpers.R         # Shared table preview function.
```

Keep fixed source snapshots and generated results in Git. The dog CSV is 11,139,556 bytes. All 146 annual SSA text files and the source readme are saved directly in data/raw/ssa/, totaling 28,255,978 bytes. Analysis reads those files directly. Acquisition details are in the data README and source inventory.

Use 2024 as the starting dog extract, following Aslan's November 5 direction. This is the initial working choice, not a decision to pool years or claim unique dogs. For SSA, the national bulk download offers the reference source; preserve its readme and derive the chosen time window explicitly. Initial profiling should report schema, row counts, missingness and duplicate-looking records before adopting irreversible cleaning assumptions.
## Implementation approach
The [R notebook](../../dog-names.qmd) uses named tidyverse transformations with inspectable intermediate tables. The [course R introduction](https://howisonlab.github.io/datawrangling/current/rtidyverse/tidyverse_intro.html) supplies filtering/selecting, new columns, lookup joins, grouped aggregation and ranking/windowing. The [grouping material](https://howisonlab.github.io/datawrangling/current/data_transforms/group_aggregate.html) explains how a group is reduced to a summary or a selected set of rows. Comments explain the purpose of each step, and the [separate checks notebook](../../dog-names-checks.qmd) re-reads the saved outputs. Walk through the input grain, transformation and output grain so Aslan can explain each step.

Use descriptive names and direct pipelines in this contribution. String transformations read in order through pipes, and lookup tables are named before joins. Use explicit five-field grouping and keep validation descriptions beside their calculations. Avoid single-letter iteration variables, generated column-name indexing and deeply nested transformations. The small package metadata table uses `rowwise()` because package version lookup takes one package at a time; the dog and SSA transformations operate on columns and groups.

Keep all extracted annual SSA files so the reference can be revised from the saved inputs. Build and explain any selected decade lists using the course's grouping, aggregation and ranking techniques, then use lookup joins for matching. Discuss one operational choice at a time within the proposal's research frame.

The complete decades produce 328,552 name/decade rows. An independent calculation from the annual source files agrees with every count, rank, share and dog match. The expanded reference recognizes 74,587 estimated dogs. The largest generated CSV is 24,836,711 bytes.
## Selected full-name matching rule
Aslan approved formatting normalization, complete-name matching and compound-name flags on November 5. Preserve each original dog name and create a separate matching key using consistent case and removal of spaces and hyphens to align with SSA's source formatting. Match the complete resulting key: `LOLA ROSE` becomes `LOLAROSE`. Derive compound-name flags from the original string before removing its separators, with missing-name labels handled separately. The name-format inspection identifies 299 records (0.282% of the extract) with internal spaces or hyphens after separating the exact `NAME NOT PROVIDED` label.

The observed patterns include apparent double names, character names, repeated syllables and an apparent alias. Do not add automatic first-word selection, inferred surname/title stripping, nickname expansion or other punctuation removal under this formatting rule. Any individual exception needs a documented basis.
## Selected missing-name rule
Aslan approved treating the six exact values below as missing names for name-based analysis on November 5, preserving all source rows and reporting missingness separately, including by geography when available. The implementation detects these labels through a lookup before name-key normalization and reads the two letters `NA` as text before classifying them as a missing name. Raw sources remain unchanged.

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

Aslan explicitly selected keeping `BABY` (120 records) as a name. Titles such as `MR.` (89), `MRS.` (5), `MS.` (5) and `DR.` (9), and the four once-occurring strings `UNKNOWNMOR`, `UNKNOWNMS`, `UNKNOWNCOCK` and `UNKNOWNSHIBA`, remain review cases; an exact lookup avoids turning a substring guess into an exclusion rule. The selected list does not establish that every remaining name has been verified.
## Selected estimated-dog rule
Aslan approved the five-field rule and retaining the latest license on November 5: group named records by normalized full name, sex, birth year, breed and ZIP, count each group as one estimated dog, and retain its latest license record as the representative. The implementation selects greatest issue date, then greatest expiry date, then smallest source row number. The public fields lack a stable dog identifier: the rule can merge different dogs with matching attributes and can miss repeat records when attributes change. Describe the resulting 92,963 units as estimated dogs, not verified individual identities. All named source records map to exactly one of them in the lineage output.

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

Read all 146 annual files. Rank the complete decades for the dog comparison and retain 2020–2025 in the separate partial-period table. Each name has one reference row for joining to dogs.
## Selected first data handoff
Aslan approved the dog-level CSV as the first deliverable on November 5, with one row per eligible named estimated dog. Retain the original name, normalized name, sex, birth year, breed, ZIP as five-character text, representative license dates and extract year. Add the SSA recognition flag, three overlapping decade flags, compound-name flag and number of source license records consolidated into that estimated dog. Keep the SSA reference separately inspectable and report source missingness in a separate quality summary with explicit license-record denominators.

The proposal's geographic joins remain dog ZIP to Shweta's ZIP–ZCTA lookup, then ZCTA to her income table. Validate lookup uniqueness and preserve the dog row count through these joins, reporting unmatched geography. Aggregate by ZCTA after mapping so several postal ZIPs mapping to one Census area contribute to the same area summary. The dog-level handoff is generated and checked; coordination and acceptance with Shweta remain pending.
## Selected uncertainty treatment
The major source, name-reference, counting and output choices are selected. A further read-only inspection of the 100,164 named source records found 8,287 with breed exactly `Unknown`, 33 with birth years that are not four digits, 12 with four-digit birth years before 1990, and 40 with numeric ZIP strings shorter than five digits. There are no empty sex, birth-year, breed, ZIP or license-date strings among these records; sex values are `F` and `M`. The before-1990 count is a screening observation, not an adopted age exclusion. Among the unknown-breed records, the five raw attributes form 7,732 groups, with 555 records beyond the first; these are not normalized or verified dog identities.

Aslan approved retaining named records with uncertain non-name attributes, keeping the recorded values in the five-field grouping and adding explicit quality flags. The implementation does not guess birth years, invent breeds or drop these records. `Unknown` remains a shared recorded breed label, so its matches offer less identifying evidence than a known breed. Original ZIP strings survive alongside a five-character representation. The output retains 7,732 unknown-breed estimated dogs and 42 with suspect birth years, with 7,771 distinct dogs in their union. These flags do not verify any identity, and geographic validity remains a later lookup check.

The official SSA archive was acquired through its browser download link after command-line 403 responses. Column types, file names, tie rules and count checks are documented in the notebook and dictionary. None of the SSA rank-100/rank-101 boundaries is tied; alphabetical ordering handles equal counts elsewhere reproducibly. Income comparisons, plots and extensions remain later shared analysis.
## Remaining checks and later decisions
- **Shared interpretation:** inspect the retained uncertain groups and the citywide record-weighted comparison before interpreting neighborhood differences. The first output is verified under the selected rules, but dog identities remain estimates.
- **Name exceptions:** full-name matching, formatting normalization, compound flags and the exact missing-name list are selected. Consider any evidence-backed individual exceptions without treating a spelling difference as proof that two names mean the same thing.
- **SSA reference sensitivity:** reference uniqueness and all complete-decade cutoff boundaries are checked. Any later threshold sensitivity checks must remain explicit rather than silently changing the selected recognition rule.
- **Generational reporting and extensions:** overlapping top-100 membership covers every complete decade from the 1880s through the 2010s. Retain comparable proportions/ranks and avoid interpreting membership as exclusive association. Rarity and diversity remain proposed extensions. Implementation can proceed in stages without silently dropping the generational question.
- **Integration:** agree the handoff table's row unit, ZIP string representation, year fields, join keys and validation evidence with Shweta. Her geography work owns ZIP-to-ZCTA mapping; aggregate by ZCTA once that mapping is available.
- **Course synonym requirement:** the six missing-name labels map through a lookup to `not_recorded`. Confirm the requirement's intended coverage alongside the geographic work; case conversion alone does not demonstrate synonym handling, and ZIPs/ZCTAs are not interchangeable names.
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
Use the separate checks notebook to compare the saved dog table with the source licenses, missing-name lookup and SSA reference. The R notebook does not calculate source or output checksums and does not depend on `digest`. Acquisition provenance lives in the source inventory and data README. Keep `sources <- read_csv(...)` as the named inventory for inspection and expected reuse. The handoff has fourteen output CSVs; output checksum generation is outside its scope.

## Quarto implementation
Use [dog-names.qmd](../../dog-names.qmd) for dogs, [baby-names.qmd](../../baby-names.qmd) for SSA preparation, [analysis.qmd](../../analysis.qmd) for the combined analysis and [dog-names-checks.qmd](../../dog-names-checks.qmd) for independent checks on the saved files. Render from the repository root. Durable output definitions live beside the data. Issue #1 owns shared coordination and acceptance; its PR will own change review. Documentation placement is project-specific, not a universal ban on code documentation under docs. Consumer workflow pins stay unchanged until the shared workflow guidance is settled.

## Prepared issue update
Unpublished preparation for issue #1; this is not a second shared acceptance record.

1. **Shweta's interface:** confirm her ZIP–ZCTA and income filenames and column names. Recommended joins are dog `zipcode` → unique crosswalk ZIP → unique income ZCTA, using left joins with many-to-one checks. Keep unmatched dogs visible and aggregate by ZCTA after mapping. No geography or income availability has been assumed in this CSV.
2. **Shared review:** inspect the five-field identity approximation and flag summaries before interpreting neighborhood patterns. The retained source records and lineage permit a different consolidation rule without reacquiring data. No rule change is necessary to inspect this handoff.
3. **Course synonym coverage:** the six missing-name labels now map through an explicit lookup to one `not_recorded` status, following the course's lookup pattern. Confirm whether that meets the intended synonym requirement alongside the geographic crosswalk. ZIPs and ZCTAs are related geographies rather than interchangeable names, and case normalization alone is not synonym handling. If another example is required, use an evidenced alias lookup; do not invent dog-name equivalences to satisfy the rubric.

These questions concern integration, shared interpretation and course acceptance; the dog-level CSV is usable independently. Income grouping, plots, rarity/diversity extensions and equivalent pandas/SQL/Power Query workflows remain later work. Issue #1 stays open through the agreed review and acceptance; this first contribution does not claim completion of the full project.

## Prepared PR description
Unpublished preparation for the eventual data PR.

Contributes to #1. Prepares one row per named estimated dog from NYC's 2024 license extract, with original names, quality flags, broad SSA recognition and overlapping top-100 decade memberships. The saved handoff contains 92,963 estimated dogs; all 105,974 source records are accounted for in the lineage and missingness outputs.

Includes the fixed NYC and official SSA source snapshots with checksums, the six-label missing-name lookup, three Quarto notebooks for preparation and analysis plus separate saved-file checks, generated CSVs, and `dog-names.qmd`, `data/dog-name-data-dictionary.md` and `docs/active-spikes/dog-baby-name-data.md`. The official SSA archive was acquired through the browser after command-line downloads returned 403.

All 21 saved-file checks pass, covering latest-license selection and deterministic ties, unique five-field dog keys, complete source-to-dog lineage, unchanged dog count through the SSA join, exactly 100 names per decade, retained uncertain records and matching flags. An independent calculation from both raw sources agrees with every dog representative and SSA flag. The three independently rendered notebooks produce fourteen output CSVs including the check results. Runtime versions, per-stage counts and quality summaries are included.

Review the documented identity approximation and the CSV interface for Shweta's ZIP–ZCTA and income work. Missingness is a license-record measure, and decade memberships can overlap. Income joins, plots, other-language implementations and shared acceptance remain separate work. Keep issue #1 open after this partial contribution; integration does not imply project acceptance.

The R style policy requires a separate issue and PR. Keep the policy commit out of this PR’s change set; integrate the policy PR first and compare this contribution against the updated target before publication.

## Missing-name implementation decision
The six agreed labels and retention of BABY are settled. Aslan requested a side-by-side comparison of list membership with %in% versus joining the status lookup and using replace_na(). The existing lookup remains in the running pipeline pending that selection. Use one approach for this classification after the decision.
