#### Preamble ####
# Purpose: Tests for Quality and Validation 
# Author: Mandy He and Wendy Yuan
# Date: 18 October 2024 
# Contact: Mandyxy.he@mail.utoronto.ca and w.yuan@mail.utoronto.ca
# License: N/A
# Pre-requisites: N/A


#### Workspace setup ####
library(readr)

# Load the cleaned dataset
cleaned_data <- read_csv("data/02-analysis_data/analysis_data.csv")

# Define acceptable values for party and methodology
valid_parties <- c("DEM", "REP")


#### Test 1: Check for Missing Values ####
# Ensure that no key columns contain missing values
missing_data_test <- function(data) {
  has_missing <- any(is.na(data[c("candidate_name", "pct", "sample_size", "party", "methodology")]))
  
  if (!has_missing) {
    print("Test 1 Passed: No missing values in critical columns.")
  } else {
    print("Test 1 Failed: Some missing values found in critical columns.")
  }
}

# Run Test 1
missing_data_test(cleaned_data)

#### Test 2: Check for Proper Candidate Names (First and Last) ####
# Ensure that all candidate names have exactly two parts (first and last name)
candidate_name_test <- function(data) {
  valid_names <- all(sapply(data$candidate_name, function(name) {
    split_name <- strsplit(name, " ")[[1]]  # Split by space
    length(split_name) == 2  # Ensure name has two parts (first and last)
  }))
  
  if (valid_names) {
    print("Test 2 Passed: All candidate names have first and last names.")
  } else {
    print("Test 2 Failed: Some candidate names are missing first or last names.")
  }
}

# Run Test 2
candidate_name_test(cleaned_data)

#### Test 3: Check Polling Percentages Are Between 0 and 100 ####
polling_percentage_test <- function(data) {
  valid_pct <- all(data$pct >= 0 & data$pct <= 100)
  
  if (valid_pct) {
    print("Test 3 Passed: All polling percentages are between 0 and 100.")
  } else {
    print("Test 3 Failed: Some polling percentages are outside the range 0-100.")
  }
}

# Run Test 3
polling_percentage_test(cleaned_data)

#### Test 4: Check Sample Size is Reasonable ####
# Ensure that sample sizes are positive and above a certain threshold (e.g., 100)
sample_size_test <- function(data, min_sample_size = 100) {
  valid_sample_size <- all(data$sample_size > min_sample_size)
  
  if (valid_sample_size) {
    print("Test 4 Passed: All sample sizes are above the minimum threshold.")
  } else {
    print("Test 4 Failed: Some sample sizes are below the minimum threshold.")
  }
}

# Run Test 4
sample_size_test(cleaned_data)

#### Test 5: Check for Valid Party Values ####
party_test <- function(data) {
  valid_party <- all(data$party %in% valid_parties)
  
  if (valid_party) {
    print("Test 5 Passed: All party values are valid.")
  } else {
    print("Test 5 Failed: Some party values are invalid.")
  }
}

# Run Test 5
party_test(cleaned_data)


#### Test 6: Check for Negative Values in Sample Size ####
# Ensure that no sample sizes are negative
negative_sample_size_test <- function(data) {
  has_negative <- any(data$sample_size < 0)
  
  if (!has_negative) {
    print("Test 6 Passed: No negative sample sizes found.")
  } else {
    print("Test 6 Failed: Negative sample sizes found.")
  }
}

# Run Test 6
negative_sample_size_test(cleaned_data)

#### Test7: Check for Only 3 Candidates (Donald Trump, Joe Biden, Kamala Harris) ####
candidate_list_test <- function(data) {
  valid_candidates <- c("Donald Trump", "Joe Biden", "Kamala Harris")
  
  # Check if all candidate names are in the list of valid candidates
  all_valid_candidates <- all(data$candidate_name %in% valid_candidates)
  
  if (all_valid_candidates) {
    print("Test 7 Passed: All candidate names are either Donald Trump, Joe Biden, or Kamala Harris.")
  } else {
    print("Test 7 Failed: Some candidate names are not in the expected list.")
    
    # Print the rows where the candidate name is not in the valid list
    invalid_candidates <- data[!data$candidate_name %in% valid_candidates, ]
    print("Invalid candidate names found:")
    print(unique(invalid_candidates$candidate_name))
  }
}

# Run test 7: the new candidate list test
candidate_list_test(cleaned_data)

