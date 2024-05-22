
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `hpa.setup`

<!-- badges: start -->
<!-- badges: end -->

The goal of `hpa.setup` is to get new projects setup faster that live on
remote, internetless machines!

## Installation

You can install the development version of `hpa.setup` from
[GitHub](https://github.com/) with:

``` r
remotes::install_github("healthpolicyanalysis/hpa.setup")
```

## Example

You may want to setup an analyses project on a remote computer than you
can pass files to but isn’t directly connected to the internet. To start
of the project, have a guess at which packages you’ll need and make a
setup zip with these included by using `get_setup_zip()`.

``` r
library(hpa.setup)

get_setup_zip(
  outfile = "new_proj.zip", 
  project_name = "new_analyses",
  dependencies = c("tidyverse", "targets")
)
```
