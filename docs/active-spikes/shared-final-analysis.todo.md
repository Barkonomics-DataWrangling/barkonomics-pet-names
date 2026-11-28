---
attention: live
reviewed: 2026-11-27
tags: [barkonomics, analysis]
---
# Shared final-analysis tasks
[Issue #12](https://github.com/Barkonomics-DataWrangling/barkonomics-pet-names/issues/12) · [scope and source provenance](shared-final-analysis.md)
## Current checkpoint
Bring together the published dog–baby preparation and the proposed income lookup without changing either contribution branch. Publish a separate draft PR based temporarily on the preparation branch.
## To do
- Review the coverage categories and examples with Aslan before deciding exclusions.
- Reconcile the proposed income interface with Shweta; do not infer her acceptance.
- Agree income groups, comparisons and denominators before analysis implementation.
- Retarget the draft PR to main after preparation dependencies land; verify the review diff and avoid merging the analysis into the preparation branch.
## Done
- Established a separate issue and branch from the published preparation checkpoint.
- Imported only the proposed income-preparation notebook and its two saved inputs, preserving source provenance.
- Added the ZIP left join and coverage examples directly in final-analysis.qmd; all 96,810 dogs and baby-name fields remain. The temporary execution checks unique ZIP keys, preserved rows/fields and reconciled coverage totals. Selected NYC ZIPs: 95,950 ordinary estimates, 379 capped estimates and 18 unavailable estimates; 410 dogs outside the NYC rule and 53 unmatched ZIPs. No exclusions or analysis choices implemented.
