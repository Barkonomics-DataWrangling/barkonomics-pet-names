---
attention: live
reviewed: 2026-11-27
tags: [barkonomics, analysis, reconciliation]
---
# Connect preparation and develop the shared analysis
[Issue #12](https://github.com/Barkonomics-DataWrangling/barkonomics-pet-names/issues/12) owns this shared outcome. This branch begins at Aslan’s preparation checkpoint `765ebe6` from PR #11. Its draft PR targets `aslan/dog-baby-name-data` temporarily to isolate the additional work; do not merge it into that preparation branch. Retarget to main after the preparation dependency is integrated, then inspect the diff again.

Continues from: docs/active-spikes/dog-baby-name-data.md

## Inputs and provenance
Aslan’s `dogs_with_baby_name_measures` has one row per estimated dog and preserves the selected source license, ZIP and baby-name measures. `dog-baby-matching.qmd` owns its preparation.

The proposed `zip_income` interface has one row per postal ZIP with the mapped ZCTA, borough classification, income, margin of error, status and relative-uncertainty fields. Its `income-areas.qmd` is copied byte for byte from suggestion commit [9805346](https://github.com/Barkonomics-DataWrangling/barkonomics-pet-names/commit/9805346ef59149711251018944a8e9d8adca6561), authored by Aslan, based on Shweta’s income preparation in [64cd25c](https://github.com/Barkonomics-DataWrangling/barkonomics-pet-names/commit/64cd25c37d058a144a34fe23166bccfc995947f8). The two saved source files are copied byte for byte from [b13c1d7](https://github.com/Barkonomics-DataWrangling/barkonomics-pet-names/commit/b13c1d7a8d8f24209f109bc12ddfb5bfc3451dfd). Original commits and both contribution branches remain intact. This scoped import does not bring in Shweta’s final report, old analysis consumers, slide documents or older workflow configuration.

This is a proposed integration, not a statement that Shweta accepted the income suggestions. Her PR #9 remains the record of her submitted contribution; issue #2 owns that preparation.

## Initial boundary
The final report includes dog–baby matching once and income preparation once, then joins the two by recorded ZIP. All intermediate tables stay in memory. The join retains every dog, keeps ZIP unchanged and reports coverage before exclusions. No income grouping, geographic exclusion, statistical comparison or interpretation is selected by this checkpoint.

## Open decisions
Review unmatched ZIPs, outside-NYC classifications, absent Census rows, explicitly unavailable estimates and capped estimates separately. Agree the comparison population before calculating denominators. Income groups, summary measures and later charts remain for discussion. The initial research question concerns the association between neighborhood income and historical baby-name use; current sources cannot establish the proposed socioeconomic diffusion sequence.

The income notebook retains its open decision about the source and wording of the relative-uncertainty categories. That does not affect the coverage counts or cause filtering.
