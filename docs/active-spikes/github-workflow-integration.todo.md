---
attention: live
reviewed: 2026-11-01
tags: [barkonomics, collaboration, github]
---
# GitHub workflow integration tasks
## Background
Continue the existing integration under [issue #3](https://github.com/Barkonomics-DataWrangling/barkonomics-pet-names/issues/3). [Concept and current setup](github-workflow-integration.md) · [selected tooling](../github-tooling.md). Each agent owns its own spike; provider implementation is delivered. This phase upgrades local tooling, reconciles setup and prepares acceptance while the user's push/live-GitHub hold remains in force.

## Current state
Shared issue-centered Project Workflows `d7bcf68` is integrated through `project/barkonomics`; copied issue/PR templates and their actual baselines were reconciled in phase 2. Agent Hands `d119a914acb0826a0b3e320d811369e59b077d55` is installed as a standalone 54-file, 369,578-byte GitHub-only selection. All source hashes, local dependency/entrypoint checks, 62 shared runtime tests, 45 Projects tests, legacy export/render checks and 24 lifecycle tests pass. The old bundle, credentials, global links and unrelated work are preserved.

Read-only native inspection using this bundle verifies the canonical repository, open issues #1–#3, zero open PRs, and the existing public/open Project Management Kanban with 13 fields, five Status options, two views/visible-field orders, six native enabled flags and zero items. Actual lifecycle IDs are generated locally with both enablement flags false and zero writes. The plan is locally ready; publication, fresh collaborator access, repository/native-condition choices, runner access, hosted transitions and issue backfill remain unverified/unexecuted. No fixture, issue, card, PR, workflow dispatch, setting or credential was created/changed in this phase.

## To Do
- Keep all pushes and live GitHub changes held until the user selects their actual execution scope. Complete the gates below with fresh relevant previews and readback, preserving existing action-specific approval; a passing local test or provider closeout does not lift the hold.
- Publish required source/adaptation history before containing pins and prepare the visible setup PR under #3, retaining all original commits. Verify fresh retrieval and another person's installation/access.
- Resolve native writers, partial-PR link/auto-close behavior, view filters, blocker signals and runner permissions against actual saved settings before enabling or dispatching automation.
- Run the approved hosted preview and bounded fixture-first lifecycle/contribution test. Add original issues #1–#3 only after accepted fixture results and fresh owner progress evidence.
- Verify the actual private meeting-to-issue-to-branch-to-spike-to-PR/review/merge path and the intended setup/tooling sharing. Keep #3 open until its real acceptance is met.

## Ready for Human QA
- Select the proposed link strategy: formal linked PRs with repository auto-close disabled and explicit issue acceptance/close, or descriptive-only partial references with visible issue links. No repository setting is changed yet.
- Confirm label/dependency blocker choices and clearing policy, native Done-to-close behavior and the proposed issue-only view changes. Preserve the owner's board/access/default-repository choices; API flags do not establish full saved settings.
- Choose the bounded live-test window/targets, runner credential owner and real collaborator/reviewer. Actual sign-in and meaningful review must come from the person's own account.

## Done
- Phase 3 local pickup: verify/install the selected 54-file release independently of the full Agent Hands repository, preserve the prior installation and account/client choices, run 107 provider and 24 lifecycle tests plus legacy checks, and verify actual read-only commands/disabled lifecycle IDs. Reconcile contributor/tooling guidance, the five-lane existing-board plan, issue-centered partial-PR safeguards and the source selector. Native/hosted/collaborator acceptance remains pending.
- Phase 2 adoption: preserve canonical repository selection, merge the issue-centered workflow/updater baseline, reconcile copied issue/PR assets from the original setup commit and record exact source baselines/pin. Hosted workflow/helper bytes remain unchanged.
- Checkpoint the local parent adoption and child configuration only when commit authority is established; publish no refs while the live hold applies. Commit the child configuration first, then refresh the parent gitlink before its checkpoint. The local checkpoints are authorized; publication and real-collaborator verification remain outstanding. Committed the child configuration first, then recorded its exact revision with the coherent parent setup, refined agent prompts, source/license notices and these records. Pushes and live GitHub changes remain held.

- Inspect the repository boundary, existing instructions, source revision and proposal ownership before changing files. Inspected the clean canonical repository at 38cb9e1; only README/proposal existed. The shared proposal discussion remains separate, and the original proposal and README prefix are preserved byte-for-byte.

- Prepare the pinned Project Workflows adoption from the current published shared revision, with a project branch and target-specific configuration. Prepared shared 4999063 on local project/barkonomics with Barkonomics identity and repository selection. The adapted child was committed before its parent gitlink; the current tooling selection is recorded below. Gitlinks record exact adapted revisions independently of the shared base. Git metadata is outside synced storage.

- Add contributor/agent routing and the integration spike/index, preserving the original proposal and shared-draft links. Added AGENTS, the short TODO index, this paired spike and robot-marked README prompts explicitly addressed to agents. No private meeting/course sources were copied into the project.

- Prepare the contribution issue/PR templates and hosted lifecycle workflow/helper without enabling automation or adding local runtime dependencies. Copied the four selected files exactly from the adopted starter pack. Automatic execution remains gated by unset enablement/verification variables; manual dispatch defaults to preview. No provider runtime, credentials, board or native settings were changed.

- Validate configuration/resources, copied assets, offline helper behavior, live-write gating, private-state ignores and the preserved original proposal. All 24 tests pass against the actual copied helper using a temporary offline test harness. Eight skill frontmatters, 83 local resources/anchors, TOML/YAML, exact source copies, parent/child branches and staged base gitlink passed. Private journal/env/key examples are ignored while shared .github assets stay eligible for versioning. Parent/child whitespace checks pass. No hosted execution, live identity/permissions, native settings, fresh remote adoption or collaborator onboarding result is claimed.


## Prepared live setup sequence
The following is a held test design, not execution permission. When execution is selected, refresh the actual repo/project/refs and use the existing approval-slate process for concrete changed scope. Reuse unchanged action-specific approval; fingerprints and operation IDs are fresh transport guards. Do not create a replacement board, reset owner settings, reserve fixture numbers or infer another person's progress.

1. **Publication/access gate:** inspect complete outgoing source/adaptation/parent ranges and audience; make required child commits retrievable before publishing parent pins. Prepare a visible partial setup PR related to #3 without auto-closing it. Verify a fresh recursive checkout from the actual URLs and selected-tool setup in the collaborator's environment. The provider does not push; publication remains the authorized human's action.
2. **Saved-settings gate:** inspect the repository's auto-close policy and the project's actual native conditions using [GitHub's documented Workflows setup](https://docs.github.com/en/issues/planning-and-tracking-with-projects/automating-your-project/using-the-built-in-automations). Record actor/date, triggers, item types, selected field/option and saved/enabled state. Check linked/merged-PR rules that write issue status, the Done-to-close direction, auto-add/sub-issue behavior and competing entry/close writers. Preserve compatible unrelated behavior. Inspect grouping/sorting, visibility, default repository and collaborator access manually; the supported API reads establish only their documented families.
3. **Profile/view gate:** preserve all five option IDs and visible columns. Proposed Backlog filter: `repo:Barkonomics-DataWrangling/barkonomics-pet-names status:Backlog is:issue`; proposed Full Kanban filter: `is:issue`. Current filters are respectively the same repository/Backlog filter without `is:issue`, and empty. Update only within actual approval. Confirm `blocked` label availability/creation through a supported setup or human step and dependency semantics before selecting both blockers. No PR cards or second lifecycle engine are required.
4. **Runner gate:** choose a GitHub App for this organization project following [GitHub's Actions guide](https://docs.github.com/en/issues/planning-and-tracking-with-projects/automating-your-project/automating-projects-using-actions), or an explicitly approved token alternative. Agent gh login is separate. Proposed minimum App scope is organization Projects read/write and selected-repository Issues read; optional board-driven reopening additionally needs Issues write. Keep checkout contents read. Store the App ID and private key directly in the selected GitHub variable/secret store; never put a key/token into chat, this plan or Git. Unsupported credential/settings operations are human setup steps.
5. **Disabled setup/preview gate:** resolve current IDs using the tracked role map and native `automation-config`; verify the mapping below. Set explicit repository enablement/native-verification flags false before publishing the runner, accounting for inherited values. After separate dispatch authorization, run only `dry_run=true`. Inspect real Actions logs, schema/access/coverage and all proposals; no issue/card mutation is expected. This dispatch covers reconciliation, not synthetic opened/close/label events.
6. **Bounded live gate:** after saved settings, profile, dry run and exact fixture actions are accepted, attest native verification and enable only the reviewed test window. Use the two fixtures below before real-issue backfill. Preserve the 600-second guard, fifteen-minute cadence, serialized `queue: max` and no cancel-in-progress. Inspect each actual event/run; a full queue, canceled/missing/failed run or uncertain readback stops acceptance.
7. **Acceptance/backfill gate:** independently read fixture issue/card/PR states, preserve evidence and pause before original-issue membership changes. Refresh #1–#3 and their owners' actual progress, reuse/add each exact issue once and set only its approved stage. #3 remains open through usable sharing and collaborator readiness. Production enablement and final issue/spike closure require their own actual scope.

### Prepared runner variable mapping
Read-only `automation-config` verified these values on November 1. They are nonsecret prepared inputs, not applied GitHub settings. The role map is `.github/project-workflows/lifecycle-stages.json`; the ID-producing command belongs to the selected Projects skill. Refresh before execution because field/option changes invalidate old plans.

| Variable | Verified/prepared value |
| --- | --- |
| `PW_AUTOMATION_ENABLED` | `false` |
| `PW_BLOCKED_OPTION_ID` | `6e6e1d32` |
| `PW_DONE_OPTION_ID` | `98236657` |
| `PW_ENTRY_OPTION_ID` | `f75ad846` |
| `PW_NATIVE_SETTINGS_VERIFIED` | `false` |
| `PW_PROJECT_ID` | `PVT_kwDOFGWeWs4Bpt03` |
| `PW_READY_OPTION_ID` | `ed88f37c` |
| `PW_REOPEN_OPTION_ID` | `f75ad846` |
| `PW_STATUS_FIELD_ID` | `PVTSSF_lADOFGWeWs4Bpt03zhoIIn8` |
| `PW_STATUS_FIELD_NAME` | `Status` |
| `PW_TERMINAL_OPTION_IDS` | Empty additional-terminal list initially; Done is already terminal. |
| `PW_BLOCKED_LABEL` / `PW_DEPENDENCY_BLOCKING` | Proposed `blocked` / `true`, pending selected signal/setup verification. |
| `PW_REOPEN_CLOSED_ISSUES` | `false` initially. |
| `PW_FRESH_CLOSE_SECONDS` / `PW_MAX_CHANGES` | `600` / `5` for the pilot. |
| `PW_AUTH_METHOD` / `PW_APP_CLIENT_ID` | Proposed `app` / the actually selected App's ID; not configured here. |

Secret `PW_APP_PRIVATE_KEY` is entered directly in GitHub settings. If the owner instead selects token authentication, use its documented secret route and scope without credential fallback. Manual preview may mint an App installation token but must still perform zero issue/project mutations. Only after the saved settings are genuinely verified may `PW_NATIVE_SETTINGS_VERIFIED` become true; automatic writes remain disabled until the accepted test window.

<a name="prepared-live-test-matrix"></a>
## Prepared end-to-end test plan
No row below is passed by offline tests or a paper walkthrough. Record exact fixture issue/item/PR IDs, source and head revisions, action/run IDs, before/after state, coverage, actor, actual cadence/queue lag and independent readback. Stop on incomplete evidence or changed targets. Use two clearly identified disposable issues, provisionally `[Workflow test] Lifecycle and partial contribution` and `[Workflow test] Dependency prerequisite`, with final body/labels and notification effects reviewed when execution is selected. Retain their records; no deletion is planned.

| Check | Exercise and required evidence |
| --- | --- |
| Fresh setup | Another person follows the README agent prompt from a fresh checkout, retrieves the exact workflow pin and selected tool folders, verifies runtime/account/source, reads issues and understands the hold. Filesystem availability and the maintainer's successful login do not prove their discovery/access. |
| Hosted dry run | With automatic writes disabled, the explicitly dispatched preview resolves runner access, actual schema and complete relevant data. Inspect proposals/warnings and confirm zero issue/card mutations. |
| Entry/deduplication | Open the two approved fixtures in the selected window. Each gains exactly one issue card in Backlog; repeated reads/reconciliation do not duplicate membership or reset an assigned status. |
| Preserve progress | Explicitly move the lifecycle fixture to Active, edit its body and add/remove an unrelated existing label. It remains Active. Generic edits and unrelated labels must not reapply entry. |
| Label blocker | Add the selected blocking label: Active → Blocked. Remove it with no dependency: Blocked → On Deck. Verify actual issue labels and option IDs. |
| Independent blockers | Add the fixture dependency, reconcile to Blocked and add the label. Removing only the label retains Blocked while the dependency remains. Re-add the label, remove the dependency and verify Blocked remains; remove the final label with no dependency and verify On Deck. Use a supported dependency operation or the human UI; do not invent a provider command. |
| Deliberate dependency clearing | With no blocking label, add then remove the dependency and reconcile. It remains Blocked until explicitly triaged to On Deck under the selected no-auto-unblock policy. |
| Close/reopen/terminal | Close the lifecycle fixture as completed: issue closed/card Done. Explicitly reopen unblocked: issue open/card Backlog; repeat with a blocker only within accepted scope and verify Blocked. A blocked label on closed Done does not reopen it or move it nonterminal. |
| Native close direction | Move the open unblocked fixture to Done and verify the selected native rule closes that exact issue while the starter preserves Done. Inspect actual configured option/conditions before relying on it. |
| Cancellation | Close the prerequisite fixture with not_planned from a known stage. The starter preserves its reason/stage and does not reopen it; record the humans' intended manual classification. |
| Queue and schedule | Observe a real scheduled run and an approved close/reopen event sequence. Check each trigger, queue/result and final issue/card state; missing/replaced/canceled runs need investigation. This bounded check does not prove queue-capacity behavior. |
| Partial PR and blockers | Link/merge the first partial contribution while the fixture's acceptance remains unfinished, then exercise linking with a Blocked fixture in the approved sequence. Issue stays open; native PR rules preserve Blocked/terminal intent. Verify formal-link/auto-close settings and resulting issue/card state; no PR card is required. |
| Shared branch and two agents | Use the concrete contribution path below: one selected branch, two independent agent-owned spikes and targeted commits, preserving all original hashes/docs. Actual PR coverage includes both code/text and discussions/review threads with honest completeness. |
| Human review and integration | A real non-author reviewer assesses the observed PR head. Request changes only for an actual finding; address it and obtain the real verdict. Separately authorize a supported history-preserving merge, then read back head/merge/issue/card state. A tool assessment is not the person's acceptance. |
| Private meeting routing | Use a human-selected meeting action through the existing private transcript/meeting route, reconcile the approved public outcome with existing issues, establish branch context, then agent spikes/work and visible PR review. Keep private transcript/evidence out of shared records. Update private outcome/shared links through their owners after authorized integration. |
| Real-issue backfill and sharing | After fixture acceptance, refresh original #1–#3 and add/reuse each once at its actual approved stage. Share the usable repo/setup/tooling link through an authorized human communication and verify the collaborator can use it. Keep #3 open until that acceptance is met; add no alert subsystem. |

### Shared-branch contribution path
Choose a small real documentation/onboarding outcome under #3 after its issue and implementation scope are settled. Use one appropriate contribution branch for two agents, each with a distinct spike pair and a reviewable targeted commit; independent people use their own checkouts. Select branch context before starting those development spikes. The first agent can record actual fresh-setup evidence and the second actual review/usage evidence; do not fabricate defects, meetings or review verdicts merely to produce a PR.

Make the draft PR visible early through approved publication and relate partial work descriptively to #3. To exercise several PRs for one fixture issue when the original commits are separable, retain a branch ref at the first contribution's original commit, review/integrate that PR, then refresh the shared branch from the integrated target with a normal merge and review the remaining contribution. Preserve original commit hashes, suitable spike docs and all dependencies. If the contributions cannot be separated safely, use one combined review and record that limit; do not squash, cherry-pick/rewrite or manufacture a one-issue/one-branch/one-PR rule. Verify the first partial merge does not close the fixture or umbrella issue prematurely under the selected link policy.

### Optional reopening and recovery
Board-driven reopening is deferred unless separately selected with required runner permission and explicit fixture scope. If selected: close the fixture as completed, move it nonterminal, reconcile inside 600 seconds and verify it stays closed; reconcile after the guard and verify issue reopening, then the separate issues.reopened run's Backlog/Blocked destination. Missing/invalid close time holds reopening. Verify both runs without using real backlog issues for round trips.

On failure, pause the selected automation variable, cancel only identified pilot runs if authorized, inspect in-flight/native transitions and current issue/card state, and retain logs and private recovery records. Pausing does not undo an in-flight or native action. Never blindly retry mutations, erase uncertain journals, lower the guard or sweep-close real issues. Refresh the residual preview and honor its actual authority; rollback/configuration changes are separate concrete actions.

## Earlier checkpoint evidence
The following dated records retain their original observation scope. Current selection and the held acceptance plan are above.

## Onboarding refinement — 2026-10-31
The user requested an agent-led starting path before technical setup instructions. README now begins Get started with a copyable setup prompt that asks the agent to restore the exact recorded submodule and complete collaborator onboarding. Contribution kickoff stays beside it; manual Git and adoption details follow under a reference heading. The prompt identifies the repository and covers obtaining a checkout when needed. The robot image is carried in the parent so the entry headings render before submodule restoration. The original project introduction, proposal links and live GitHub hold are retained.

The contribution prompt can also be pasted unchanged: it asks the agent to invite the human to describe their contribution, then use that answer and the project context to begin. No placeholder replacement is required.

## Local checkpoint verification — 2026-10-31
The parent checkpoint records the exact local Project Workflows adaptation and preserves the initial proposal commit and proposal bytes. Final static checks passed for 85 local resources/anchors, TOML/YAML, the adapted gitlink, private-state ignores and copied-file/license identity; the runtime helper is unchanged from the 24-test passing preparation. The README contribution prompt explicitly asks the human for scope, then follows issue reuse/creation, contribution-branch selection and PR visibility before reviewed integration. Shared branches can still carry many spikes/issues. This is project workflow guidance; repository branch-protection enforcement is not configured by this work. The imported starter files and robot image match the published shared source, with source attribution and the full AGPL-3.0-only text retained. Live access, hosted execution, native settings and real-collaborator QA remain pending.

## Issue reconciliation and context routing — 2026-10-31
The user authorized local existing-issue reconciliation and the LifeOS/project routing, and clarified that approved issue creation/update precedes branch selection, which precedes agent-owned spikes and implementation. Linked this work to existing #3; prepared fallback mappings for #1–#3 with current-board/owner checks still pending. No data-work branch or spike was invented for either person's issue. The repository's optional ignored paths-only context configuration connects a local agent to the private project context; public instructions/example contain no personal paths. Source transcript handling and LifeOS implementation records keep their existing owners. The live GitHub/publication hold is retained.


Local follow-up verification: 86 links/resources across the changed project and private routing owners resolve; the private skill frontmatter parses; the issue → branch → spike order, selected snapshot and ignored paths-only pointer check out. The three-issue/zero-open-PR native refresh succeeded. All 172 pre-existing changed LifeOS paths and the prior vault index were preserved. These are source/routing checks, not hosted or real-collaborator execution. The earlier setup/adaptation checkpoints are intact. The issue/context routing joins the user-authorized local checkpoint described below; pushes and live writes remain held.

## GitHub-only provider handoff — 2026-10-31
Accepted the published Agent Hands `2275b24863980c75a65d6c90d666d223cf4f50b3` handoff at the user's request and removed only its pickup entry from the private coordination index. [GitHub tooling](../github-tooling.md) records the complete selected file set and capability limits. The external installation carries 49 unchanged source files and an exact-hash installation manifest; it has no Git object store, dependency environment or other service. The child configuration selects the same baseline; the parent checkpoint includes its resulting gitlink and issue/context routing.

Offline verification passed with isolated HOME, gh/configuration directories and synthetic gh fixtures: 26 issue collaboration tests, 34 PR collaboration tests and 13 Projects move-guard tests, plus provider/PR/Projects export gates, both renderer suites, provider dependency check, all three help entrypoints and optional linker preview. Selected shell syntax/Python parsing and all 49 source hashes pass; no `.venv`, `node_modules` or bytecode cache exists in the bundle. The linker preview creates no discovery directory or actual links. Existing global installations are preserved. These checks establish the selected local runtime/dependency set, not fresh-client discovery or another collaborator's account.

Read-only verification at 22:16:35 UTC used that exact bundle and the existing `jcklpe` account: exact issue #3 read succeeded with complete returned comment coverage, and issue/PR exports confirmed issues #1–#3 open and zero open PRs. No login, scope change, alias creation, project recovery journal or GitHub mutation occurred. These temporary validation exports do not replace the earlier private source snapshots or establish board state/write permission.

The provider owner continues its final command sweep and new Projects provisioning/schema/view work. This integration owns consuming the released tooling, project profile/lifecycle selection, existing-issue backfill, hosted starter-pack tests, fresh-client/collaborator/reviewer checks and meeting-to-contribution acceptance. Projects provisioning, human native-automation verification, runner access and a real PR/merge remain pending. Source publication and live GitHub writes stay explicitly held.

## Read-only board discovery and plan preparation — 2026-10-31
Completed the user-requested inspection and local plan while retaining the hold until the provider owner finishes. Complete organization/repository/issue connections at 22:34:21–22:36:51 UTC found no accessible board or existing item memberships. Inspected Actions permission/workflow/variable/secret metadata and labels without reading secret values. The [concept](github-workflow-integration.md#board-inspection--2026-10-31) records the exact scope, observed baseline and proposed profile. Existing source, provider selection and parent/child commits are unchanged. This planning follow-up is local and uncommitted; no new commit authority, push or live mutation is inferred.


## Provider completion handoff — 2026-11-01
Historical transfer record; current selected-source verification and execution gates are above.
Agent Hands [PR #5](https://github.com/jcklpe/agent-hands/pull/5) is merged at `d119a914acb0826a0b3e320d811369e59b077d55` and its issue #1 is verified closed as completed. The [current handoff addition](github-workflow-integration.md#agent-hands-provider-closeout-handoff--2026-11-01) records the complete source selection, issue-centered model, existing five-lane public board, preserved owner choices and remaining acceptance. Follow shared Project Workflows changes first, then downstream `update-project-workflows`, including copied parent assets. Existing receiving checklists remain open; no hosted/collaborator pass, installation, pin, copied asset, board change or new consumer write approval is claimed by this handoff. Issue #3 retains publication/sharing acceptance.

## Repository alignment preflight — 2026-11-01
Picked up the user’s reported local/remote mismatch before the shared-first implementation. Read-only checks verified the actual checkout’s origin is `https://github.com/Barkonomics-DataWrangling/barkonomics-pet-names.git`; GitHub repository identity is `R_kgDOVIVIaQ`, public, with default main at `38cb9e1`. Live remote main, local main and origin/main match. The local `codex/barkonomics-github-integration` branch descends from main with exactly the two original setup commits, `e17f146` and `10bb104`. It has not been published and has no matching remote branch; this is not unrelated or severed history.

The complete Project Workflows submodule exists on `project/barkonomics` at `1ddab30`. Its HEAD, parent index gitlink and committed parent pin agree; Git metadata resolves correctly. Its origin remains `jcklpe/project-workflows`, but its Barkonomics adaptation branch is unpublished. Parent and child integrity checks exit successfully; existing dirty planning, private context discovery and ignored provider recovery state are retained. No reset, checkout replacement, history rewrite, directory move, remote rename or publication was needed or performed for these checks.

The online default branch lacks the prepared workflow folder because the adoption is still held locally. The user’s proposed `barkonomics-pet-names` repository name is a separate naming choice, not a connectivity repair. If selected for execution, update the real remote identity, local paths and dependent references as one bounded rename; do not assume that naming approval publishes setup commits or enables automation. Otherwise proceed to shared Project Workflows implementation, then downstream adoption through Update Project Workflows, with child-before-parent publication and a visible setup PR under its concrete scope. Keep real issue/card/runner work for the later live phase.

## Canonical repository move — 2026-11-01
Executed the user's explicit carry-over request by renaming the existing GitHub repository to `Barkonomics-DataWrangling/barkonomics-pet-names` and moving the intact checkout to the matching local folder. Independent reads retained repository ID `R_kgDOVIVIaQ`, default main at `38cb9e1`, all three original issue IDs/titles/states and the empty PR inventory. Git refs, parent HEAD `10bb104`, child HEAD/pin `1ddab30`, branch selection, indexes and the complete preexisting dirty state were preserved. Every one of the 159 pre-move file entries matched after the move except the intentional parent Git origin URL update; parent/child integrity checks passed.

Updated maintained local references and private context links for the canonical location. Historical observations and private operation journals are retained. Saved board repository filters are checked separately against the new name; only a required old-name substitution belongs to this rename scope. Existing mutation previews must be refreshed against the renamed target before future execution. No setup commit, workflow adaptation, native-setting change, fixture, issue addition or automation enablement was published or performed by this move. The remaining shared-first phases continue from the carried-over work.

## Rename readback and remaining filter — 2026-11-01
Independent read-only verification confirms the same public Project Management Kanban board is linked to `Barkonomics-DataWrangling/barkonomics-pet-names`, with all 13 fields, two views, six native workflow flags and zero items preserved. The saved Backlog view filter still contains the former repository name. Automatic approval review blocked the conditional filter mutation as a separate shared setting outside the repository-rename approval; no board mutation was sent. The exact old-name substitution remains pending explicit approval. Other lifecycle/view decisions retain their existing separate scope.

The selected private native issue/PR refresh succeeded against the renamed repository, retaining the existing mapped output directory and confirming three open issues and zero open PRs. Secret values, private operation journals and the selected tool installation were unchanged. Setup history remains on the unpublished contribution branch, and no commits, issue/card changes or runner enablement were published.

## Backlog filter verification — 2026-11-01
The approved G60 update changed the saved Backlog filter to `repo:Barkonomics-DataWrangling/barkonomics-pet-names status:Backlog`. Independent readback verified that exact filter and preserved the other view, all 13 fields, six native workflow flags and zero items. No automation setting, issue/card membership, setup publication or push changed. Shared Project Workflows phase 1 proceeds separately; downstream adoption and live lifecycle testing retain their own scope.

## Earlier adoption capture consolidated — 2026-11-02
The user authorized folding the earlier Agent Hands scratch capture into this existing integration scope and removing the redundant source. Its useful requirement is already owned here and in [GitHub tooling](../github-tooling.md): select the GitHub capabilities with their complete setup/runtime dependencies, without adding the entire Agent Hands repository. No new spike, provider feature or implementation task is created.

The [November 1 provider handoff](github-workflow-integration.md#agent-hands-provider-closeout-handoff--2026-11-01) supersedes the old wait-for-provider-testing condition. It does not complete the consumer source upgrade, shared-first/downstream workflow adoption, hosted tests, publication or fresh-client/collaborator acceptance. Those existing checks remain open and must be reconciled by the integration owner; this cleanup performs none of them.

The untracked original is preserved verbatim below before removing its redundant copy. Historical source: Agent Hands `docs/scratch/barknomomics-github-integration.md` (original spelling). Exact UTF-8 SHA-256: `ced8f3fc91a2153f37abe0638fdf7dd98d6d68591d1929bbf9e724d47ab99a83`. Its parked status and “not started” statement describe the capture at that time, not the current integration state. The original relative pilot link is retained as source text, not a link to execute from this repository.

````markdown
---
status: parked
---
# GitHub-only integration for Barknomomics
After the current GitHub collaboration testing is complete, assess how Barknomomics can adopt the GitHub-specific Agent Hands capabilities it needs, including their required setup/runtime dependencies, without bringing in the entire Agent Hands repository.

Revisit after the [GitHub collaboration pilot](../active-spikes/github-collaboration-operations.md). Capture only for now; consumer discovery and integration have not started.
````
