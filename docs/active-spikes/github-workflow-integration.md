---
attention: live
reviewed: 2026-10-31
tags: [barkonomics, collaboration, github]
---
# GitHub workflow integration
## Purpose and ownership
Prepare Barkonomics to use the Project Workflows contribution process and optional GitHub starter pack. This spike belongs to the Project Workflows integration agent/thread. Other agents use their own linked spikes. Keep the project's shared research proposal and the humans' collaboration choices intact; this work does not implement the analysis or settle its open methods.

[Agent Hands](https://github.com/jcklpe/agent-hands) owns the GitHub tooling and its separate `docs/active-spikes/github-collaboration-operations.md` pilot. Its parked `docs/scratch/barknomomics-github-integration.md` asks how Barkonomics can consume only selected GitHub capabilities and required helpers without adding the whole collection. [Project Workflows](https://github.com/jcklpe/project-workflows) owns setup/contribution guidance, the installed CI assets and the source `docs/active-spikes/human-agent-contributions.md` workstream. These owner references identify the records; the tested Agent Hands handoff revision is still pending.

## Inspected baseline and local preparation
The canonical repository is `Barkonomics-DataWrangling/pet-names`. Inspected `main` at `38cb9e11b6f5cd1439b5cd772138fb0197a68761`: one initial proposal commit, `README.md` and `proposal.md`, with no existing workflow adoption, agent instructions, board policy or `.github` files. The preparation branch is `codex/barkonomics-github-integration`; the initial shared files remain intact.

Adopt shared Project Workflows `4999063a50e93d5a8dc9083718b742392cea8fe0` through `project-workflows/`, with local adaptation branch `project/barkonomics`. Keep its project identity/coordination configuration separate from shared `main`. The child adaptation and local parent setup are checkpointed under `Spike: github-workflow-integration`; the parent records the exact adapted child revision. Both remain unpublished. No complete published adoption or fresh collaborator setup is claimed.

The [starter pack](../../project-workflows/setup-project-workflows/references/github-starter-pack.md) supplies the issue/PR templates and the two-file lifecycle implementation. The prepared consuming paths are `.github/ISSUE_TEMPLATE/contribution.md`, `.github/PULL_REQUEST_TEMPLATE.md`, `.github/workflows/project-lifecycle.yml` and `.github/project-workflows/lifecycle.cjs`. These are copied/adaptable assets, not an Agent Hands service client. No local runtime, package tree, account configuration or service dependency is installed by this preparation.

## Authorized phase and live hold
The current scope includes repository inspection, local workflow adoption/configuration, contributor guidance, this spike, prepared GitHub setup and the explicitly authorized local child/parent checkpoints. Live GitHub changes are held until the Agent Hands collaboration owner finishes testing. Do not push either repository, create/update issues or PRs, provision/change a project, set secrets/variables, or change native automations in this phase. A finished provider pilot supplies evidence; actual board/profile, credential and live-test choices must still be resolved for Barkonomics.

Keep automatic execution disabled: `PW_AUTOMATION_ENABLED` and `PW_NATIVE_SETTINGS_VERIFIED` have not been set; the supplied job skips automatic runs without enablement. Manual dispatch defaults to dry run and still needs configured access and actual IDs. No current GitHub state, permissions or native settings have been verified. Do not treat the prepared YAML or offline tests as a live result.

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

## Setup handoff after provider testing
1. Obtain the Agent Hands owner's tested source revision, capability list, live/offline coverage and remaining limits. Select only the GitHub domains actually needed, plus `setup-github` and required shared files. Reuse an external supported installation where appropriate. Selective client linking alone does not prove a copied bundle is self-contained: its link entrypoint also uses the shared `setup-agent-hands` linker. Do not copy incomplete skill folders or introduce a second implementation here.
2. Confirm the exact repository/project scope, actual status field/options, profile, blocked-signal choices and transition ownership. The starter acts on this repository's issues in one selected project; it does not provision fields/views or synchronize PR cards. Preserve existing project configuration and unrelated workflows.
3. Guide the selected runner App/token and nonsecret variable setup from the starter reference. Runner credentials are separate from an agent's GitHub login. Keep all real secret material out of the repository and chat. Agent access follows the provider's actual setup support.
4. Have a human inspect the selected project's Workflows settings following [GitHub's native workflow procedure](https://docs.github.com/en/issues/planning-and-tracking-with-projects/automating-your-project/using-the-built-in-automations). Record the real close-triggering option, conditions, saved/enabled state, checker and date. Retain one writer per transition and preserve unrelated PR behavior; an enabled flag alone is insufficient proof.
5. Review/checkpoint the local files and child adaptation, then publish only within the live hold's resolved scope and with the required child revision available before the parent pin. Keep automation disabled while doing the first hosted preview. Enable only after the selected setup is understood and any actual authorization gaps are resolved.

## First-use acceptance
The first hosted `dry_run=true` run checks credential access, project/field identity and reconciliation proposals; it does not simulate every issue event. Then use bounded, explicitly selected test issues to check entry, completed close, explicit reopen, preserved progress on unrelated edits, independent blocker behavior and actual queue execution/readback. Inspect issue and board state rather than relying only on a successful job. If board-driven reopening is selected, check the fresh-close hold and the later reopen plus resulting card destination across both runs.

Preview the issue and PR templates. Have another person follow the README onboarding path and perform a small real contribution, using separate agent-owned spikes and atomic targeted commits on the team's chosen branch arrangement. Use observed failures and relevant Kaizen feedback for later changes. No formal negotiation process, one-issue/one-branch rule or new service framework is required.

## Contribution visibility
Barkonomics contributions reuse or prepare an issue for the shared outcome and use an appropriate contribution branch. Reusing a shared branch is supported; no branch or issue is required for each internal spike. Link the work to a draft or existing pull request early enough for collaborators to discuss scope and dependencies and review the integration before a merge. The README prompt asks the human what they want to contribute and then follows this project-owned route. Publication and external record changes stay held during provider testing; repository branch-protection enforcement has not been configured.
