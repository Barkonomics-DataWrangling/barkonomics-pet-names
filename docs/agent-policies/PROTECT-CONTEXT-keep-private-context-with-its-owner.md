---
id: PROTECT-CONTEXT
type: operational
scope: "Agent access to private context and shared project records."
status: adopted
authority: "Aslan explicitly approved these nine exact policies and AGENTS routing on 2026-11-02."
revised: "2026-11-02"
depends_on: []
related_to: []
---
# Keep private context with its owner
When a task needs private project context, read the task-relevant keys in `[references]` from [project-workflows.toml](../project-workflows.toml) and its optional ignored sibling `project-workflows.local.toml` as TOML data. Local values override the same reference keys only. Resolve relative paths from the defining file's directory; read only the relevant declared context. Shared configuration contains commented examples, never personal paths. Do not execute values, load unrelated secret files or copy private context into this repository. Missing configuration/access is a specific context gap; independent work can continue. Other contributors need neither this private context nor the maintainer’s personal agent configuration.

This repository is shared: keep credentials, private course/meeting material, personal workspace paths and private service recovery records out of commits. Do not copy private context into public project records. Keep prose paragraphs on single lines and avoid unrelated reformatting.
