---
id: READABLE-R
type: operational
scope: "Agent-authored R analysis and validation code in Barkonomics."
status: adopted
authority: "Aslan explicitly directed use of these R readability preferences throughout the project and confirmed adoption on 2026-11-25, including str_glue text templates, separate date formatting and a preference for row-oriented tribble table construction."
revised: "2026-11-25"
depends_on: []
related_to: []
---
# Write readable, explainable R
Write R analysis and validation code that collaborators can read in execution order, inspect at meaningful stages, and explain in the course interview. Apply the following distinct rules within this shared readability purpose.

## Load tidyverse as a suite
Use `library(tidyverse)` for the project's tidyverse analysis scripts rather than loading its component packages individually. Keep additional dependencies limited to operations the suite does not supply.

## Express transformations in sequence
Use native `|>` pipes and the course's tidyverse verbs where appropriate. Flatten deeply nested transformations into sequential steps or named intermediate results. Break long pipelines at meaningful stages that can be inspected independently. Keep simple function arguments and short expressions intact when splitting them would obscure their meaning.

## Choose assignment direction by purpose
Use leftward assignment (`<-`) for initial inputs and configuration. Use rightward assignment (`->`) for transformation results, including intermediate tables reused by later chunks. Keep the direction consistent when a longer workflow is divided by headings or commentary. If an input is consumed only by the immediately following pipeline, pipe directly from its creation or read operation unless a named stage provides a useful inspection point. Assignment direction communicates intent; both operators assign in the same environment and neither creates a different scope.

## Use descriptive names
Name variables, intermediate tables, loop indices and arguments for their contents or purpose. Avoid single-letter placeholders and opaque abbreviations. Fixed library argument names, such as `n` in `slice_head()`, are not user-defined variables; explain unfamiliar arguments instead of inventing wrappers to rename them.

## Keep the implementation explainable
Prefer straightforward operations to unnecessary helper abstractions. Explain unfamiliar operations briefly where they occur. Straightforward `for` loops and base R functions are allowed; do not replace them solely to eliminate loops or force every expression into a pipe. Preserve agreed research rules and output contracts during readability changes.

## Construct text with readable templates
Prefer `str_glue()` over `str_c()` when inserting values into filenames, labels or other text templates. Keep the full text pattern visible, with descriptive variable or column names inside braces. Prepare dates and other transformed values in a preceding step rather than nesting transformations inside the template. Preserve intentional line breaks and check that generated text stays the same when replacing existing construction code. Combining several values into one string is a separate operation; this preference does not require using `str_glue()` for that purpose. Preserve quoted source code when documenting someone else's implementation.

## Present small tables row by row
Prefer `tribble()` for small explicitly constructed tables and teaching examples so column headings and each row can be read together. Use descriptive column names and preserve the table’s values and types. Keep `tibble()` when assembling existing vectors into columns and a row-oriented rewrite would obscure the operation or require unnecessary iteration. This preference concerns table construction, not replacing tibble objects returned by imports and tidyverse transformations.
