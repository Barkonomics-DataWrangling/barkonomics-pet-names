# GitHub tooling for Barkonomics
The selected Agent Hands baseline is [2275b24863980c75a65d6c90d666d223cf4f50b3](https://github.com/jcklpe/agent-hands/commit/2275b24863980c75a65d6c90d666d223cf4f50b3). Use this exact source for the integration checks below. The [integration spike](active-spikes/github-workflow-integration.md) owns project choices and acceptance; [AGENTS](../AGENTS.md) owns contribution and authorization rules. Pushes and live GitHub changes remain on hold.

## Selected files and capabilities
Keep these complete source folders as siblings in an external tool location, outside this repository and any synchronized Drive folder. Preserve their files, references, manifests, locks and tests; copying only SKILL.md is insufficient.

| Source folder | Selected purpose |
| --- | --- |
| `setup-github/` | Shared provider scripts, literal configuration examples, account guidance, rendering and guarded collaboration runtime. Required by every selected use skill. |
| `use-github-issues/` | Exact issue reads, exports and explicitly authorized issue creation, edits, comments and close/reopen. |
| `use-github-pull-requests/` | PR inspection, drafts/updates, discussion/reviews and separately authorized integration. |
| `use-github-projects/` | Existing configured-board export and Status move preview. No board/item/field/view creation or native automation verification at this revision. No Barkonomics board alias is selected yet. |

Retain the source root `LICENSE`. Optional client-link support also needs `setup-agent-hands/scripts/skill_links.py` and `setup-agent-hands/references/global-skill-links.md` at their original relative paths; the service entrypoint already travels in `setup-github/scripts/link-skills.py`. The general setup dialogue, other providers, Discussions and Agent Hands’ Project Workflows submodule are not dependencies of this selection. The bundle has 49 original source files, about 284 KiB, before its local installation manifest; no Agent Hands source code is vendored here.

Have the setup agent read the selected `setup-github/SKILL.md` and applicable use skills directly. Keep local installation paths and private configuration outside committed project guidance. An optional ignored paths-only project context pointer can identify an existing installation; another contributor chooses their own tool location. Global discovery is optional and separate from the runtime. Preserve existing global links and other projects' selected versions; preview any requested registration before applying it and verify actual discovery in a fresh client separately.

## Runtime and access
Bash 3.2+, Git, gh, jq and Python 3.11+ support this selection on the tested Mac. The Python runtime uses only the standard library. Choose an existing compatible interpreter with `GITHUB_PYTHON`, or use only the selected capability’s uv manifest/lock. Do not create an environment or dependency tree in this project or Drive merely to use Project Workflows. Linux/WSL fresh onboarding and native Windows are not established by this check.

Reuse the person's existing gh authentication; setup is not permission to switch accounts, broaden grants or copy credentials. Issue/PR operations can use explicit `Barkonomics-DataWrangling/pet-names` without an alias. Projects require a separately selected/configured board under this baseline. Agent authentication and recovery records stay private; runner App/token secrets and lifecycle variables are a separate later GitHub setup step.

Exact issue/PR writes use concrete previews, actor/target checks, matching fingerprints/operation IDs, the operated project's ignored recovery journal and independent readback. An uncertain send needs recovery before retrying. The existing Projects mover has a narrower contract and no independent complete-state readback: inspect its own skill and the board independently before any later authorized use. Tool availability never authorizes a mutation. The supplied lifecycle Actions/helper remain Project Workflows assets; avoid competing transition writers.

## Local verification — 2026-10-31
Verification results are recorded in the [integration task log](active-spikes/github-workflow-integration.todo.md#github-only-provider-handoff--2026-10-31). The selected source files are hash-verified against the exact revision. Offline checks use synthetic gh data and isolated account/configuration directories; the real read-only check preserves the existing account. No global client links, credentials, board configuration or live write is created by those checks.

Local runtime verification does not establish a fresh agent client's discovery, another person's permissions, live PR reviewer changes, hosted Actions execution, board provisioning or the complete meeting-to-merge path. The parent and Project Workflows adaptation are unpublished; a remote collaborator cannot retrieve this setup until the child revision and then its parent pin are published under a resolved hold.
