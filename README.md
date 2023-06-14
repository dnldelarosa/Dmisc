
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Dmisc: Daniel miscellaneous functions

<!-- badges: start -->

[![Project Status: WIP – Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![R build
status](https://github.com/drdsdaniel/Dmisc/workflows/R-CMD-check/badge.svg)](https://github.com/drdsdaniel/Dmisc/actions)
[![Codecov test
coverage](https://codecov.io/gh/drdsdaniel/Dmisc/branch/main/graph/badge.svg)](https://codecov.io/gh/drdsdaniel/Dmisc?branch=main)
[![CRAN
status](https://www.r-pkg.org/badges/version/Dmisc)](https://CRAN.R-project.org/package=Dmisc)
<!-- badges: end -->

The Dmisc package provides a collection of versatile R functions
developed by Daniel E. de la Rosa. These are general-purpose tools, not
tied to any specific domain, aiming to aid a wide range of tasks in data
analysis and visualization.

## Code Reusability

A primary motivation behind the development of Dmisc is to facilitate
code reusability. Daniel created these functions to avoid code
repetition in his own projects. However, if an equivalent function is
found in another package with good support, the corresponding function
in Dmisc may become deprecated.

## Installation

Not yet in [CRAN](https://CRAN.R-project.org)
<!-- You can install the released version of Dmisc from [CRAN](https://CRAN.R-project.org) with: -->

<!-- ``` r -->
<!-- install.packages("Dmisc") -->
<!-- ``` -->

You can install the development version from
[GitHub](https://github.com/) with:

``` r
tryCatch(
  library(remotes),
  error = function(e){
    install.packages('remotes')
  }
)
remotes::install_github("drdsdaniel/Dmisc")
```

## Roadmap

- [ ] Add weight support to the `cut3` function.

## Functions

Browse the package site:
[Dmisc](https://drdsdaniel.github.io/Dmisc/reference/index.html)

## Contributing

Have a feedback or want to contribute?

Please take a look at the [contributing
guidelines](https://drdsdaniel.github.io/Dmisc/CONTRIBUTING.html) before
filing an issue or pull request.

Please note that the `Dmisc` project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
