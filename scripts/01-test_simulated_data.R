#### Preamble ####
# Purpose: Tests the structure and validity of the simulated US election clean data 
  #electoral divisions dataset.
# Author: Mandy He and Wendy Yuan
# Date: 18 October 2024 
# Contact: Mandyxy.he@mail.utoronto.ca and w.yuan@mail.utoronto.ca
# License: N/A
# Pre-requisites: N/A


#### Workspace setup ####
library(readr)

# Load the simulated data
simulated_data <- read_csv("data/00-simulated_data/simulated_data.csv")

# 1. Test for Missing Values
missing_data_test <- function(data) {
  has_missing <- any(is.na(data[c("candidate_name", "pct", "sample_size", "party", "methodology", "predicted_prob", "predicted_winner")]))
  
  if (!has_missing) {
    print("Test 1 Passed: No missing values in critical columns.")
  } else {
    print("Test 1 Failed: Some missing values found in critical columns.")
  }
}

# 2. Test for Polling Percentages Between 0 and 100
polling_percentage_test <- function(data) {
  valid_pct <- all(data$pct >= 0 & data$pct <= 100)
  
  if (valid_pct) {
    print("Test 2 Passed: All polling percentages are between 0 and 100.")
  } else {
    print("Test 2 Failed: Some polling percentages are outside the range 0-100.")
  }
}

# 3. Test for Candidate Names
candidate_list_test <- function(data) {
  valid_candidates <- c("Donald Trump", "Joe Biden", "Kamala Harris")
  all_valid_candidates <- all(data$candidate_name %in% valid_candidates)
  
  if (all_valid_candidates) {
    print("Test 3 Passed: All candidate names are Donald Trump, Joe Biden, or Kamala Harris.")
  } else {
    print("Test 3 Failed: Some candidate names are not in the expected list.")
    
    invalid_candidates <- unique(data$candidate_name[!data$candidate_name %in% valid_candidates])
    print("Invalid candidate names found:")
    print(invalid_candidates)
  }
}

# 4. Test for Reasonable Sample Size (>100)
sample_size_test <- function(data, min_sample_size = 100) {
  valid_sample_size <- all(data$sample_size > min_sample_size)
  
  if (valid_sample_size) {
    print("Test 4 Passed: All sample sizes are above the minimum threshold.")
  } else {
    print("Test 4 Failed: Some sample sizes are below the minimum threshold.")
  }
}

# 5. Test for Outcome Consistency
outcome_consistency_test <- function(data) {
  consistent_outcome <- all(
    (data$predicted_prob >= 0.5 & data$predicted_winner == "DEM") |
      (data$predicted_prob < 0.5 & data$predicted_winner == "REP")
  )
  
  if (consistent_outcome) {
    print("Test 5 Passed: Predicted winners are consistent with predicted probabilities.")
  } else {
    print("Test 5 Failed: Some predicted winners are inconsistent with predicted probabilities.")
  }
}

# 6. Test for Valid Party Labels
party_test <- function(data) {
  valid_parties <- c("DEM", "REP")
  all_valid_parties <- all(data$party %in% valid_parties)
  
  if (all_valid_parties) {
    print("Test 6 Passed: All party labels are valid.")
  } else {
    print("Test 6 Failed: Some party labels are invalid.")
    
    invalid_parties <- unique(data$party[!data$party %in% valid_parties])
    print("Invalid party labels found:")
    print(invalid_parties)
  }
}

# Run the tests
missing_data_test(simulated_data)
polling_percentage_test(simulated_data)
candidate_list_test(simulated_data)
sample_size_test(simulated_data)
outcome_consistency_test(simulated_data)
party_test(simulated_data)
