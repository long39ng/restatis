
<!-- README.md is generated from README.Rmd. Please edit that file -->

# restatis

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/restatis)](https://CRAN.R-project.org/package=restatis)
[![R-CMD-check](https://github.com/long39ng/restatis/workflows/R-CMD-check/badge.svg)](https://github.com/long39ng/restatis/actions)
<!-- badges: end -->

{restatis} is a wrapper around the RESTful API that provides access to
data from the [Federal Statistical Office of Germany
(Destatis)](https://www-genesis.destatis.de/).

## Installation

You can install the development version of {restatis} from GitHub:

``` r
remotes::install_github("long39ng/restatis")
```

## Usage

To use most functionality of the package, you need to have an account at
<https://www-genesis.destatis.de> and store your username and password
using `set_login_data()`.[1] You can run `login_check()` to see if you
can access the API with the saved credentials.

[1] {restatis} relies on the [keyring
package](https://github.com/r-lib/keyring) to store and access
credentials on your computer.
