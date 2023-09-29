# README #

  <!-- badges: start -->
  [![R-CMD-check](https://github.com/vusaverse/vvfiller/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/vusaverse/vvfiller/actions/workflows/R-CMD-check.yaml)
  
  [![CodeFactor](https://www.codefactor.io/repository/github/vusaverse/vvfiller/badge)](https://www.codefactor.io/repository/github/vusaverse/vvfiller)
[![CRAN status](https://www.r-pkg.org/badges/version/vvfiller)](https://CRAN.R-project.org/package=vvfiller/)
<a href="https://diffify.com/R/vvfiller" target="_blank"><img src="https://diffify.com/diffify-badge.svg" alt="The diffify page for the R package vvfiller" style="width: 100px; max-width: 100%;"></a>
[![CRAN last month downloads](https://cranlogs.r-pkg.org/badges/last-month/vvfiller?color=green/)](https://cran.r-project.org/package=vvfiller/)
[![CRAN last month downloads](https://cranlogs.r-pkg.org/badges/grand-total/vvfiller?color=green/)](https://cran.r-project.org/package=vvfiller/)
  <!-- badges: end -->

# vvfiller <a href='https://github.com/vusaverse/vvfiller'><img src='man/figures/hex-vvfiller.png' align="right" height="138.5" /></a>

The vvfiller package is designed to assist with data imputation within the scope of Student Analytics. It provides a collection of functions that can be used to fill missing or skewed data points in R. This package aims to make the imputation process more efficient and accurate, enabling users to handle incomplete datasets effectively.
Purpose

Missing or skewed data can present significant challenges when performing data analysis and modeling. The vvfiller package aims to address this issue by providing various imputation functions that allow users to handle missing values and data anomalies. These functions are designed to help users fill the gaps in their datasets in a way that aligns with the specific requirements of Student Analytics.

## Installation

To install the vvfiller package, you can use either the CRAN repository or install it directly from the GitHub repository.

To install the package sirectly from CRAN use:

```{r}
install.packages("vvfiller")
library(vvfiller)
```

Install from GitHub using devtools:

```{r}
library(devtools)
devtools::install_github("vusaverse/vvfiller")
```


## Usage

The vvfiller package provides various functions that can be used for data imputation. Here are some key functions and their descriptions:

- check_some_missing(x): Calculates a summary statistic (mean, median, mode, min, max) by group and fills missing values in a column.

- fill_value(x, value): Fills missing values in a vector x with a specific value.

- fill_vector_interval(x): Fills missing values in a vector x by linear interpolation between the nearest non-missing values.

 - fill_vector_last(x, x_na_omit): Fills missing values in a vector x with the last non-missing value. The x_na_omit argument specifies whether to omit NA values when determining the last non-missing value.

 - fill_vector_previous(x): Fills missing values in a vector x with the previous non-missing value.

For more detailed information on each function's usage and parameters, please refer to the package documentation and examples.


## Contributions

Contributions to the vvfiller package are welcome. If you encounter any issues, have suggestions for improvement, or would like to contribute new functionality, please submit a pull request or an issue to the GitHub repository.
