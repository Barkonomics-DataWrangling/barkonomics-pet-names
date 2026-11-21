# Income preparation review slides
Editable walkthrough: https://docs.google.com/presentation/d/15lxUo5oVaeMiJuoH-nFm8dnaOQn9rk5w-Z-8A4Yf4Jk/edit

GitHub comparison: https://github.com/Barkonomics-DataWrangling/barkonomics-pet-names/compare/shweta/income-zcta-data...aslan/income-preparation-suggestions

Text companion to the visual slides. Code blocks are excerpts; the branch contains the runnable notebook.

## 1. Income preparation review
Barkonomics
Suggestions for Shweta’s asynchronous review
November 20, 2026

Speaker notes: Read with preparation-reconciliation.md and the runnable income-areas.qmd example. This package concerns preparation only.

## 2. Separate contributions; one preparation review
This example changes income preparation only. Aslan’s dog review continues separately; neither contribution is merged.

ASLAN

Dog licenses
↓
dogs_prepared

Baby-name records
↓
Annual and decade tables

SHWETA

ZIP crosswalk + Census income
↓
income-areas.qmd
↓
Proposed zip_income lookup

Speaker notes: Document section 1. Review each change as keep, adjust, or discuss. The example is based on Shweta’s public commit 64cd25c.

## 3. One lookup, with the source area visible
Each output row is a postal ZIP. Two ZIPs may use the same Census area and therefore the same income estimate.

POSTAL ZIP

CENSUS AREA

INCOME

ZIP A

ZIP B

↘
↗

ZCTA X

→

One estimate
for area X

Illustrative identifiers. The output retains ZIP, ZCTA and the estimate.

Speaker notes: Document sections 1 and 6. This joins the two preparation sources, not dogs. Several ZIPs can share the same ZCTA and estimate.

## 4. Use the saved input as the starting point
Current excerpt: a missing file triggers a network download. Proposed: read the committed snapshot. Acquisition instructions belong with source documentation.

CURRENT

PROPOSED

```
if (!file.exists(acs_path)) {
  census_key <- Sys.getenv(
    "CENSUS_API_KEY"
  )
  download.file(...)
}
```

→

```
income_raw <-
  jsonlite::fromJSON(
    "data/raw/acs5_2024_b19013_zcta.json"
  )
```

Speaker notes: Document section 2 contains the current fallback and full replacement code. The example runs without a Census API key or network download.

## 5. The JSON header becomes column names
[1, ] selects the first row; [-1, ] keeps the other rows. This format conversion turns the saved grid into records.

SOURCE GRID (abbreviated)

| Row | Column 1 | Column 2 |
| --- | --- | --- |
| 1 | NAME | B19013_001E |
| 2 | ZCTA5 10001 | 129852 |

→

PREPARED RECORD

| NAME | B19013_001E |
| --- | --- |
| ZCTA5 10001 | 129852 |

```
colnames(income_raw) <- income_raw[1, ]
income_raw[-1, ] |> as_tibble() -> income_records
```

Speaker notes: Document section 2. [1, ] means first row, all columns; [-1, ] means all rows except the first, all columns. The file is a grid of text, not a nested object needing repeated unnesting.

## 6. Use the ZCTA column already supplied
Both routes obtain 10001. Using the supplied identifier removes the extraction and the later comparison with a duplicate identifier. These are code excerpts.

CURRENT

PROPOSED

```
rename(
  area_name = NAME,
  zcta_api =
    `zip code tabulation area`
) |>
separate_wider_delim(
  area_name, delim = " ",
  names = c("geo_prefix", "zcta")
)
```

→

```
rename(
  zcta =
    `zip code tabulation area`
)
```

Speaker notes: Document section 3. This is a fragment of the field-selection step, not a complete pipeline. Keep the identifier as text.

## 7. Give each transformation its own step
Separate stages make the conversion and special-code decisions visible. The data and cleaning choices stay the same.

CURRENT

One long pipeline

rename → extract
→ convert → recode
→ calculate → label
→ select

PROPOSED

income_fields
↓ convert amounts to numbers
income_numbers
↓ interpret special codes
income_clean
↓ describe sampling precision
area_income

Speaker notes: Document section 3. Conversion alone does not turn special negative codes into missing values. That is the following cleaning step.

## 8. Missing estimates: preserve the row, clean the code
This existing cleaning behavior stays. A negative special code is not negative household income; NA is missing, not zero.

| Source income | Prepared income | income_status |
| --- | --- | --- |
| 129852 | 129852 | estimate |
| −666666666 | NA | no estimate |

```
income_status = case_when(
  income < 0 ~ "no estimate",
  ...
)
```

Speaker notes: Document section 4. Census special-value notes: https://www.census.gov/data/developers/data-sets/acs-1year/data-notes.html . NA means missing, not zero. The actual source is the saved 2024 ACS five-year B19013 table.

## 9. Capped estimates: keep the threshold in the status
250001 is a source code for “$250,000 or more,” not an exact $250,001 estimate. No extra lower-bound column is proposed.

| Record | Numeric income | Status |
| --- | --- | --- |
| Current capped row | 250001 | top-coded ($250,000+) |
| Proposed capped row | NA | $250,000 or more |
| Proposed missing row | NA | no estimate |

