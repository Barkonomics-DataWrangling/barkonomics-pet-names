# Preparation reconciliation: dog names, baby names and area income
Prepared for Shweta’s asynchronous review — November 20, 2026

This document proposes a common preparation baseline for Barkonomics. Aslan’s dog and baby-name notebooks are the starting point for those datasets. Shweta’s `income-areas.qmd` is the starting point for the geographic and income datasets. Each contributor retains ownership of their preparation work.

The main recommendations concern `income-areas.qmd`: make the source cleaning easier to follow and finish with one table connecting postal ZIPs to Census areas and their income information. The aim is a pipeline we can each walk through and explain, with the important source limitations visible.

These are suggestions from Aslan for Shweta’s review. The accompanying example implements them on `aslan/income-preparation-suggestions`, based on Shweta’s public contribution. Her branch and Aslan’s dog/baby branch remain separate. The example demonstrates the recommendations; it does not record Shweta’s acceptance or integrate the final analysis.

Income groups, dog/baby matching, comparisons and final report assembly are outside this review. Neither contributor’s proposed analysis is being adopted here.

## 1. The preparation baseline
### Ownership and outputs
**Aslan — dog-names.qmd:** `dogs_prepared` has one estimated dog per row under the current consolidation rule.

**Aslan — baby-names.qmd:**

- `ssa_yearly`: one published name/sex/year record, with formatted name and decade.
- `ssa_decades`: one name in one decade, with total births and rank.
- `ssa_top100_names`: one name in one decade’s top 100; a name can occur in several decades.
- `ssa_all_names`: one distinct formatted name from 1880–2019.

**Shweta — income-areas.qmd:** `zip_areas` has one postal ZIP and its assigned Census area, with geographic classification. `area_income` has one Census area and its income information.

**Proposed finished output from Shweta’s preparation:** `zip_income` has one postal ZIP, its assigned Census area and that area’s income information. Both component tables remain available as intermediate stages.

The baby-name tables describe different levels of detail: annual records, decade totals and ranks, top-100 pairs, and a distinct-name reference. Their names describe the current local preparation, not a frozen interface. Aslan is continuing his own code review separately.

The proposed `zip_income` lookup is built from Shweta’s two prepared tables. Those tables remain useful intermediate objects in memory; no intermediate CSV exports are needed. This review does not require Shweta to adopt Aslan’s dog-consolidation logic or review it before discussing income preparation.

### How to use this package
Read sections 2–8 alongside `income-areas.qmd` in the example branch or source package. Each section shows the relevant current code, explains the proposed change and identifies any decision still open. Section 9 is a response checklist. The slides provide a shorter guided walkthrough; the document and runnable example contain the full detail.

Run the example notebook’s chunks from top to bottom in a fresh R session with the repository root as the working directory. It reads the two existing snapshots and produces `zip_income`; it needs `tidyverse`, `readxl` and `jsonlite`. It does not require the dog or baby-name notebooks, a Census API key, or `helpers.R`.

**Integration boundary:** the illustrative branch only changes preparation and adds review materials. Existing analysis consumers still expect fields such as `zip5` and `income_moe`. They have not been migrated to `zipcode`, `income_margin_of_error` and `zip_income`; do not use this branch as an updated final report. We will reconcile analysis and assembly separately.

## 2. Start income preparation from the saved Census file
**Recommendation supported by Aslan; for Shweta’s review.**

### Current code
The notebook defines a saved-file path, checks whether it exists, and downloads a replacement using a Census API key if it does not:

```r
acs_path <- "data/raw/acs5_2024_b19013_zcta.json"

if (!file.exists(acs_path)) {
  census_key <- Sys.getenv("CENSUS_API_KEY")
  download.file(
    str_c("https://api.census.gov/data/2024/acs/acs5",
          "?get=NAME,B19013_001E,B19013_001M",
          "&for=zip%20code%20tabulation%20area:*",
          "&key=", census_key),
    acs_path, mode = "wb"
  )
}
```

