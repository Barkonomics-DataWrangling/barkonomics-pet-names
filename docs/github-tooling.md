# GitHub tooling for Barkonomics
[project-workflows.toml](project-workflows.toml) owns the repository target, selected provider, exact source revision, required skill folders and human branch prefixes. This guide explains how to use that selection. Shared outcomes and acceptance belong in issues; review and integration belong in PRs. Historical setup and test evidence live in the [integration spike](active-spikes/github-workflow-integration.md), [task record](active-spikes/github-workflow-integration.todo.md) and Git history. These records are not standing authorization for new writes.

## Resolve the selected installation
Read the shared `[references]` table and its optional ignored sibling `project-workflows.local.toml`. The local `github_tooling` reference points to the selected external bundle. Resolve relative paths from the defining file’s directory; read values as paths, never commands. The project ignores the local file as a whole. A collaborator supplies their own installation path and needs neither another person’s private files nor their personal workspace.

Read the bundle’s installation manifest and verify it matches `coordination.tooling_source.revision`. Use its selected setup/use skills with their complete supporting files and required sibling dependencies; a skill Markdown file alone is insufficient. Preserve the source license. If the bundle is missing, obtain the configured revision into a contributor-chosen external location through the provider’s setup procedure. Do not substitute a different global release or install unrelated providers. Global skill-name discovery is optional.

## Use the tools
The selected release uses Bash, Git, gh, jq and Python 3.11+. `GITHUB_PYTHON` can select an existing compatible interpreter. Reuse the contributor’s existing GitHub authentication and verify the effective account and explicit repository target before operating. Never switch accounts or broaden access merely because a read fails.

Use the selected issue, PR and Projects entrypoints for their supported operations. They provide read-only inspection and mutation previews. Authorized writes require the unchanged preview fingerprint, effective actor and operation ID, followed by independent readback. An uncertain write requires read-only recovery before any retry. The operated checkout owns the ignored `.github/project-collaboration/` journal; preserve it and never commit it.

PR tooling supports an overall conversation comment, line/range comments on an inspected diff, replies, formal reviews and deliberate thread resolution. These capabilities do not authorize speaking for a collaborator or posting an unapproved review. Branch renaming is not implemented in this selected bundle; an explicitly requested rename may use GitHub’s documented branch-rename operation with exact target and before/after commit verification. Existing published commit identities are preserved.

## Shared Actions runner
The repository’s lifecycle runner uses an organization-owned GitHub App. Contributors use their own accounts for ordinary issue/PR work; they do not need the runner’s private key. The owner handles App installation, secure key storage and Actions secret entry. Never copy the key into this repository, local references or an agent tool call.

For owner-authorized key rotation, generate an App key in GitHub settings, retain it in the owner’s secure store and enter the entire PEM directly as Actions secret `PW_APP_PRIVATE_KEY`. `PW_APP_CLIENT_ID` and `PW_AUTH_METHOD=app` are nonsecret Actions variables. Do not substitute an OAuth client secret. Verify a scoped hosted run and its actual issue/board effect after an authorized change.

The selected bundle lacks Actions run inspection and dispatch. Read-only `gh run list` and `gh run view` can inspect exact repository/ref evidence; `gh workflow run` requires separate scope to dispatch a selected workflow. Inspect run event, head, inputs, result and affected issue/board state. Neither installed tools nor this guide grant publication, merge, assignment, credential or automation authority.
