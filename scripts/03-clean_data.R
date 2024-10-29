#### Preamble ####
# Purpose: Cleans the raw plane data recorded
# Author: Mandy He and Wendy Yuan
# Date: November 4, 2024
# Contact: Mandyxy.he@mail.utoronto.ca and w.yuan@mail.utoronto.ca
# License: N/A
# Pre-requisites: N/A

#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(readr)

#### Clean data ####
raw_data <- read_csv("data/01-raw_data/raw_data.csv")


# Filter data to DEM estimates based on high-quality polls after DEM declared
just_DEM_high_quality <- raw_data |>
  filter(
    answer %in% c("Biden", "Harris"),
    numeric_grade >= 3
  ) |>
  mutate(
    state = if_else(is.na(state), "National", state), # Hacky fix for national polls - come back and check
    end_date = mdy(end_date),
    start_date = mdy(start_date)
  ) |>
  mutate(
    num_DEM = round((pct / 100) * sample_size, 0) # Need number not percent for some models
  ) |>
  select(pollster, numeric_grade, pollscore, methodology, state, start_date, end_date, sample_size, party, answer, pct, num_DEM) |>
  drop_na(pollster, numeric_grade, pollscore, methodology, state, start_date, end_date, sample_size, party, answer, pct, num_DEM)

#### Save data ####
write_csv(just_DEM_high_quality, "data/02-analysis_data/analysis_data.csv")
