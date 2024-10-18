#### Preamble ####
# Purpose: Tests the structure and validity of the simulated US election clean data 
  #electoral divisions dataset.
# Author: Mandy He and Wendy Yuan
# Date: 18 October 2024 
# Contact: Mandyxy.he@mail.utoronto.ca and w.yuan@mail.utoronto.ca
# License: N/A
# Pre-requisites: N/A


#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(readr)

# Load the simulated data
simulated_data <- read_csv("data/00-simulated_data/simulated_data.csv")


#### Test 1: Check for Missing Values ####
missing_data_test <- function(data) {
  has_missing <- any(is.na(data[c("pollster", "numeric_grade", "pollscore", "methodology", 
                                  "state", "start_date", "end_date", "sample_size", "party", "answer", "pct")]))
  
  if (!has_missing) {
    print("Test 1 Passed: No missing values in critical columns.")
  } else {
    print("Test 1 Failed: Some missing values found in critical columns.")
  }
}

# Run Test 1
missing_data_test(simulated_data)

#### Test 2: Check Polling Percentages Between 0 and 100 ####
polling_percentage_test <- function(data) {
  valid_pct <- all(data$pct >= 0 & data$pct <= 100)
  
  if (valid_pct) {
    print("Test 2 Passed: All polling percentages are between 0 and 100.")
  } else {
    print("Test 2 Failed: Some polling percentages are outside the range 0-100.")
  }
}

# Run Test 2
polling_percentage_test(simulated_data)

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
sample_size_test(simulated_data)

#### Test 4: Check for Valid Party Values ####
valid_parties <- c("DEM", "REP")

party_test <- function(data) {
  valid_party <- all(data$party %in% valid_parties)
  
  if (valid_party) {
    print("Test 4 Passed: All party values are valid.")
  } else {
    print("Test 4 Failed: Some party values are invalid.")
  }
}

# Run Test 4
party_test(simulated_data)

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
negative_sample_size_test(simulated_data)
