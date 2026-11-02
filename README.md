# Barkonomics: Pet Names and Neighborhood Income
A Data Wrangling project by Shweta Mayur Goradia and Aslan French, exploring whether NYC dog names differ across areas with different household incomes.

- [Project proposal](proposal.md)
- [Shared proposal draft for editing and comments](https://drive.google.com/file/d/19GjlWQL73nJTpPncZw0Kleqdaxkaq-qO/view)
- [Shared Drive folder](https://drive.google.com/drive/folders/1VZERM9oMA1lWPSxyoajURYF7W-Jf0Xr4)

Planning only: no analysis implementation yet. The shared Drive draft is the place for proposal discussion; `proposal.md` is the initial Git-tracked snapshot. Changes are not automatically synchronized between them.

## Get started
Copy and paste the prompt below into your agent’s chat. It will get your local checkout ready and guide you through any choices or steps that need your involvement.

<h3><img src="assets/agent-hands-head-thumbs-up.png" height="32" alt="Robot head giving a thumbs-up"> Set up your checkout</h3>
Give this prompt to your agent:

```text
Help me get Barkonomics (https://github.com/Barkonomics-DataWrangling/barkonomics-pet-names) ready to work in. Locate our existing local checkout or prepare one if needed. Read README, AGENTS and .gitmodules, inspect the Git state, and restore this checkout's exact recorded Project Workflows submodule if needed. Preserve active or dirty checkouts and other contributors' changes. Then read project-workflows/setup-project-workflows/SKILL.md and follow its "Onboard a collaborator" route. Handle the local setup for me and guide me through any choices or manual steps you need. Use direct file-based skills first; keep global client discovery optional. Follow the current integration authorization and test gates, and finish by showing me how to start a contribution.
```

<h3><img src="assets/agent-hands-head-thumbs-up.png" height="32" alt="Robot head giving a thumbs-up"> Start contribution work</h3>
Once setup is ready, copy and paste this prompt into your agent’s chat:

```text
Read project-workflows/coordinate-project-contribution/SKILL.md, AGENTS and TODO. Ask me to describe what I want to contribute, then use my answer and the project context to help me get started. Follow the humans' existing direction and ask only for any additional information you need. First reconcile my contribution with existing issues and prepare any needed issue creation or update within the approved scope. Once the relevant issue exists and implementation is authorized, select an appropriate existing contribution branch or create one before creating your own spike or starting local implementation. Link your spike and commits to the issue. Prepare or update a draft pull request so collaborators can discuss the work and review its changes, dependencies and integration plan before an authorized merge. Preserve original atomic commits and unrelated changes; a branch may host several spikes or issues. Follow the current integration authorization and prepare reviewable work within the authorized scope.
```

## GitHub integration preparation
The [integration spike](docs/active-spikes/github-workflow-integration.md) and [end-to-end test plan](docs/active-spikes/github-workflow-integration.todo.md#prepared-end-to-end-test-plan) prepare the issue/PR templates and optional lifecycle automation against the existing public [Project Management Kanban](https://github.com/orgs/Barkonomics-DataWrangling/projects/1). Its selected stages are Backlog, On Deck, Active, Blocked and Done. Issues are the shared tracking/acceptance hub; linked PRs provide discrete discussion/review and authorized integration. Several PRs can serve one issue, with partial work leaving it open.

The setup branch and exact workflow pin are published in [draft setup PR #4](https://github.com/Barkonomics-DataWrangling/barkonomics-pet-names/pull/4); they are not yet integrated into `main`. Aslan and his agent prepare and test the baseline before Shweta is asked to use it. Her contributions then come through issues, branches and PRs for Aslan and his agent to review. Her onboarding and any later review from her are follow-up validation, not prerequisites to baseline readiness.

The owner has authorized publishing the local updates, merging setup PR #4 with its original commits, then configuring/testing the board and runner and enabling automation after it passes. Automatic writes remain disabled during setup and preview; new access grants or credential entry may require an owner step. The complete GitHub-only Agent Hands `d119a91` bundle is locally verified; the [tooling guide](docs/github-tooling.md) explains direct file-based setup and its optional local pointer. Native-settings checks, runner access and hosted tests remain open. Existing cards/owner configuration are preserved. The copied helper runs on GitHub when enabled and has no package dependencies. Proposal discussion stays in the shared Drive draft linked above.

## Manual setup and workflow reference
The agent setup above handles source restoration. This reference is for people or agents inspecting the setup directly.

This project adopts [Project Workflows](project-workflows/README.md) for agent-owned spikes, atomic commits and human-directed contributions. Read [AGENTS.md](AGENTS.md) and [TODO.md](TODO.md) before starting work. The complete collection travels with the repository; local workflow use needs no GitHub credentials, language runtime or global skill registration.

For manual restoration on a checkout containing the adoption:

```sh
git submodule update --init --recursive
```

The published setup is available on `codex/barkonomics-github-integration`, the head branch of draft PR #4. A default clone of `main` does not contain the adoption until that PR is integrated. Fresh recursive retrieval of the published setup branch and exact child pin has been verified. The selected child branch is `project/barkonomics`; the parent records an exact commit independently of that branch setting. Preserve a dirty or active child checkout. Use [Update Project Workflows](project-workflows/update-project-workflows/SKILL.md) for upgrades instead of replacing this project's adaptation with shared main.

Reused workflow files and robot artwork retain their [source and license notice](NOTICE.md).
