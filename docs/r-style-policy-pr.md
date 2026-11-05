# R style policy contribution
This contribution contains the READABLE-R proposal, its policy index entry and this review plan. The dog/name scripts, datasets and issue #1 handoff belong to their own contribution. The policy remains proposed until an explicit adoption decision; committing or merging the proposal alone does not adopt it.

## Issue preparation
Proposed title: Establish readable R conventions for Barkonomics agents

Define inspectable R style conventions for agent-authored analysis and validation code. Review suite loading, sequential transformations, rightward assignment, descriptive naming and explainability as distinct rules under the common purpose of readable R. Straightforward loops and base R remain allowed.

Acceptance: review the exact policy text; record the adoption decision or requested revisions; verify policy metadata, dependencies, links and index consistency; review and integrate this policy contribution separately from the dog/name implementation. This is a separate outcome from issue #1. Reconcile existing GitHub issues before creating one; no issue number or shared acceptance is claimed here.

## PR preparation
Proposed title: Propose readable, explainable R conventions

Add the READABLE-R agent-policy proposal with separate sections for package loading, transformation order, assignment direction, naming and explainability. The ID retains its readability purpose; the title and filename describe the entire obligation. No existing policy depends on this candidate, and it adds no prerequisites. The existing nine adopted policies remain operative.

Validation: the policy checker passes for the ten-record set, including local links and the generated index. Semantic review found no conflicting owner or obligation in the adopted set. This PR changes documentation only.

Link the reconciled policy issue when preparing the live PR. Do not close it while adoption or other acceptance remains unresolved.

## Publication boundary
Keep the policy in its own atomic commit. Before publishing, create a policy-only PR branch pointing to that commit after reconciling its issue. Its diff against the target must contain only the policy, index and this plan. Preserve the original commit when integrating. Integrate the policy PR first, then verify the dog/name PR against the updated target so it does not reintroduce policy changes. No history rewrite or cherry-pick is needed for this ordering. Publishing, adoption and integration remain separate actions; no remote issue or PR has been created by this plan.
