---
id: VALIDATE-CHANGES
type: operational
scope: "Agent validation of workflow changes."
status: adopted
authority: "Aslan explicitly approved these nine exact policies and AGENTS routing on 2026-11-02."
revised: "2026-11-02"
depends_on: []
related_to: []
---
# Check the affected workflow artifacts
For workflow changes, check TOML, local links/resources, child ancestry, exact gitlinks, copied starter files and private-state ignores. The optional existing-Node check is `node --test project-workflows/setup-project-workflows/tests/test-github-lifecycle.cjs`; ordinary use does not require installing Node. No analysis build/test process has been established yet.
