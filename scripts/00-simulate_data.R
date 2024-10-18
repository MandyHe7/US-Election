#### Preamble ####
# Purpose: Simulates a dataset to understand expected outcomes and potential errors in analysis
# Author: Mandy He and Wendy Yuan
# Date: 18 October 2024 
# Contact: Mandyxy.he@mail.utoronto.ca and w.yuan@mail.utoronto.ca
# License: N/A
# Pre-requisites: N/A


#### Workspace setup ####
# Load necessary library
library(dplyr)

# Set seed for reproducibility
set.seed(12345)

# Define parameters for the simulation
states <- c("Arizona", "Wisconsin", "Michigan", "Georgia", "Pennsylvania", "Florida", "Ohio", "North Carolina")
pollsters <- c("YouGov")
methodologies <- c("Online Panel")
candidates <- c("Donald Trump", "Joe Biden", "Kamala Harris")
parties <- c("DEM", "REP")

# Number of simulated polls
n_polls <- 100

# Simulate data
simulated_data <- data.frame(
  state = sample(states, n_polls, replace = TRUE),
  pollster = sample(pollsters, n_polls, replace = TRUE),
  start_date = sample(seq(as.Date('2024-09-01'), as.Date('2024-10-15'), by="day"), n_polls, replace = TRUE),
  end_date = sample(seq(as.Date('2024-09-10'), as.Date('2024-10-20'), by="day"), n_polls, replace = TRUE),
  sample_size = sample(500:2000, n_polls, replace = TRUE),
  population = rep("lv", n_polls),
  candidate_name = sample(candidates, n_polls, replace = TRUE),
  pct = round(runif(n_polls, 40, 55), 1),  # Random polling percentages between 40% and 55%
  party = ifelse(sample(candidates, n_polls, replace = TRUE) == "Kamala Harris" | 
                   sample(candidates, n_polls, replace = TRUE) == "Joe Biden", "DEM", "REP"),
  methodology = sample(methodologies, n_polls, replace = TRUE)
)

# Simulate outcome based on polling percentages (randomly assign winner based on poll data)
simulated_data <- simulated_data %>%
  group_by(state, pollster) %>%
  mutate(outcome = ifelse(pct > 50, 1, 0),  # Assume if pct > 50, the candidate "wins"
         predicted_prob = pct / 100,        # Simulate a probability based on pct
         predicted_winner = ifelse(predicted_prob >= 0.5, "DEM", "REP"))


# Save the updated dataset with predictions
#### Save data ####
write_csv(simulated_data, "data/00-simulated_data/simulated_data.csv")
