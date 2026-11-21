# Income preparation review slides
Slide text and notes for the November 20 asynchronous review.

## 1. Income preparation review
Barkonomics
Suggestions for Shweta’s asynchronous review
November 20, 2026

Speaker notes: Read with preparation-reconciliation.md and the runnable income-areas.qmd example. This package concerns preparation only.

## 2. What we are reviewing
Shweta’s income-areas.qmd remains the starting point for ZIP, Census-area and income preparation.

Aslan’s dog and baby-name preparation stays on his separate branch and is still being reviewed.

The example shows suggested changes to income preparation. It does not merge the contributions or choose the final analysis.

Speaker notes: Document section 1. Review each change as keep, adjust, or discuss. The example is based on Shweta’s public commit 64cd25c.

## 3. The proposed prepared table
Each row represents one postal ZIP and the income information for its assigned Census area.

ZIP → ZCTA → median household income

Keep zip_areas and area_income as intermediate tables. Finish by joining them into zip_income, which later work can use directly.

Speaker notes: Document sections 1 and 6. This joins the two preparation sources, not dogs. Several ZIPs can share the same ZCTA and estimate.

## 4. Read the saved Census snapshot
Current: if the saved JSON is missing, the notebook tries to download it using a Census API key.

Suggestion: read the committed file directly. Keep acquisition instructions with the source documentation.

Why: our walkthrough uses a fixed snapshot. A download fallback adds credentials and network behavior that the preparation does not need.

Speaker notes: Document section 2 contains the current fallback and full replacement code. The example runs without a Census API key or network download.

## 5. Read the JSON grid as a table
The first row contains headings. Use those headings, then keep the remaining rows as records.

```r
income_raw <- jsonlite::fromJSON(
  "data/raw/acs5_2024_b19013_zcta.json"
)
colnames(income_raw) <- income_raw[1, ]

income_raw[-1, ] |>
  as_tibble() ->
  income_records
```

Speaker notes: Document section 2. [1, ] means first row, all columns; [-1, ] means all rows except the first, all columns. The file is a grid of text, not a nested object needing repeated unnesting.

## 6. Use the supplied ZCTA identifier
Current: split “ZCTA5 10001” to extract 10001, then check it against another column containing 10001.

Suggestion: use the supplied “zip code tabulation area” column and name it zcta.

Why: the identifier is already available. Reconstructing it adds an operation and a comparison without adding information.

```r
rename(zcta = `zip code tabulation area`)
```

Speaker notes: Document section 3. This is a fragment of the field-selection step, not a complete pipeline. Keep the identifier as text.

## 7. Separate conversion from cleanup
First select the area identifier, income and margin of error.

Next convert the two amounts from text to numbers.

Then interpret the Census special codes. Giving these steps separate chunks makes each operation visible and easier to explain.

```r
income_fields |>
  mutate(
    income = as.numeric(income),
    income_margin_of_error =
      as.numeric(income_margin_of_error)
  ) ->
  income_numbers
```

Speaker notes: Document section 3. Conversion alone does not turn special negative codes into missing values. That is the following cleaning step.

## 8. Missing income is not zero income
Current behavior worth keeping: negative Census codes become missing values. They are not negative household incomes.

Example: −666666666 is source information about an unavailable estimate.

Preserve the row with income = NA and income_status = “no estimate”. Clean special margin-of-error codes in the same way.

Speaker notes: Document section 4. Census special-value notes: https://www.census.gov/data/developers/data-sets/acs-1year/data-notes.html . NA means missing, not zero. The actual source is the saved 2024 ACS five-year B19013 table.

## 9. A capped estimate needs a distinct status
Current: 250001 remains in numeric income, although the status identifies a cap.

Suggestion: income = NA; income_status = “$250,000 or more”.

Why: the source does not report an exact $250,001 estimate. The status retains what we know and distinguishes it from “no estimate”. No extra lower-bound column is needed.

Speaker notes: Document section 4. Assign status before replacing source codes. This is a preparation representation; treatment in later calculations remains a separate decision.

## 10. Remove the raw income display label
Current income_label combines the original text fields before cleaning. It can display:

