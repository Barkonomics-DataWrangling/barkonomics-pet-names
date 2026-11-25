# Each pair contains two licenses with the same formatted name, sex, birth year and breed.
find_license_pairs <- function(licenses) {
  licenses |>
    select(name, sex, birth_year, breed,
           earlier_source_row = source_row_id,
           earlier_zipcode = zipcode,
           earlier_issue = license_issue_date,
           earlier_expiry = license_expiry_date) ->
    earlier_licenses

  licenses |>
    select(name, sex, birth_year, breed,
           later_source_row = source_row_id,
           later_zipcode = zipcode,
           later_issue = license_issue_date,
           later_expiry = license_expiry_date) ->
    later_licenses

  earlier_licenses |>
    inner_join(later_licenses,
               by = c("name", "sex", "birth_year", "breed"),
               relationship = "many-to-many") |>
    filter(later_issue > earlier_issue |
             (later_issue == earlier_issue & later_source_row > earlier_source_row)) |>
    mutate(
      same_zipcode = earlier_zipcode == later_zipcode,
      days_from_expiry = as.numeric(difftime(later_issue, earlier_expiry, units = "days")),
      days_between_issues = as.numeric(difftime(later_issue, earlier_issue, units = "days"))
    ) ->
    license_pairs

  license_pairs
}

# Windows are assumptions to compare, not measured probabilities of identity.
choose_license_links <- function(license_pairs, renewal_days, moving_days, correction_days = 0, prefer_same_zip = FALSE) {
  license_pairs |>
    mutate(
      renewal_window = if_else(same_zipcode, renewal_days, moving_days),
      possible_renewal = days_between_issues > 0 &
        abs(days_from_expiry) <= renewal_window & later_expiry > earlier_expiry,
      possible_correction = correction_days > 0 & same_zipcode &
        days_between_issues > 0 & days_between_issues <= correction_days &
        later_expiry != earlier_expiry
    ) |>
    filter(possible_renewal | possible_correction) |>
    mutate(link_reason = case_when(
      possible_renewal & same_zipcode ~ "renewal in same ZIP",
      possible_renewal ~ "renewal across ZIPs",
      .default = "possible expiry correction"
    )) ->
    candidate_links

  if (prefer_same_zip) {
    candidate_links |>
      filter(same_zipcode) |>
      add_count(earlier_source_row, name = "possible_successors") |>
      add_count(later_source_row, name = "possible_predecessors") |>
      mutate(link_accepted = possible_successors == 1 & possible_predecessors == 1) ->
      same_zip_links

    same_zip_links |>
      filter(link_accepted) ->
      accepted_same_zip_links

    candidate_links |>
      filter(!same_zipcode) |>
      mutate(same_zip_connection_takes_priority =
        earlier_source_row %in% accepted_same_zip_links$earlier_source_row |
        later_source_row %in% accepted_same_zip_links$later_source_row) ->
      cross_zip_review

    cross_zip_review |>
      filter(!same_zip_connection_takes_priority) |>
      add_count(earlier_source_row, name = "possible_successors") |>
      add_count(later_source_row, name = "possible_predecessors") |>
      mutate(link_accepted = possible_successors == 1 & possible_predecessors == 1) ->
      cross_zip_links

    cross_zip_review |>
      filter(same_zip_connection_takes_priority) |>
      mutate(link_accepted = FALSE) ->
      cross_zip_links_set_aside

    return(bind_rows(same_zip_links, cross_zip_links, cross_zip_links_set_aside))
  }

  candidate_links |>
    add_count(earlier_source_row, name = "possible_successors") |>
    add_count(later_source_row, name = "possible_predecessors") |>
    mutate(link_accepted = possible_successors == 1 & possible_predecessors == 1) ->
    reviewed_links

  reviewed_links
}

