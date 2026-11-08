preview <- function(records) {
  records |>
    slice_head(n = 6)
}

format_zipcodes <- function(zipcodes) {
  zipcodes |>
    str_detect("^[0-9]{1,5}$") ->
    contains_one_to_five_digits

  zipcodes |>
    str_pad(width = 5, pad = "0") ->
    padded_zipcodes

  if_else(contains_one_to_five_digits, padded_zipcodes, zipcodes)
}
