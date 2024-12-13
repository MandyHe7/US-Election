#### Preamble ####
# Purpose: Downloads and saves the data from the website FiveThirtyEight
# Author: Mandy He and Wendy Yuan
# Date: November 4, 2024
# Contact: Mandyxy.he@mail.utoronto.ca and w.yuan@mail.utoronto.ca
# License: N/A
# Pre-requisites: N/A


#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(readr)

#### Download data ####
the_raw_data <- read_csv("data/01-raw_data/president_polls.csv")


#### Save data ####
# change the_raw_data to whatever name you assigned when you downloaded it.
write_csv(the_raw_data, "data/01-raw_data/raw_data.csv")