# Accepted links form chronological chains: each license has at most one predecessor and one successor.
# Follow those chains in issue-date order. A->B and B->C receive one group; a competing A->B/A->C pair is never chosen here.
assign_license_groups <- function(licenses, reviewed_links) {
  reviewed_links |>
    filter(link_accepted) |>
    arrange(later_issue, later_source_row) |>
    mutate(
      earlier_position = match(earlier_source_row, licenses$source_row_id),
      later_position = match(later_source_row, licenses$source_row_id)
    ) ->
    accepted_links

  license_groups <- licenses$source_row_id

  for (link_number in seq_len(nrow(accepted_links))) {
    earlier_position <- accepted_links$earlier_position[link_number]
    later_position <- accepted_links$later_position[link_number]
    license_groups[later_position] <- license_groups[earlier_position]
  }

  licenses |>
    mutate(license_group = license_groups) ->
    grouped_licenses

  grouped_licenses
}

# Review pairs that differ in one identity field while the other four fields match.
# This function reports possibilities only; none of these pairs is automatically consolidated.
find_changed_field_pairs <- function(licenses, matching_fields, changed_field, review_days = 14) {
  licenses |>
    select(source_row_id, name, sex, birth_year, breed, zipcode,
           license_issue_date, license_expiry_date) ->
    identity_records

  identity_records |>
    inner_join(identity_records, by = matching_fields,
               suffix = c("_earlier", "_later"), relationship = "many-to-many") |>
    filter(license_issue_date_later > license_issue_date_earlier |
             (license_issue_date_later == license_issue_date_earlier &
                source_row_id_later > source_row_id_earlier)) |>
    mutate(days_between_issues = as.numeric(difftime(
      license_issue_date_later, license_issue_date_earlier, units = "days"))) |>
    filter(days_between_issues <= review_days) ->
    nearby_records

  # The field being reviewed has an earlier and a later column after the join.
  earlier_values <- nearby_records[[paste0(changed_field, "_earlier")]]
  later_values <- nearby_records[[paste0(changed_field, "_later")]]

  nearby_records |>
    mutate(field_changed = changed_field,
           earlier_value = as.character(earlier_values),
           later_value = as.character(later_values)) |>
    filter(earlier_value != later_value) |>
    select(field_changed, source_row_id_earlier, source_row_id_later,
           earlier_value, later_value, days_between_issues,
           license_issue_date_earlier, license_expiry_date_earlier,
           license_issue_date_later, license_expiry_date_later) ->
    changed_field_pairs

  changed_field_pairs
}

# Optional appendix experiment: prioritize unambiguous shared-expiry term changes before ordinary matching.
compare_term_change_window <- function(licenses, pairs, term_change_days, prefer_same_zip = TRUE) {
  pairs |>
    mutate(expiry_month_a = month(earlier_expiry),
           expiry_month_b = month(later_expiry),
           expiry_day_a = day(earlier_expiry),
           expiry_day_b = day(later_expiry),
           expiry_year_a = year(earlier_expiry),
           expiry_year_b = year(later_expiry)) |>
    filter(same_zipcode, days_between_issues > 0,
           days_between_issues <= term_change_days,
           expiry_month_a == expiry_month_b,
           expiry_day_a == expiry_day_b,
           expiry_year_b > expiry_year_a) |>
    add_count(earlier_source_row, name = "possible_replacements") |>
    add_count(later_source_row, name = "possible_originals") |>
    filter(possible_replacements == 1, possible_originals == 1) ->
    term_changes

  replaced_rows <- term_changes$earlier_source_row
  licenses |>
    filter(!source_row_id %in% replaced_rows) ->
    retained_licenses

  pairs |>
    filter(!earlier_source_row %in% replaced_rows,
           !later_source_row %in% replaced_rows) ->
    retained_pairs

  choose_license_links(retained_pairs, renewal_days = 30,
                       moving_days = 7, correction_days = 5,
                       prefer_same_zip = prefer_same_zip) ->
    renewal_links
  assign_license_groups(retained_licenses, renewal_links) ->
    retained_groups

  retained_groups |>
    summarise(estimated_dogs = n_distinct(license_group)) |>
    mutate(term_change_days = term_change_days,
           term_change_pairs = nrow(term_changes),
           unresolved_links = sum(!renewal_links$link_accepted)) ->
    scenario_summary

  scenario_summary
}