Speaker notes: Document section 4. Assign status before replacing source codes. This is a preparation representation; treatment in later calculations remains a separate decision.

## 10. Remove the label built from uncleaned text
The current label can display Census special codes as dollar amounts. A later report can format cleaned values when a display label is actually needed.

CURRENT

PROPOSED

```
income_label = str_c(
  income_text, " ± ", moe_text
)

Possible output:
-666666666 ± -222222222
250001 ± -333333333
```

→

```
Keep separate cleaned fields:

income
income_margin_of_error
income_status

Remove income_label.
```

Speaker notes: Document section 5. This is separate from the decision about retaining uncertainty calculations. The example removes the label but preserves the calculation.

## 11. Relative sampling uncertainty, step by step
Example: ZCTA 10001. This measures sampling precision, not ZIP mapping quality or the probability that an estimate is correct.

Margin of error

$25,244

÷ 1.645 →

Standard error

≈ $15,346

$15,346 ÷ $129,852 income ≈ 0.118

Coefficient of variation: about 11.8%

Speaker notes: Document section 5. The ACS margin of error is at 90% confidence. Formula and interpretation: https://psrc.github.io/psrccensus/articles/calculate-reliability-moe-transformed-acs.html . The example is from the committed source.

## 12. The boundaries are conventions to confirm
HAC uses these boundaries; it is a plausible precedent, not confirmed provenance. Could Shweta confirm the source so it can be cited beside the calculation?

| Coefficient of variation | Current category |
| --- | --- |
| Below 15% | reliable |
| 15% to below 30% | use with care |
| 30% and above | unreliable |

29.9%  |  30.0%
A category changes here; precision does not suddenly collapse.

Speaker notes: Document section 5. HAC: https://www.ruraldatacentral.org/Content/DataReliability . HAC notes no universal agreement. PSRC uses similar boundaries plus a further category above 50%. The example retains the existing cutoffs pending review.

## 13. Missing calculation inputs need clearer wording
Keep the calculation and existing ordinary labels pending review. Lower/moderate/higher relative uncertainty is a separate wording proposal.

| income_status | Current reliability label | Proposed label |
| --- | --- | --- |
| $250,000 or more | not measured | cannot calculate |
| no estimate | not measured | cannot calculate |

The calculation lacks an exact income or usable margin of error.
The income status preserves why the amount is unavailable.

Speaker notes: Document section 5. Existing numerical boundaries and ordinary labels remain in code. No category proves overall data quality or readiness for a particular analysis.

## 14. Build the geographic lookup before using dog data
These are excerpts. A left join keeps every crosswalk ZIP. Name ZIP “zipcode” during import; retain zcta to show which area supplied the estimate.

CURRENT

PROPOSED

```
Later analysis currently does:

dogs |>
  left_join(zip_areas, ...) |>
  left_join(area_income, ...)
```

→

```
Preparation produces:

zip_areas |>
  left_join(area_income,
            by = "zcta") ->
  zip_income

Later work can use this lookup.
```

Speaker notes: Document section 6. A left join keeps every crosswalk ZIP. ZCTA is retained to show which Census area supplied income. Reliability fields remain provisional.

## 15. Use examples that show all three income statuses
Show a short borough summary and area-status counts too. These examples are display selections; they do not filter the prepared lookup.

| ZIP → ZCTA | Income | Margin of error | Status |
| --- | --- | --- | --- |
| 10001 → 10001 | 129852 | 25244 | estimate |
| 10004 → 10004 | NA | NA | $250,000 or more |
| 10020 → 10020 | NA | NA | no estimate |

One example per status exposes what the cleaning accomplished.

Speaker notes: Document section 7 contains the complete code and examples. Remove the nested example-string construction and development-only uniqueness displays after verification. Avoid attributing missing values to airports or offices without evidence.

## 16. Preparation checks: what stayed the same
Ordinary income, margin-of-error and coefficient-of-variation values are unchanged. Capped numeric amounts become missing with a distinct status.

| Verified property | Original | Example |
| --- | --- | --- |
| Postal ZIP rows | 41,061 | 41,061 |
| Census area rows | 33,772 | 33,772 |
| NYC selected areas | 211 | 211 |
| Ordinary / capped / missing | 177 / 4 / 30 | 177 / 4 / 30 |

Speaker notes: Fresh execution of the illustrative income notebook on November 20, 2026. Original and proposed ordinary income, margin of error and CV were identical. There are 33,772 rows in area_income. Counts are areas or ZIPs, not dogs.

## 17. Review the code directly on GitHub
Review one document section and its notebook chunk together. Note keep, adjust or discuss. Analysis consumers and the combined report remain a separate review.

1  Read the current/proposed explanation

2  Compare the suggestions branch against Shweta’s branch

3  Run income-areas.qmd from the repository root

4  Confirm the reliability source and discuss open wording

Open the GitHub comparison →

Speaker notes: Review the published aslan/income-preparation-suggestions branch against shweta/income-zcta-data on GitHub. The branch changes income preparation and review documentation only. Neither contribution branch was merged. Existing analysis consumers require a separate reconciliation; no final report render is claimed.
