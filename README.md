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
Help me get Barkonomics (https://github.com/Barkonomics-DataWrangling/pet-names) ready to work in. Locate our existing local checkout or prepare one if needed. Read README, AGENTS and .gitmodules, inspect the Git state, and restore this checkout's exact recorded Project Workflows submodule if needed. Preserve active or dirty checkouts and other contributors' changes. Then read project-workflows/setup-project-workflows/SKILL.md and follow its "Onboard a collaborator" route. Handle the local setup for me and guide me through any choices or manual steps you need. Use direct file-based skills first; keep global client discovery optional. Follow the current GitHub integration hold, and finish by showing me how to start a contribution.
```

<h3><img src="assets/agent-hands-head-thumbs-up.png" height="32" alt="Robot head giving a thumbs-up"> Start contribution work</h3>
Once setup is ready, copy and paste this prompt into your agent’s chat:

```text
Read project-workflows/coordinate-project-contribution/SKILL.md, AGENTS and TODO. Ask me to describe what I want to contribute, then use my answer and the project context to help me get started. Follow the humans' existing direction and ask only for any additional information you need. First reconcile my contribution with existing issues and prepare any needed issue creation or update within the approved scope. Once the relevant issue exists and implementation is authorized, select an appropriate existing contribution branch or create one before creating your own spike or starting local implementation. Link your spike and commits to the issue. Prepare or update a draft pull request so collaborators can discuss the work and review its changes, dependencies and integration plan before an authorized merge. Preserve original atomic commits and unrelated changes; a branch may host several spikes or issues. Follow the current GitHub integration hold and prepare reviewable work within the authorized scope.
```

## GitHub integration preparation
The [integration spike](docs/active-spikes/github-workflow-integration.md) and [task record](docs/active-spikes/github-workflow-integration.todo.md) describe the prepared issue/PR templates, proposed lifecycle and optional Actions automation. Pushes and live GitHub changes remain on hold. The tested Agent Hands baseline is selected; local verification does not lift the hold. The board, credential setup and native automation checks remain pending; the workflow is disabled until explicitly configured. The Team Kanban stages are a proposal for discussion.

The [GitHub-only tooling guide](docs/github-tooling.md) selects Agent Hands `2275b24`, its complete provider/runtime dependencies and optional linker support. Keep that small bundle in an external local tool location; it is separate from this repository and the Project Workflows submodule. Direct file-based invocation works without global client registration. The copied lifecycle helper executes on GitHub when enabled and has no package dependencies. Existing proposal links and discussion ownership above remain authoritative.

## Manual setup and workflow reference
The agent setup above handles source restoration. This reference is for people or agents inspecting the setup directly.

This project adopts [Project Workflows](project-workflows/README.md) for agent-owned spikes, atomic commits and human-directed contributions. Read [AGENTS.md](AGENTS.md) and [TODO.md](TODO.md) before starting work. The complete collection travels with the repository; local workflow use needs no GitHub credentials, language runtime or global skill registration.

For manual restoration after the adoption is published:

```sh
git submodule update --init --recursive
```

The workflow adaptation and project setup are committed locally but unpublished, so a fresh remote clone does not contain this setup yet. Publish the child adaptation before the parent pin when the live hold is resolved. The selected child branch is `project/barkonomics`; the parent records an exact commit independently of that branch setting. Preserve a dirty or active child checkout. Use [Update Project Workflows](project-workflows/update-project-workflows/SKILL.md) for upgrades instead of replacing this project's adaptation with shared main.

Reused workflow files and robot artwork retain their [source and license notice](NOTICE.md).
