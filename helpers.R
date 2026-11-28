preview <- function(records) {
  records |>
    slice_head(n = 6)
}

# A missing lookup result means the dog's name did not match the baby-name reference.
missing_means_false <- function(matches) {
  matches |>
    replace_na(FALSE)
}