−666666666 ± −222222222
250001 ± −333333333

Suggestion: remove this unused label. If the report later needs one, construct it from cleaned amounts and income_status.

Speaker notes: Document section 5. This is separate from the decision about retaining uncertainty calculations. The example removes the label but preserves the calculation.

## 11. What the uncertainty calculation means
For ZCTA 10001, income is $129,852 and the supplied margin of error is $25,244.

$25,244 ÷ 1.645 ≈ $15,346 standard error
$15,346 ÷ $129,852 ≈ 11.8% relative uncertainty

This describes sampling precision. It does not evaluate ZIP mapping quality or give the probability that the estimate is correct.

Speaker notes: Document section 5. The ACS margin of error is at 90% confidence. Formula and interpretation: https://psrc.github.io/psrccensus/articles/calculate-reliability-moe-transformed-acs.html . The example is from the committed source.

## 12. Confirm the source of the category cutoffs
The notebook uses 15% and 30% boundaries without a citation.

These match Housing Assistance Council guidance. That is a plausible precedent, not proof of where the original choice came from.

Could you confirm the source you used? Then we can cite it beside the calculation. If none was selected, we can choose a convention together.

Speaker notes: Document section 5. HAC: https://www.ruraldatacentral.org/Content/DataReliability . HAC notes no universal agreement. PSRC uses similar boundaries plus a further category above 50%. The example retains the existing cutoffs pending review.

## 13. Keep the calculation; review the wording
The example retains the calculation and existing ordinary category labels for discussion. Their removal has not been agreed.

It changes “not measured” to “cannot calculate” when an input is missing. income_status explains whether the income is capped or unavailable.

Open wording choice: would lower, moderate and higher relative sampling uncertainty be clearer than “reliable” and “unreliable”?

Speaker notes: Document section 5. Existing numerical boundaries and ordinary labels remain in code. No category proves overall data quality or readiness for a particular analysis.

## 14. Name ZIP once, then finish the lookup
The import line is an excerpt. The runnable notebook contains all renames. Keep the existing NYC prefix rule and exceptions.

```r
# At crosswalk import:
rename(zipcode = ZIP_CODE, ...)

# After preparing area_income:
zip_areas |>
  left_join(area_income, by = "zcta") |>
  select(zipcode, zcta, borough, in_nyc,
         income, income_margin_of_error,
         income_status, income_cv,
         income_reliability) ->
  zip_income
```

Speaker notes: Document section 6. A left join keeps every crosswalk ZIP. ZCTA is retained to show which Census area supplied income. Reliability fields remain provisional.

## 15. Show the preparation’s actual results
Keep three purposeful displays:

A borough summary counting ZIPs and distinct Census areas.

An income-status summary counting each area once.

One ZIP-to-area-to-income example for each status, so ordinary, capped and missing estimates are all visible.

Speaker notes: Document section 7 contains the complete code and examples. Remove the nested example-string construction and development-only uniqueness displays after verification. Avoid attributing missing values to airports or offices without evidence.

## 16. What the example preserved and changed
Verified: all 41,061 ZIP rows, unique ZIP keys, the existing geographic classifications, and ordinary income estimates and margins of error.

Within the current NYC rule: 211 Census areas — 177 ordinary estimates, 4 capped estimates and 30 without estimates.

Changed: capped numeric income becomes missing with a clear status; preparation ends in zip_income and simpler displays.

Speaker notes: Fresh execution of the illustrative income notebook on November 20, 2026. Original and proposed ordinary income, margin of error and CV were identical. There are 33,772 rows in area_income. Counts are areas or ZIPs, not dogs.

## 17. How to review the example asynchronously
Read a document section, inspect the matching notebook chunk, and run it. An agent can guide you through the same sequence.

For each recommendation, note keep, adjust or discuss. Please confirm the reliability-threshold source and review the proposed output columns.

This branch is a preparation example. The existing final report still expects older fields; migrating analysis consumers is a separate review.

Speaker notes: The source package includes the modified income-areas.qmd, the two unchanged source snapshots, a patch against 64cd25c, this document, and review instructions. Neither contribution branch was merged. No final report render is claimed.