The source JSON is already supplied in the repository. Downloading data and preparing that saved data are different tasks. The notebook’s fallback adds a credential and network dependency to the explanation even though our walkthrough uses the snapshot.

### Proposed code
Read the saved file directly, then give its columns the names supplied in its first row:

```r
income_raw <- jsonlite::fromJSON("data/raw/acs5_2024_b19013_zcta.json")
colnames(income_raw) <- income_raw[1, ]

income_raw[-1, ] |>
  as_tibble() ->
  income_records
```

`fromJSON()` reads the saved grid of text. `[1, ]` selects its first row, which contains the headings. `[-1, ]` keeps every row except that heading row. The empty position after the comma means keep all columns. `as_tibble()` makes the result a table for the tidyverse steps.

Keep acquisition instructions and the source URL with the dataset documentation, outside the preparation walkthrough. The notebook should say that it reads the committed snapshot; it should not describe a download that no longer occurs.

## 3. Use the supplied area identifier and separate numeric conversion
**Recommendation supported by Aslan; for Shweta’s review.**

### Current code
This excerpt from `prepare-area-income` both reconstructs an area identifier from the descriptive name and converts income fields to numbers:

```r
area_income <- as_tibble(acs_grid[-1, ]) |>
  rename(
    area_name = NAME,
    income_text = B19013_001E,
    moe_text = B19013_001M,
    zcta_api = `zip code tabulation area`
  ) |>
  separate_wider_delim(area_name, delim = " ", names = c("geo_prefix", "zcta")) |>
  mutate(
    income_code = as.numeric(income_text),
    moe_code = as.numeric(moe_text)
  )
```

This is an excerpt: the current pipeline continues into cleanup and reliability calculations. It takes a description such as `ZCTA5 10001`, splits it at the space, and calls the second part `zcta`. But the API already supplies `10001` in its `zip code tabulation area` column. The current code retains that supplied code as `zcta_api` and later checks that the reconstructed code matches it.

### Proposed code: select the supplied fields

```r
income_records |>
  rename(
    zcta = `zip code tabulation area`,
    income = B19013_001E,
    income_margin_of_error = B19013_001M
  ) |>
  select(zcta, income, income_margin_of_error) ->
  income_fields
```

This retains the actual area identifier, income estimate and supplied margin of error. The ZCTA stays text: it is an identifier, not a quantity.

### Proposed code: convert the two amounts to numbers

```r
income_fields |>
  mutate(
    income = as.numeric(income),
    income_margin_of_error = as.numeric(income_margin_of_error)
  ) ->
  income_numbers
```

The conversion makes the two fields numeric. It does not yet interpret the Census special codes. Naming this intermediate table gives us a clear place to inspect the conversion before explaining the next operation.

The proposed identifier change eliminates the need to compare `zcta` with `zcta_api`. It does not eliminate the separate fact that an area-income lookup should have one row per ZCTA. That row uniqueness was checked during preparation review; the final walkthrough need not retain a diagnostic whose only output is a maximum count of one.

## 4. Represent missing and capped income honestly
**Aslan’s selected recommendation; for Shweta’s review.**

### Current code
After numeric conversion, the notebook assigns statuses and turns negative source codes into missing values:

```r
mutate(
  income_status = case_when(
    income_code < 0 ~ "no estimate",
    income_code == 250001 ~ "top-coded ($250,000+)",
    .default = "estimate"
  ),
  income = case_when(income_code < 0 ~ NA, .default = income_code),
  income_moe = case_when(moe_code < 0 ~ NA, .default = moe_code)
)
```

Negative codes are not negative household incomes. For example, the saved input contains income code `-666666666` with margin-of-error code `-222222222`. Converting those to missing values is necessary cleaning.

The code also recognizes `250001` as “$250,000 or more,” but leaves `250001` in the numeric income column. That is a reporting code, not an exact estimate of $250,001. The proposed representation keeps the threshold information in the status and leaves the numeric amount missing.

| Source information | Proposed `income` | Proposed `income_status` |
| --- | --- | --- |
| An ordinary estimate, for example 129852 | 129852 | estimate |
| Capped code 250001 | `NA` | $250,000 or more |
| No usable income estimate | `NA` | no estimate |

