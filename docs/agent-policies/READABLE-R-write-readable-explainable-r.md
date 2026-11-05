---
id: READABLE-R
type: operational
scope: "Agent-authored R analysis and validation code in Barkonomics."
status: proposed
authority: "Proposed following Aslan's 2026-11-05 request to consider encoding the project's R readability requirements."
revised: "2026-11-05"
depends_on: []
related_to: []
---
# Write readable, explainable R
Write R analysis and validation code that collaborators can read in execution order, inspect at meaningful stages, and explain in the course interview. Apply the following distinct rules within this shared readability purpose.

## Load tidyverse as a suite
Use `library(tidyverse)` for the project's tidyverse analysis scripts rather than loading its component packages individually. Keep additional dependencies limited to operations the suite does not supply.

## Express transformations in sequence
Use native `|>` pipes and the course's tidyverse verbs where appropriate. Flatten deeply nested transformations into sequential steps or named intermediate results. Break long pipelines at meaningful stages that can be inspected independently. Keep simple function arguments and short expressions intact when splitting them would obscure their meaning.

## Put assignment after the computation
Use rightward assignment (`->`) to place the descriptive result name after the computation or pipeline, preserving left-to-right reading order.

## Use descriptive names
Name variables, intermediate tables, loop indices and arguments for their contents or purpose. Avoid single-letter placeholders.

## Keep the implementation explainable
Prefer straightforward operations to unnecessary helper abstractions. Explain unfamiliar operations briefly where they occur. Straightforward `for` loops and base R functions are allowed; do not replace them solely to eliminate loops or force every expression into a pipe. Preserve agreed research rules and output contracts during readability changes.
