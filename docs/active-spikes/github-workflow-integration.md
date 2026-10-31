---
attention: live
reviewed: 2026-10-31
tags: [barkonomics, collaboration, github]
---
# GitHub workflow integration
Tracked by [issue #3: workflow guidance and sharing](https://github.com/Barkonomics-DataWrangling/pet-names/issues/3).
## Purpose and ownership
Prepare Barkonomics to use the Project Workflows contribution process and optional GitHub starter pack. This spike belongs to the Project Workflows integration agent/thread. Other agents use their own linked spikes. Keep the project's shared research proposal and the humans' collaboration choices intact; this work does not implement the analysis or settle its open methods.

[Agent Hands](https://github.com/jcklpe/agent-hands) owns the GitHub tooling and its separate `docs/active-spikes/github-collaboration-operations.md` pilot. Its parked `docs/scratch/barknomomics-github-integration.md` asks how Barkonomics can consume only selected GitHub capabilities and required helpers without adding the whole collection. [Project Workflows](https://github.com/jcklpe/project-workflows) owns setup/contribution guidance, the installed CI assets and the source `docs/active-spikes/human-agent-contributions.md` workstream. The accepted provider handoff is published tested revision [2275b24863980c75a65d6c90d666d223cf4f50b3](https://github.com/jcklpe/agent-hands/commit/2275b24863980c75a65d6c90d666d223cf4f50b3). The selected GitHub-only bundle and verification boundary are recorded in [GitHub tooling](../github-tooling.md). The Agent Hands owner continues its final command sweep and Projects provisioning implementation separately; this integration owns consuming the released baseline, project lifecycle choices and Barkonomics acceptance.

## Inspected baseline and local preparation
The canonical repository is `Barkonomics-DataWrangling/pet-names`. Inspected `main` at `38cb9e11b6f5cd1439b5cd772138fb0197a68761`: one initial proposal commit, `README.md` and `proposal.md`, with no existing workflow adoption, agent instructions, board policy or `.github` files. The preparation branch is `codex/barkonomics-github-integration`; the initial shared files remain intact.

Adopt shared Project Workflows `4999063a50e93d5a8dc9083718b742392cea8fe0` through `project-workflows/`, with local adaptation branch `project/barkonomics`. Keep its project identity/coordination configuration separate from shared `main`. The child adaptation and local parent setup are checkpointed under `Spike: github-workflow-integration`; the parent records the exact adapted child revision. Both remain unpublished. No complete published adoption or fresh collaborator setup is claimed.

The [starter pack](../../project-workflows/setup-project-workflows/references/github-starter-pack.md) supplies the issue/PR templates and the two-file lifecycle implementation. The prepared consuming paths are `.github/ISSUE_TEMPLATE/contribution.md`, `.github/PULL_REQUEST_TEMPLATE.md`, `.github/workflows/project-lifecycle.yml` and `.github/project-workflows/lifecycle.cjs`. These are copied/adaptable assets, not an Agent Hands service client. Copying these starter files installs no local runtime, package tree, account configuration or service dependency. The optional external agent tooling is separate.

## Authorized phase and live hold
The current scope includes repository inspection, local workflow adoption/configuration, contributor guidance, this spike, prepared GitHub setup and the explicitly authorized local child/parent checkpoints. The user authorized selecting and verifying the released `2275b24` GitHub-only bundle, recording its handoff and checkpointing the local integration/routing. Pushes and live GitHub changes remain explicitly held. Do not push either repository, create/update issues or PRs, provision/change a project, set secrets/variables, or change native automations in this phase. A finished provider pilot supplies evidence; actual board/profile, credential and live-test choices must still be resolved for Barkonomics.

Keep automatic execution disabled: `PW_AUTOMATION_ENABLED` and `PW_NATIVE_SETTINGS_VERIFIED` have not been set; the supplied job skips automatic runs without enablement. Manual dispatch defaults to dry run and still needs configured access and actual IDs. Read-only repository access and the existing issue/PR inventory are verified for the run recorded in the tooling guide. Board state, write permissions and native settings remain unverified. Do not treat the prepared YAML or offline tests as a live result.

## Proposed lifecycle starting point
The [Team Kanban profile](../../project-workflows/setup-project-workflows/assets/templates/lifecycle/team-kanban.md.template) is a candidate to discuss, not an adopted team policy or provisioned board.

| Candidate stage | Starting meaning |
| --- | --- |
| Backlog | Captured work awaiting prioritization. |
| Upcoming | Selected for a future period. |
| On Deck | Ready to start. |
| Active | Work in progress. |
| Blocked | Waiting on an identified condition. |
| Done | The shared outcome meets its acceptance criteria. |

Candidate entry/reopen is Backlog, completed-close is Done, and label-clear return is On Deck. Confirm or replace those choices with the project owners; inspect any existing board before creating another. Cancellation needs its own mapping; the starter leaves other close reasons alone. Choose label blocking, dependency blocking, both or neither. Enabled blockers remain independent; dependency removal alone does not auto-unblock. Closing a GitHub record never closes an agent's spike by itself.

The supplied schedule is fifteen minutes and its fresh-close interval starts at 600 seconds. Preserve existing project settings if discovery establishes them. Board-driven reopening is optional and defaults off; select it only with the expected lag and failed/canceled-run recovery understood. Keep the serialized `queue: max` setting and its capacity/recovery limits. Generic issue edits and unrelated labels must not reset progress.

## Setup handoff and remaining integration
1. Use the accepted `2275b24` baseline and complete file selection in [GitHub tooling](../github-tooling.md). An isolated external bundle verifies issue/PR runtime closure and the existing Projects reader/mover; optional linker preview is checked separately. Fresh client discovery, another person’s account and real contribution/reviewer checks remain acceptance work. Do not substitute the provider owner’s in-progress Projects checkout or introduce a second implementation here.
2. Confirm the exact repository/project scope, actual status field/options, profile, blocked-signal choices and transition ownership. The starter acts on this repository's issues in one selected project; it does not provision fields/views or synchronize PR cards. Preserve existing project configuration and unrelated workflows.
3. Guide the selected runner App/token and nonsecret variable setup from the starter reference. Runner credentials are separate from an agent's GitHub login. Keep all real secret material out of the repository and chat. Agent access follows the provider's actual setup support.
4. Have a human inspect the selected project's Workflows settings following [GitHub's native workflow procedure](https://docs.github.com/en/issues/planning-and-tracking-with-projects/automating-your-project/using-the-built-in-automations). Record the real close-triggering option, conditions, saved/enabled state, checker and date. Retain one writer per transition and preserve unrelated PR behavior; an enabled flag alone is insufficient proof.
5. Review/checkpoint the local files and child adaptation, then publish only within the live hold's resolved scope and with the required child revision available before the parent pin. Keep automation disabled while doing the first hosted preview. Enable only after the selected setup is understood and any actual authorization gaps are resolved.

## First-use acceptance
The first hosted `dry_run=true` run checks credential access, project/field identity and reconciliation proposals; it does not simulate every issue event. Then use bounded, explicitly selected test issues to check entry, completed close, explicit reopen, preserved progress on unrelated edits, independent blocker behavior and actual queue execution/readback. Inspect issue and board state rather than relying only on a successful job. If board-driven reopening is selected, check the fresh-close hold and the later reopen plus resulting card destination across both runs.

Preview the issue and PR templates. Have another person follow the README onboarding path and perform a small real contribution, using separate agent-owned spikes and atomic targeted commits on the team's chosen branch arrangement. Use observed failures and relevant Kaizen feedback for later changes. No formal negotiation process, one-issue/one-branch rule or new service framework is required.

## Contribution visibility
Barkonomics contributions first reconcile/create/update an issue within the approved scope. Once that issue exists and development is authorized, select or create the contribution branch before creating agent-owned spikes or starting implementation. Reusing a shared branch is supported; no branch or issue is required for each internal spike. Link the work to a draft or existing pull request early enough for collaborators to discuss scope and dependencies and review the integration before a merge. The README prompt asks the human what they want to contribute and then follows this project-owned route. Publication and external record changes remain explicitly held; repository branch-protection enforcement has not been configured.

## Existing issue reconciliation and board backfill
Read-only issue inventory on October 31, 2026 found three open shared outcomes. Reuse these records; no replacement issues, new implementation branches or data-work spikes were created during this integration preparation. This spike and `codex/barkonomics-github-integration` belong to #3. The local setup commits do not complete its publication/sharing requirements.

| Existing issue | Responsibility recorded in the issue | Development context | Proposed fallback stage if no valid mapping exists |
| --- | --- | --- | --- |
| [#1: dog and baby-name data in R](https://github.com/Barkonomics-DataWrangling/pet-names/issues/1) | Aslan's data portion. | Select/reuse a branch after the work is picked up; create its agent-owned spikes in that branch context. | Backlog, pending the owner's current progress and selected profile. |
| [#2: income and ZIP–ZCTA data in R](https://github.com/Barkonomics-DataWrangling/pet-names/issues/2) | Shweta's data portion. | Preserve her existing work/branches; select actual development context before any agent spike. | Backlog, pending the owner's current progress and selected profile. |
| [#3: workflow guidance and sharing](https://github.com/Barkonomics-DataWrangling/pet-names/issues/3) | Workflow setup, publication/readiness and sharing the setup/tooling link. | Existing `codex/barkonomics-github-integration` and this spike. | Active, because preparation is underway; completion/sharing remain outstanding. |

These are proposed fallback mappings, not observed board statuses or instructions to reset progress. The actual Project URL/ID, field/option IDs, existing cards and project-owned lifecycle remain unselected/unverified. Preserve valid existing card/status choices and reconcile contradictory progress with the people involved. Do not infer assignees, labels, dates or a person's progress from this table.

After the live hold is resolved: inspect complete current item coverage on the selected board; match existing cards by repository/issue identity; reuse each existing card or add the existing issue once; choose the actual approved stage using current owner evidence; and read back issue/card identity and resulting status. Use a supported provider operation or a human setup step for adding items. The currently documented Projects move-card tool does not establish add-item or board-provisioning support. Enabling the starter does not backfill old issues, and closing/reopening issues to fake new-item events is not the backfill method.

Keep #3 open until the setup is published/retrievable and its sharing/readiness work is actually completed. Later shared updates should link the published branch/PR and this tracked spike; no issue edit, comment, board change, notification or publication was performed by this local reconciliation.
