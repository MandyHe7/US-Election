#### Preamble ####
# Purpose: Simulates a dataset to understand expected outcomes and potential errors in analysis
# Author: Mandy He and Wendy Yuan
# Date: 18 October 2024 
# Contact: Mandyxy.he@mail.utoronto.ca and w.yuan@mail.utoronto.ca
# License: N/A
# Pre-requisites: N/A


#### Workspace setup ####
# Load necessary libraries

library(tidyverse)
library(dplyr)       # For data manipulation
library(ggplot2)     # For visualization
library(broom)       # For tidying model output
set.seed(853)

# Load the dataset
data <- read.csv("data/02-analysis_data/analysis_data.csv")

# Data Cleaning and Preparation
# Filter out only Democrats and Republicans for simplicity
data <- data %>% 
  filter(party %in% c("DEM", "REP"))

# Create a binary variable for the outcome where 1 = Democrat, 0 = Republican
data <- data %>%
  mutate(outcome = ifelse(party == "DEM", 1, 0))

# Prepare data for logistic regression
# We will use the percentage (pct) and sample size as predictors for the outcome (DEM win or not)
# Ensure the necessary columns are numeric
data$pct <- as.numeric(data$pct)
data$sample_size <- as.numeric(data$sample_size)

# Fit a logistic regression model
# This model predicts the outcome based on polling percentages and sample size
model <- glm(outcome ~ pct + sample_size, data = data, family = binomial())

# Summarize the model
summary(model)

# Simulate Predictions
# Predict probabilities for each row
data$predicted_prob <- predict(model, type = "response")

# Generate winner prediction (1 if probability > 0.5, else 0)
data$predicted_winner <- ifelse(data$predicted_prob > 0.5, "DEM", "REP")



# Save the updated dataset with predictions
#### Save data ####
write_csv(data, "data/00-simulated_data/simulated_data.csv")
