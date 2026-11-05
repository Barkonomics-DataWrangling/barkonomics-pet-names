---
attention: live
tags: [barkonomics, data, income, zcta, r]
---
# Income and ZIP–ZCTA data tasks
## Background
Work for [issue #2](https://github.com/Barkonomics-DataWrangling/barkonomics-pet-names/issues/2) on branch `shweta/income-zcta-data`, created from `main` at `992bc8b`. [Concept, sources and open questions](income-zcta-data.md).

## Current state
Branch and spike pair created. No R code or data yet. Local R 4.6.1 has tidyverse, readxl and jsonlite; httr2 and tidycensus are not installed. The selected GitHub tools are not set up in this checkout, so pushes, PRs and issue comments go to Shweta as exact handoff steps.

## To Do
- Decide with Shweta where raw downloads and cleaned outputs live, and add ignore rules if raw data stays out of Git.
- Write an R script that downloads the HRSA crosswalk, keeps New York ZIPs, stores ZIP and ZCTA as five-character strings and checks that ZIP keys are unique.
- Write an R script that gets ACS B19013 estimate and margin of error for the relevant ZCTAs, once the release and API-key handling are settled.
- Join crosswalk to income and report ZCTAs with missing or suppressed income estimates.
- Draft the integration table shape for Aslan's review (columns, keys, one row per ZIP or per ZCTA).
- Bring progress and questions to the November 5 review.
- Prepare a draft PR so Aslan can see scope and the integration plan.

## Ready for Human QA

## Done
