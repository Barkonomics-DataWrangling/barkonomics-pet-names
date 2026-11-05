---
attention: live
---
# Consolidate the project workflow configuration
The user authorized a separate local workflow-output contribution: use docs/project-workflows.toml for shared settings and the four copied-asset baselines, and ignored docs/project-workflows.local.toml for machine-specific reference paths. Local references override only matching reference keys. Relative reference values resolve from the file defining them. Keep private values outside shared files and remove the superseded root manifest/reference files.

This work relates to workflow setup issue #3 and is separate from dog/name issue #1 and the READABLE-R policy proposal. The reusable updater change belongs to Project Workflows main; this receiving change is a distinct commit. The current workflow pin remains unchanged until publication and consumer rollout are discussed. The older pinned updater cannot discover the new layout; use the revised canonical helper explicitly for the authorized local migration, and defer routine updates until the new source is published and pinned. Existing direct-file skills remain available.
