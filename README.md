# Modeling 2024 U.S. Presidential Polling Trends

## Overview

This project analyzes polling data for the 2024 U.S. Presidential election, using data from FiveThirtyEight's aggregation of polls conducted by organizations such as YouGov and Siena/NYT. The goal is to examine trends in candidate support over time and across different regions, while accounting for factors like polling methodology and sample size. By applying both linear regression and Bayesian models, this analysis estimates the variability in polling results and highlights the uncertainty inherent in election predictions. The findings provide insights into how public opinion shifts leading up to the election and help improve the accuracy of forecasts. The code used for data cleaning, modeling, and visualization is included in this repository for full transparency and reproducibility.

## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from FiveThirtyEight.
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models. 
-   `other` contains about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.

## Statement on LLM usage

Graphing, simulating, cleaning, and editing writing in this paper is done by the help of ChatGPT 4o and the entire chat history is available in usage.txt located in the "llm" folder under "other" folder.
