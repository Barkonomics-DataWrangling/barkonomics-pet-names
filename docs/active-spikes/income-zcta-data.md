---
attention: live
tags: [barkonomics, data, income, zcta, r]
---
# Income and ZIP–ZCTA data
Tracked by [issue #2: Prepare the income and ZIP–ZCTA data portion in R](https://github.com/Barkonomics-DataWrangling/barkonomics-pet-names/issues/2). [Tasks](income-zcta-data.todo.md).

## Purpose and ownership
Prepare the area-income side of Barkonomics in R: the HRSA ZIP-to-ZCTA crosswalk and ACS five-year median household income (table B19013) with margins of error by ZCTA. This spike belongs to Shweta's agent and this one thread of work. Aslan's dog-license and SSA baby-name portion ([issue #1](https://github.com/Barkonomics-DataWrangling/barkonomics-pet-names/issues/1)) is a separate thread with its own spike; this spike links to it but does not track it.

## Human decisions in force
- October 29 agreement (recorded in issues #1 and #2): Shweta owns income and ZIP–ZCTA data, Aslan owns dogs and baby names, both starting in R, working in parallel.
- November 5, 2:30 p.m. Central review is a progress checkpoint, not a completion deadline.
- Aslan and his agent review Shweta's contributions before an authorized merge.

## Sources (from the proposal snapshot)
- [HRSA ZIP Code to ZCTA Crosswalk 2024 (UDS)](https://data.hrsa.gov/DataDownload/GeoCareNavigator/ZIPCodetoZCTACrosswalk2024UDS.xlsx): TIGER 2023 ZCTAs, June 2023 ZIP data, unique ZIP keys, several ZIPs may share one ZCTA.
- [ACS 5-year B19013](https://api.census.gov/data/2024/acs/acs5/groups/B19013.html): one estimate and margin of error per ZCTA. The 2024 release is a candidate, not a settled choice.

## Constraints from the proposal
- Store postal codes and ZCTAs as five-character strings, restoring leading zeros where justified.
- Validate key uniqueness and row counts so joins never multiply license records.
- Keep income estimates with their margins of error, and keep missingness indicators; report exclusions rather than silently dropping rows.
- Income describes the Census area, not an owner's household.
- The pipeline should eventually have equivalent Python, SQL and Excel/Power Query versions; this spike starts with R only.

## Open questions (not decided here)
- Which ACS release to use, relative to the license extract year Aslan selects.
- Income groupings (for example quantiles or fixed bands) and whether areas or license records are weighted.
- The integration contract with Aslan's portion: the shape of the ZIP → ZCTA → income table his license data will join to.
- Whether downloaded raw data is committed or re-downloaded by script. Agent proposal: keep raw downloads out of Git and fetch them by script, since all sources are public.
- Census API key handling. Agent proposal: read it from an environment variable that each person sets locally; never commit it.
