preview <- function(records) {
  records |>
    slice_head(n = 6)
}

format_zipcodes <- function(zipcodes) {
  zipcodes |>
    str_pad(width = 5, pad = "0")
}