No lower-bound column is proposed. The status preserves the distinction between an unavailable estimate and an estimate reported only as a threshold.

### Proposed code
Assign the status before replacing special values, so the information in those codes is preserved:

```r
income_numbers |>
  mutate(
    income_status = case_when(
      income < 0 ~ "no estimate",
      income == 250001 ~ "$250,000 or more",
      .default = "estimate"
    )
  ) |>
  mutate(
    income = case_when(
      income_status == "estimate" ~ income,
      .default = NA_real_
    ),
    income_margin_of_error = case_when(
      income_margin_of_error < 0 ~ NA_real_,
      .default = income_margin_of_error
    )
  ) ->
  income_clean
```

`case_when()` chooses the result for the first matching condition. `.default` supplies the result otherwise. `NA_real_` is R’s missing value for a numeric column; it does not mean zero. Each area remains a row, including areas without an exact income estimate.

The supplied margin of error is retained when it is an ordinary amount. Negative special codes in that field become missing values. Those special codes do not describe a usable dollar margin of error.

Source interpretation: [Census API annotation notes](https://www.census.gov/data/developers/data-sets/acs-1year/data-notes.html). The linked notes explain the special-value conventions; the actual input here is the saved 2024 ACS five-year table.

## 5. Keep the uncertainty calculation under review and document its source
**Open question for Shweta. Removal of the calculation or categories is not an agreed change.**

### Current code

```r
mutate(income_cv = (income_moe / 1.645) / income) |>
  mutate(
    income_reliability = case_when(
      is.na(income_cv) ~ "not measured",
      income_cv < 0.15 ~ "reliable",
      income_cv < 0.30 ~ "use with care",
      .default = "unreliable"
    ),
    income_label = str_c(income_text, " ± ", moe_text)
  )
```

There are two separate operations in this excerpt. The first calculates relative sampling uncertainty and groups it into categories. The second builds a display label from the original text. They need separate treatment.

### The uncertainty calculation
`income_cv` is a coefficient of variation: the estimate’s standard error divided by the estimate itself. Dividing the supplied 90% margin of error by 1.645 obtains the standard error. Dividing that by income expresses the sampling uncertainty relative to the income amount. A smaller result describes greater relative precision; it does not certify all aspects of data quality or assess the ZIP mapping.

For example, the saved ZCTA 10001 record has income 129852 and margin of error 25244. The calculation is `(25244 / 1.645) / 129852`, about 0.118, or 11.8%. The current rule puts it in the category below 15%. That is a classification of relative sampling uncertainty, not a probability that the income estimate is correct.

### Request to Shweta: confirm and cite the threshold source
The notebook does not cite a source for the 15% and 30% cutoffs. These boundaries match the [Housing Assistance Council’s reliability guidance](https://www.ruraldatacentral.org/Content/DataReliability). Similar boundaries appear in [Puget Sound Regional Council guidance](https://psrc.github.io/psrccensus/articles/calculate-reliability-moe-transformed-acs.html), which also explains the 1.645 conversion.

HAC is a plausible source or precedent, but matching thresholds do not establish where this implementation obtained them. Could you confirm the source you used? Then we can cite it beside the calculation. If no source was originally selected, we can choose and cite a convention together.

Both references treat these categories as guidance, not a universal standard. HAC explicitly notes disagreement over cutoffs; PSRC uses an additional category above 50%. A result just below 30% is not fundamentally different from one just above it.

### Proposed code while the categories remain under review
Retain the existing boundaries and ordinary category labels for now. Use the descriptive margin-of-error field name, separate the two transformations, and change “not measured” to “cannot calculate”:

```r
income_clean |>
  mutate(income_cv = (income_margin_of_error / 1.645) / income) ->
  income_with_precision

income_with_precision |>
  mutate(
    income_reliability = case_when(
      is.na(income_cv) ~ "cannot calculate",
      income_cv < 0.15 ~ "reliable",
      income_cv < 0.30 ~ "use with care",
      .default = "unreliable"
    )
  ) ->
  area_income
```

This is a conservative candidate, not approval of the thresholds or a final choice of labels. “Cannot calculate” means an ingredient of the calculation is missing. For capped rows, the exact income is unavailable; for rows without an estimate, there is no income amount. `income_status` preserves the difference.

A further recommendation for discussion is to use “lower,” “moderate,” and “higher relative sampling uncertainty” instead of “reliable” and “unreliable.” That would describe what was calculated more narrowly. This wording change is not included in the candidate code above so that it remains a visible choice.

### Remove the misleading display label
The current `income_label` uses raw text rather than cleaned values. Actual source combinations produce labels such as:
```text
-666666666 ± -222222222
250001 ± -333333333
```
These are not meaningful dollar estimates and margins of error. Recommend removing this unused column, as the candidate code above does. Any later presentation label should be constructed from cleaned amounts and their status.

## 6. Finish with one ZIP-to-income lookup
**Recommendation supported by Aslan; for Shweta’s review.**

### Current behavior
The notebook creates `zip_areas` and `area_income` separately. It joins them for a diagnostic but does not save that joined result as its prepared output:

```r
zip_areas |>
  filter(in_nyc) |>
  distinct(zcta) |>
  left_join(area_income, by = "zcta") |>
  count(income_status, income_reliability, name = "nyc_areas")
```

This diagnostic filters to NYC ZIPs, reduces them to distinct ZCTAs, attaches income, and counts statuses. It produces a summary rather than a reusable ZIP lookup.

### Proposed code: name the ZIP field once
The current crosswalk import uses `rename(zip5 = ZIP_CODE, ...)`. Give that source field its final working name during import:

```r
zip_crosswalk <- readxl::read_excel(
  "data/raw/ZIPCodetoZCTACrosswalk2024UDS.xlsx",
  sheet = "ZiptoZCTA",
  col_types = "text"
) |>
  rename(
    zipcode = ZIP_CODE,
    post_office = PO_NAME,
    state = STATE,
    zcta = ZCTA,
    zip_join_type = ZIP_JOIN_TYPE
  )
```

Use `zipcode` consistently in the following classification step. The prefix list, exceptions and geographic rule are unchanged:

```r
nyc_prefixes <- tribble(
  ~zip_prefix, ~borough,
  "100", "Manhattan",
  "101", "Manhattan",
  "102", "Manhattan",
  "103", "Staten Island",
  "104", "Bronx",
  "111", "Queens",
  "112", "Brooklyn",
  "113", "Queens",
  "114", "Queens",
  "116", "Queens"
)

zip_areas <- zip_crosswalk |>
  mutate(zip_prefix = str_sub(zipcode, 1, 3)) |>                # characters 1 to 3
  left_join(nyc_prefixes, by = "zip_prefix") |>
  mutate(borough = case_when(
    zipcode == "11004" | zipcode == "11005" ~ "Queens",           # Glen Oaks, Floral Park
    .default = borough
  )) |>
  mutate(in_nyc = !is.na(borough))
```

### Proposed code: attach the prepared income
After preparing the area income, attach it to every ZIP in the crosswalk and save the result:

```r
zip_areas |>
  left_join(area_income, by = "zcta") |>
  select(
    zipcode,
    zcta,
    borough,
    in_nyc,
    income,
    income_margin_of_error,
    income_status,
    income_cv,
    income_reliability
  ) ->
  zip_income
```

For each crosswalk row, `left_join()` finds the income row with the same ZCTA and adds its fields. A left join keeps all ZIP rows, including those without a matching income row. An inner join would discard those unmatched ZIPs. Income fields for an unmatched area remain missing; that situation is different from a Census row explicitly carrying a “no estimate” status.

`zipcode` keeps the working name assigned during crosswalk import; the final selection does not rename it again. `zcta` identifies the Census area that supplies the estimate. Several ZIPs can share that area and therefore share the same income information. Retaining `zcta` lets a reader inspect that mapping.

The candidate retains `income_cv` and `income_reliability` pending the decision in section 5. Their presence here does not settle whether to retain them permanently. `post_office`, `state`, `zip_join_type` and the intermediate prefix remain available in the imported/prepared crosswalk but are not included in this output.

Keep all crosswalk ZIP rows in the lookup. `in_nyc` records the existing classification; it does not remove rows. The earlier source review found 41,061 distinct crosswalk ZIPs and 33,772 distinct Census areas. A ZIP-to-income join preserved the 41,061 ZIP rows. No dog table is needed to complete or explain this operation.

## 7. Show what the preparation produced
**Summary approach supported by Aslan; proposed code for review.**

### Current code
The current borough summary combines useful counts with checks and nested constructions of example strings:

```r
zip_areas |>
  filter(in_nyc) |>
  group_by(borough) |>
  summarize(
    zips = n(),
    areas = n_distinct(zcta),
    zips_without_area = sum(is.na(zcta)),
    states = str_c(unique(state), collapse = ", "),
    example_post_offices = str_c(head(unique(post_office), 4), collapse = ", ")
  )
```

It also computes a hidden `nyc_zips_per_area` table to insert several counts into prose. These displays can be replaced with a short table and actual mapping examples. Keep each summary’s row unit explicit: counting ZIPs is different from counting Census areas.

### Proposed borough summary

```r
zip_income |>
  filter(in_nyc) |>
  group_by(borough) |>
  summarise(
    zipcodes = n(),
    census_areas = n_distinct(zcta)
  )
```

This reports the number of ZIP rows and distinct Census areas assigned to each borough by the existing rule. It does not claim that a ZCTA’s full boundary lies inside that borough.

### Proposed income-availability summary

```r
zip_income |>
  filter(in_nyc) |>
  distinct(zcta, income_status) |>
  count(income_status, name = "census_areas")
```

Several ZIPs can use the same area’s income. `distinct(zcta, income_status)` counts that area once before tallying the three statuses. A missing status would remain visible as an `NA` category if an area did not match a Census row.

For the current NYC rule, the reviewed source data contain 211 distinct areas: 177 ordinary estimates, four capped estimates and 30 without an estimate. These counts describe Census areas, not dogs. The source review found no unmatched NYC area identifiers.

### Proposed mapping examples
Show one NYC mapping for each income status, rather than six arbitrary rows that may all look alike:

```r
zip_income |>
  filter(in_nyc) |>
  arrange(zipcode) |>
  group_by(income_status) |>
  slice_head(n = 1) |>
  ungroup() |>
  select(zipcode, zcta, income, income_margin_of_error, income_status)
```

The proposed display on the saved inputs returns:

| ZIP | ZCTA | Income | Margin of error | Income status |
| --- | --- | ---: | ---: | --- |
| 10004 | 10004 | `NA` | `NA` | $250,000 or more |
| 10001 | 10001 | 129852 | 25244 | estimate |
| 10020 | 10020 | `NA` | `NA` | no estimate |

Grouping by status makes the examples purposeful: one ordinary estimate, one cap and one missing estimate. `slice_head(n = 1)` selects one example from each group; it is a display choice, not a change to the prepared lookup. `ungroup()` ends that temporary grouping.

### Development checks to omit from the walkthrough
The current `test-crosswalk-key` counts rows per ZIP and reports the largest count. A result of 1 means each ZIP occurs once. The current `test-area-income` checks both row uniqueness and equality between a reconstructed code and the supplied code.

Recommend omitting these diagnostic displays from the narrative after verifying the proposed preparation. The reconstructed-code comparison disappears because section 3 uses the supplied code directly. Uniqueness remains important to the meaning of a lookup, but it need not become repeated checking machinery in the notebook. The record of development verification can remain with the change review.

## 8. Make the explanatory text match the preparation
**Recommendations for Shweta’s review.**

### Geographic mapping
The current notebook describes ZIPs as alternative names for one canonical area and concludes that dogs must later be grouped by area. Postal ZIPs and Census ZCTAs are related geographic systems, not simply alternative spellings. The crosswalk supplies a mapping between them.

Proposed notebook wording:
> The crosswalk assigns each postal ZIP to a Census area. Several ZIPs can map to the same area, so they share that area’s income estimate. We retain both identifiers to show where each estimate came from.

The [Census explanation of ZCTAs](https://www.census.gov/programs-surveys/geography/guidance/geo-areas/zctas.html) describes the geographic distinction. Whether this fulfills the course’s synonym-handling requirement should be confirmed separately, rather than asserted as a property of the crosswalk.

### Income availability and precision
The current takeaway attributes missing income estimates to offices, airports and places with few households. It also concludes that area income is precise enough for neighborhood comparison. The code shown does not establish either conclusion.

Proposed notebook wording:
> The table reports how many selected Census areas have an ordinary income estimate, a capped estimate or no estimate. Capped values retain their threshold in `income_status`; unavailable exact amounts are missing in `income`. The supplied margin of error remains available where reported.

If the precision summary is retained, explain its chosen thresholds beside that summary and cite their source. Do not infer reasons for missing estimates from the special code alone.

## 9. Review decisions and next steps
| Item | Current review position | Response needed from Shweta |
| --- | --- | --- |
| Read the committed Census file | Aslan supports removing the download fallback | Confirm the simpler preparation entry point |
| Supplied ZCTA and separate conversion | Aslan supports direct naming and shorter purposeful steps | Review the proposed sequence |
| Missing and capped values | Aslan supports `NA` plus distinct status, without a lower-bound column | Confirm the representation |
| Raw display label | Aslan supports removing the misleading unused field | Confirm removal |
| Precision calculation | Remains in the candidate pending discussion | Confirm its purpose and the source of the thresholds |
| Precision wording | “Cannot calculate” supported by Aslan; less categorical ordinary labels proposed | Confirm wording and any retained categories |
| Unified lookup | Aslan supports one ZIP-to-income table, retaining `zcta` | Review output columns, including provisional precision fields |
| Preparation displays | Aslan supports examples, borough counts and income-status counts | Review the proposed displays |
| Explanatory claims | Recommend geographic mapping language and supported source descriptions | Review the replacement prose |

The example retains the NYC prefix list and exceptions for 11004/11005. This review does not independently certify that a prefix rule exactly describes every NYC geographic boundary.

Please review each recommendation as “keep,” “adjust,” or “discuss,” with a short explanation where an alternative would help. In particular, confirm the source and purpose of the reliability categories. An agent can walk through the document and example one section at a time, but acceptance belongs to the collaborators.

Aslan will continue reviewing dog and baby-name preparation separately. After we agree on the component outputs, we can work through the analysis and final report as a second review. No analysis choice is implied by accepting this preparation.

## Source versions and verification
The example starts from Shweta’s public `shweta/income-zcta-data` commit `64cd25c37d058a144a34fe23166bccfc995947f8`, verified against the remote on November 20, 2026. Current-code excerpts are from that version. Local changes in her active checkout were not copied or overwritten. Aslan’s objects listed in section 1 describe his separate local work based on `fb734827bacbe9045e5ce69516b78daf8f3d5345`.

Related contributions: [Aslan’s PR #11](https://github.com/Barkonomics-DataWrangling/barkonomics-pet-names/pull/11) and [Shweta’s PR #9](https://github.com/Barkonomics-DataWrangling/barkonomics-pet-names/pull/9). Related outcomes: [dog and baby preparation, issue #1](https://github.com/Barkonomics-DataWrangling/barkonomics-pet-names/issues/1) and [income preparation, issue #2](https://github.com/Barkonomics-DataWrangling/barkonomics-pet-names/issues/2).

Fresh execution verified 41,061 unique ZIP rows and 33,772 unique area-income rows. Ordinary income estimates, margins of error and coefficient-of-variation values are identical to the original preparation. The existing NYC selection gives 177 ordinary, four capped and 30 missing-income areas.

The example keeps all crosswalk rows and existing geographic classifications. It retains ordinary income estimates, preserves capped versus missing status, and changes the names and sequencing described above. Verification results accompany the package. No dog join, data download, CSV export, analysis render or branch merge is part of this example.
