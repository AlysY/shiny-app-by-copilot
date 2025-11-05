# shiny-app-by-copilot

A Shiny application for exploring synthetic data with multiple visualizations.

## Description

This Shiny app provides an interactive interface to explore a synthetic dataset containing 50 rows and 5 columns:

- **ID**: Categorical variable with 4 levels (A, B, C, D)
- **PresAbs**: Binary variable indicating presence (1) or absence (0)
- **slope**: Continuous variable ranging from 0 to 100
- **tree_count**: Integer variable representing the count of trees (0 or greater)
- **elevation**: Continuous variable representing elevation (100 to 1000)

## Features

The app consists of two main pages:

1. **About Page**: Provides information about the dataset and displays a summary of the data
2. **Data Exploration Page**: Contains four interactive plots:
   - Distribution of ID categories
   - Presence/Absence by ID
   - Slope distribution histogram
   - Tree Count vs Slope scatter plot

## Requirements

- R (>= 4.0)
- R packages:
  - shiny
  - ggplot2
  - dplyr

## Installation

Install the required R packages:

```r
install.packages(c("shiny", "ggplot2", "dplyr"))
```

Or on Ubuntu/Debian systems:

```bash
sudo apt-get install r-cran-shiny r-cran-ggplot2 r-cran-dplyr
```

## Usage

To run the app:

```r
# In R console from the app directory
shiny::runApp()
```

Or from command line:

```bash
R -e "shiny::runApp()"
```

The app will open in your default web browser.
