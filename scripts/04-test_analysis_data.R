#### Preamble ####
# Purpose: Tests for Quality and Validation 
# Author: Mandy He and Wendy Yuan
# Date: 18 October 2024 
# Contact: Mandyxy.he@mail.utoronto.ca and w.yuan@mail.utoronto.ca
# License: N/A
# Pre-requisites: N/A


#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(readr)

# Load the cleaned dataset
cleaned_data <- read_csv("data/02-analysis_data/analysis_data.csv")


# Define acceptable values for party
valid_parties <- c("DEM", "REP")

#### Test 1: Check for Missing Values ####
missing_data_test <- function(data) {
  has_missing <- any(is.na(data[c("answer", "pct", "sample_size", "party", "methodology")]))
  
  if (!has_missing) {
    print("Test 1 Passed: No missing values in critical columns.")
  } else {
    print("Test 1 Failed: Some missing values found in critical columns.")
  }
}

# Run Test 1
missing_data_test(cleaned_data)

#### Test 2: Check for Polling Percentages Between 0 and 100 ####
polling_percentage_test <- function(data) {
  valid_pct <- all(data$pct >= 0 & data$pct <= 100)
  
  if (valid_pct) {
    print("Test 2 Passed: All polling percentages are between 0 and 100.")
  } else {
    print("Test 2 Failed: Some polling percentages are outside the range 0-100.")
  }
}

# Run Test 2
polling_percentage_test(cleaned_data)

#### Test 3: Check Sample Size is Reasonable ####
sample_size_test <- function(data, min_sample_size = 100) {
  valid_sample_size <- all(data$sample_size > min_sample_size)
  
  if (valid_sample_size) {
    print("Test 3 Passed: All sample sizes are above the minimum threshold.")
  } else {
    print("Test 3 Failed: Some sample sizes are below the minimum threshold.")
  }
}

# Run Test 3
sample_size_test(cleaned_data)

#### Test 4: Check for Valid Party Values ####
party_test <- function(data) {
  valid_party <- all(data$party %in% valid_parties)
  
  if (valid_party) {
    print("Test 4 Passed: All party values are valid.")
  } else {
    print("Test 4 Failed: Some party values are invalid.")
  }
}

# Run Test 4
party_test(cleaned_data)

#### Test 5: Check for Negative Values in Sample Size ####
negative_sample_size_test <- function(data) {
  has_negative <- any(data$sample_size < 0)
  
  if (!has_negative) {
    print("Test 5 Passed: No negative sample sizes found.")
  } else {
    print("Test 5 Failed: Negative sample sizes found.")
  }
}

# Run Test 5
negative_sample_size_test(cleaned_data)

#### Test 6: Check for Only 2 Candidates (Joe Biden, Kamala Harris) Based on Answer Column ####
candidate_list_test <- function(data) {
  valid_candidates <- c("Harris", "Biden")
  
  # Check if all answer values are in the list of valid candidates
  all_valid_candidates <- all(data$answer %in% valid_candidates)
  
  if (all_valid_candidates) {
    print("Test 6 Passed: All candidate answers are either Joe Biden or Kamala Harris.")
  } else {
    print("Test 6 Failed: Some candidate answers are not in the expected list.")
    
    # Print the rows where the answer is not in the valid list
    invalid_candidates <- data[!data$answer %in% valid_candidates, ]
    print("Invalid candidate answers found:")
    print(unique(invalid_candidates$answer))
  }
}

# Run Test 6
candidate_list_test(cleaned_data)

#### Test 7: Check if Numeric Grade is Over 3 ####
numeric_grade_test <- function(data) {
  valid_numeric_grade <- all(data$numeric_grade >= 3)
  
  if (valid_numeric_grade) {
    print("Test 7 Passed: All numeric grades are greater or equal than 3.")
  } else {
    print("Test 7 Failed: Some numeric grades are below 3 ")
    
    # Print the rows where numeric grade is 3 or below
    invalid_numeric_grades <- data[data$numeric_grade < 3, ]
    print("Invalid numeric grades found:")
    print(invalid_numeric_grades$numeric_grade)
  }
}

# Run Test 7
numeric_grade_test(cleaned_data)


#### Test 8: Check for Consistent Date Formats ####
date_format_test <- function(data) {
  valid_start_dates <- all(!is.na(as.Date(data$start_date, format = "%Y-%m-%d")))
  valid_end_dates <- all(!is.na(as.Date(data$end_date, format = "%Y-%m-%d")))
  
  if (valid_start_dates & valid_end_dates) {
    print("Test 8 Passed: All start and end dates are in a consistent date format.")
  } else {
    print("Test 8 Failed: Some start or end dates are not in the correct format.")
  }
}

# Run Test 8
date_format_test(cleaned_data)


#### Test 9: Check if End Date is After Start Date ####
date_consistency_test <- function(data) {
  valid_dates <- all(as.Date(data$end_date) >= as.Date(data$start_date))
  
  if (valid_dates) {
    print("Test 9 Passed: All end dates are after or on the same day as start dates.")
  } else {
    print("Test 9 Failed: Some end dates are before start dates.")
    
    # Print the problematic rows
    invalid_dates <- data[as.Date(data$end_date) < as.Date(data$start_date), ]
    print("Rows with inconsistent dates found:")
    print(invalid_dates)
  }
}

# Run Test 9
date_consistency_test(cleaned_data)
