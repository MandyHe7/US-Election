#### Preamble ####
# Purpose: Cleans the raw plane data recorded 
# Author: Mandy He and Wendy Yuan
# Date: 18 October 2024 
# Contact: Mandyxy.he@mail.utoronto.ca and w.yuan@mail.utoronto.ca
# License: N/A
# Pre-requisites: N/A

#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(lubridate)

#### Clean data ####
raw_data <- read_csv("data/01-raw_data/raw_data.csv")


# Clean the data
cleaned_data <- raw_data |>
  # Select relevant columns
  select(state, pollster, start_date, end_date, sample_size, population, candidate_name, pct, party, methodology) |>
  drop_na(state, pollster, start_date, end_date, sample_size, population, candidate_name, pct, party, methodology)|>
  # Convert start_date to Date format
  mutate(
    start_date = case_when(
      grepl("^[0-9]{4}-[0-9]{2}-[0-9]{2}$", start_date) ~ as.Date(start_date),  # YYYY-MM-DD
      grepl("^[0-9]{1,2}/[0-9]{1,2}/[0-9]{2}$", start_date) ~ as.Date(start_date, format = "%m/%d/%y"),  # MM/DD/YY
      TRUE ~ NA_Date_  # Set to NA for any unrecognized format
    )
  )

cleaned_data <- cleaned_data |>
  filter(candidate_name %in% c("Kamala Harris", "Donald Trump", "Joe Biden"))
  

#### Save data ####

write_csv(cleaned_data, "data/02-analysis_data/analysis_data.csv")
