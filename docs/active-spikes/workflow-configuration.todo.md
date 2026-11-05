---
attention: live
---
# Workflow configuration migration tasks
## Done
- Centralized tool source/version/capabilities and Aslan’s branch prefix in TOML, reduced the tooling guide to current procedures, and added docs.index.md navigation. Updated maintained historical branch references and verified the remote rename preserves its commit. Existing merged-PR metadata and commit messages were not rewritten.
- Renamed the shared configuration, migrated all four exact source baselines, moved private references into ignored TOML and updated active routing.
- Verified shared settings and asset records against the prior tracked files, TOML parsing, private-file ignore/nontracking, policy links and whitespace. Repeated migration reports no changes; the new updater previews the existing pin with no asset changes.
## Ready for review
- This workflow-output checkpoint is separate from R/data and READABLE-R policy work. Review the local commit before publication.
## Later
- Discuss the separately committed upstream change, publication and exact consumer-pin update. The current pinned updater predates this layout; defer routine updates until rollout. No remote publication or broad rollout is performed.
