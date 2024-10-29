# Load the styler package
library(styler)

# Define files to format
files_to_format <- c("scripts/00-simulate_data.R",
                     "scripts/01-test_simulated_data.R",
                     "scripts/02-download_data.R",
                     "scripts/03-clean_data.R",
                     "scripts/04-test_analysis_data.R",
                     "paper/paper.qmd")

# Loop through each file and format it
lapply(files_to_format, style_file)