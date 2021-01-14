
# openreviewer

An interface to query the [openreview](https://openreview.net/) platform 
[API](https://api.openreview.net/) from R.

The goal of this package is to 

1. Use R syntax to make queries
2. Handel errors
3. Return usable objects "tidy"

TODO:

1. Work with complex queries and anticipate errors
2. Tidy and/or simplify the returned content
3. Document the API parameters and write common use cases

## Installation

Install from GitHub using `remotes`

``` r
remotes::install_github("MahShaaban/openreviewer")
```

## Example

This is a basic example which shows how to query the API for a user profile 
using an email address.

``` r
# load the library
library(openreviewer)

# make a query
prof <- request_profiles(email = 'mahshaaban@gnu.ac.kr')

# tidy the output
tidyjson::spread_all(prof$content$profiles)
#> # A tbl_json: 1 x 14 tibble with a "JSON" attribute
#>   ..JSON document.id id    invitation active password  tcdate  tmdate tauthor
#>   <chr>        <int> <chr> <chr>      <lgl>  <lgl>      <dbl>   <dbl> <chr>  
#> 1 "{\"i…           1 ~Mah… ~/-/profi… TRUE   TRUE     1.60e12 1.60e12 OpenRe…
#> # … with 5 more variables: content.preferredEmail <chr>, content.gender <chr>,
#> #   content.homepage <chr>, content.gscholar <chr>, content.orcid <chr>
```

