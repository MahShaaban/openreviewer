
# openreviewer

An interface to query the [openreview](https://openreview.net/) platform API 
from R.

**Currently, only implements `request_users` and `request_profiles`**

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
```

