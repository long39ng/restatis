
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
the “GENESIS” databases of the Federal Statistical Office of Germany
(Destatis):

-   <https://www-genesis.destatis.de>
-   <https://www.regionalstatistik.de>
-   <https://www.bildungsmonitoring.de>
-   <https://www.statistikdaten.bayern.de>
-   <https://www.landesdatenbank.nrw.de>
-   <https://genesis.sachsen-anhalt.de>

## Installation

You can install the development version of {restatis} from GitHub:

``` r
remotes::install_github("long39ng/restatis")
```

## Usage

To use most functionality of the package, you need to create an account
at the corresponding website of a GENESIS database and save your
username and password with `set_login_data()`.[1] You can run
`login_check()` to see if you can access the API with the saved
credentials.

Features of {restatis} include searching for data using keywords
(e.g. `search_statistics()`) or the GENESIS catalogue
(e.g. `catalogue_tables_by_statistic()`), retrieving data tables
(`get_table()`) and metadata about the tables as well as other objects
(e.g. `metadata_variable()`).

``` r
library(restatis)

# Set the GENESIS database you want to access via global options
options(genesis = "destatis")

search_statistics("migration")
#> <DESTATIS find/find?username=***&password=***&term=migration&category=statistics&pagelength=100&language=en>
#> # A tibble: 4 × 4
#>   Code  Content                  Cubes Information
#>   <chr> <chr>                    <chr> <chr>      
#> 1 12211 Microcensus              436   false      
#> 2 12421 Population projections   12    false      
#> 3 12521 Statistics of foreigners 98    false      
#> 4 12711 Migration statistics     46    false

# Get metadata about "Migration statistics"
metadata_statistic("12711")
#> <DESTATIS metadata/statistic?username=***&password=***&name=12711&area=free&language=en>
#> Code           12711
#> Content        Migration statistics
#> Cubes          46
#> Variables      25
#> Frequency.From 1950-01-01
#> Frequency.To   NA
#> Frequency.Type monthly
#> Updated        2021-02-17 11:46:02h

# List tables in "Migration statistics"
catalogue_tables_by_statistic("12711")
#> <DESTATIS catalogue/tables2statistic?username=***&password=***&name=12711&area=free&pagelength=100&language=en>
#> # A tibble: 16 × 3
#>    Code       Content                                          Time             
#>    <chr>      <chr>                                            <chr>            
#>  1 12711-0001 "Total migration across the borders of the Länd… 2000 to 2020     
#>  2 12711-0002 "Total migration across the borders of the Länd… 2000 to 2020     
#>  3 12711-0003 "Migration between the Länder: Germany, years, … 2000 to 2020     
#>  4 12711-0004 "Migration between the Länder: Germany, years, … 2000 to 2020     
#>  5 12711-0005 "Migration between Germany and foreign countrie… 2000 to 2020     
#>  6 12711-0006 "Migration between Germany and foreign countrie… 2000 to 2020     
#>  7 12711-0007 "Migration between Germany and foreign countrie… 2000 to 2020     
#>  8 12711-0008 "Migration between Germany and foreign countrie… 2000 to 2020     
#>  9 12711-0009 "Migration between Germany and foreign countrie… 1964 to 2020     
#> 10 12711-0010 "Migration between Germany and foreign countrie… 1964 to 2020     
#> 11 12711-0011 "Migration between Germany and foreign countrie… January 2008 to …
#> 12 12711-0020 "Total migration across the borders of the Länd… 2000 to 2020     
#> 13 12711-0021 "Migration between the Länder: Länder, years, n… 2000 to 2020     
#> 14 12711-0022 "Migration between the Länder: Land of origin, … 2000 to 2020     
#> 15 12711-0023 "Migration between Germany and foreign countrie… 2000 to 2020     
#> 16 12711-0030 "Ethnic German repatriates: Germany, years, age… 1997 to 2019

# Get the table "Migration between the Länder..."
get_table("12711-0020")
#> <DESTATIS data/tablefile?username=***&password=***&name=12711-0020&area=free&compress=false&startyear=1900&endyear=2100&language=en&format=ffcsv>
#> # A tibble: 3,213 × 20
#>    Statistik_Code Statistik_Label    Zeit_Code Zeit_Label Zeit  `1_Merkmal_Code`
#>             <dbl> <chr>              <chr>     <chr>      <chr> <chr>           
#>  1          12711 Wanderungsstatist… JAHR      Jahr       2000  DLAND           
#>  2          12711 Wanderungsstatist… JAHR      Jahr       2000  DLAND           
#>  3          12711 Wanderungsstatist… JAHR      Jahr       2000  DLAND           
#>  4          12711 Wanderungsstatist… JAHR      Jahr       2000  DLAND           
#>  5          12711 Wanderungsstatist… JAHR      Jahr       2000  DLAND           
#>  6          12711 Wanderungsstatist… JAHR      Jahr       2000  DLAND           
#>  7          12711 Wanderungsstatist… JAHR      Jahr       2000  DLAND           
#>  8          12711 Wanderungsstatist… JAHR      Jahr       2000  DLAND           
#>  9          12711 Wanderungsstatist… JAHR      Jahr       2000  DLAND           
#> 10          12711 Wanderungsstatist… JAHR      Jahr       2000  DLAND           
#> # … with 3,203 more rows, and 14 more variables: 1_Merkmal_Label <chr>,
#> #   1_Auspraegung_Code <chr>, 1_Auspraegung_Label <chr>, 2_Merkmal_Code <chr>,
#> #   2_Merkmal_Label <chr>, 2_Auspraegung_Code <chr>, 2_Auspraegung_Label <chr>,
#> #   3_Merkmal_Code <chr>, 3_Merkmal_Label <chr>, 3_Auspraegung_Code <chr>,
#> #   3_Auspraegung_Label <chr>, BEV013__Zuzuege__Anzahl <dbl>,
#> #   BEV014__Fortzuege__Anzahl <dbl>, BEV015__Wanderungssaldo__Anzahl <dbl>

# Get metadata about a variable in the table
metadata_variable("DLAND")
#> <DESTATIS metadata/variable?username=***&password=***&name=DLAND&area=free&language=en>
#> Code          DLAND
#> Content       Länder
#> Type          Regional
#> Values        16
#> Validity.From 1950-01-01
#> Updated       2018-10-29 17:13:39h

# List values of this variable
catalogue_values_by_variable("DLAND")
#> <DESTATIS catalogue/values2variable?username=***&password=***&name=DLAND&area=free&searchcriterion=code&sortcriterion=code&pagelength=100&language=en>
#> # A tibble: 16 × 4
#>    Code  Content                Variables Information
#>    <chr> <chr>                  <chr>     <chr>      
#>  1 08    Baden-Württemberg      8         false      
#>  2 09    Bayern                 8         false      
#>  3 11    Berlin                 10        false      
#>  4 12    Brandenburg            8         false      
#>  5 04    Bremen                 11        false      
#>  6 02    Hamburg                11        false      
#>  7 06    Hessen                 8         false      
#>  8 13    Mecklenburg-Vorpommern 11        false      
#>  9 03    Niedersachsen          9         false      
#> 10 05    Nordrhein-Westfalen    9         false      
#> 11 07    Rheinland-Pfalz        8         false      
#> 12 10    Saarland               10        false      
#> 13 14    Sachsen                8         false      
#> 14 15    Sachsen-Anhalt         10        false      
#> 15 01    Schleswig-Holstein     11        false      
#> 16 16    Thüringen              10        false
```

## Caching

{restatis} uses [memoisation](https://github.com/r-lib/memoise) to cache
query results. This means that if you call a function multiple times
with the same input, the values returned the first time are stored and
reused from the second time.

Run `reset_cache()` to forget the cached results.

Cached objects are stored in the memory and do not persist across R
sessions.

## Disclaimer

This package is in no way officially related to or endorsed by Destatis.

[1] {restatis} relies on the [keyring
package](https://github.com/r-lib/keyring) to store and access
credentials on your computer.
