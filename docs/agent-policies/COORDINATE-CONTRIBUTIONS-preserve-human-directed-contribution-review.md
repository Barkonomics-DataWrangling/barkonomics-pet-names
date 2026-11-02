---
id: COORDINATE-CONTRIBUTIONS
type: operational
scope: "Agent contribution coordination in Barkonomics."
status: adopted
authority: "Aslan explicitly approved these nine exact policies and AGENTS routing on 2026-11-02."
revised: "2026-11-02"
depends_on: []
related_to: []
---
# Preserve human-directed contribution review
Use [Coordinate Project Contribution](../../project-workflows/coordinate-project-contribution/SKILL.md) to start contribution/review work under the humans' direction. Independent agents keep separate spikes; a branch may contain several spikes/issues and lead to several contributions. Preserve original atomic commits and suitable project documents rather than imposing one issue per branch or spike.

For GitHub-tracked contributions, first reconcile the shared outcome with existing issues and create or update an issue within the approved scope. Once the relevant issue exists and implementation is authorized, select an appropriate existing contribution branch or create one without disturbing another person’s active checkout. Establish that branch context before creating agent-owned spikes or starting local implementation, then link the issue, spikes and commits. A meeting action can be recorded and an issue proposal prepared before implementation is authorized. Prepare or update a pull request early enough for collaborators to see the scope, dependencies and integration plan, discuss it and review the changes before an authorized merge. A draft pull request can make work visible while it is in progress. One branch may still carry multiple spikes/issues and several eventual pull requests. Prepare publication and issue/PR updates for a human when live writes are outside the current scope; do not treat this workflow as GitHub-enforced branch protection.

Aslan and his agent own initial baseline setup and testing; Shweta’s onboarding or review is not a prerequisite. Her contributions are prepared with her agent and submitted for Aslan and his agent to review before an authorized merge. Any later review from Shweta is optional unless an actual project rule or human decision requires it.

The [GitHub workflow integration spike](../../docs/active-spikes/github-workflow-integration.md) owns the existing public Project Management Kanban and selected five-lane setup. Issues own discussion, tracking, progress, acceptance and board cards; PRs are discrete reviews/integration points, and partial work leaves unfinished acceptance open. PR cards require an explicit project exception. Resolve formal PR links, repository auto-close and native linked/merged-PR issue transitions before live testing; excluding PR cards alone does not protect Blocked/terminal intent. The spike distinguishes selected stages from proposed automation choices, and its task record owns the user-held live-testing boundary and remaining checks. Template availability and this routing do not authorize external writes or enable automation.
