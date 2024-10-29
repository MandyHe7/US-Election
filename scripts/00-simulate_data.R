#### Preamble ####
# Purpose: Simulates a dataset to understand expected outcomes and potential errors in analysis
# Author: Mandy He and Wendy Yuan
# Date: November 4, 2024
# Contact: Mandyxy.he@mail.utoronto.ca and w.yuan@mail.utoronto.ca
# License: N/A
# Pre-requisites: N/A


#### Workspace setup ####
# Load necessary library
library(tidyverse)
library(dplyr)
library(readr)
library(lubridate)

# Set seed for reproducibility
set.seed(12345)

# Define parameters for the simulation
pollsters <- c("YouGov", "Siena/NYT", "Ipsos", "Gallup", "SurveyMonkey")
numeric_grades <- signif(runif(10, min = 1, max = 3), digits = 2)
pollscores <- seq(-2, 2, by = 0.5)
methodologies <- c("Online Panel", "Live Phone", "Mixed Mode")
states <- c("Arizona", "Michigan", "Georgia", "Pennsylvania", "Florida")
parties <- "DEM"
answers <- c("Harris", "Biden")

# Simulate dates
start_dates <- seq(as.Date("2024-09-01"), as.Date("2024-10-31"), by = "day")
end_dates <- start_dates + sample(3:7, length(start_dates), replace = TRUE)

# Number of polls to simulate
n_polls <- 100

# Define the range of sample sizes
sample_size_min <- 500
sample_size_max <- 3000

# Simulate data
simulated_data <- data.frame(
  pollster = sample(pollsters, n_polls, replace = TRUE),
  numeric_grade = sample(numeric_grades, n_polls, replace = TRUE),
  pollscore = sample(pollscores, n_polls, replace = TRUE),
  methodology = sample(methodologies, n_polls, replace = TRUE),
  state = sample(states, n_polls, replace = TRUE),
  start_date = sample(start_dates, n_polls, replace = TRUE),
  end_date = sample(end_dates, n_polls, replace = TRUE),
  sample_size = sample(seq(sample_size_min, sample_size_max, by = 50), n_polls, replace = TRUE),
  party = sample(parties, n_polls, replace = TRUE),
  answer = sample(answers, n_polls, replace = TRUE),
  pct = round(runif(n_polls, 40, 55), 1) # Random polling percentages between 40% and 55%
)

# Simulate a winner based on polling percentages
simulated_data <- simulated_data %>%
  mutate(predicted_winner = ifelse(pct > 50, "DEM", "REP")) # Predict winner based on percentage

# Save the updated dataset with predictions
#### Save data ####
write_csv(simulated_data, "data/00-simulated_data/simulated_data.csv")
