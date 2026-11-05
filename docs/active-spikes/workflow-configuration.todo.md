---
attention: live
---
# Workflow configuration migration tasks
## Done
- Renamed the shared configuration, migrated all four exact source baselines, moved private references into ignored TOML and updated active routing.
- Verified shared settings and asset records against the prior tracked files, TOML parsing, private-file ignore/nontracking, policy links and whitespace. Repeated migration reports no changes; the new updater previews the existing pin with no asset changes.
## Ready for review
- This workflow-output checkpoint is separate from R/data and READABLE-R policy work. Review the local commit before publication.
## Later
- Discuss the separately committed upstream change, publication and exact consumer-pin update. The current pinned updater predates this layout; defer routine updates until rollout. No remote publication or broad rollout is performed.
