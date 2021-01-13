#' Request personal profile
#'
#' @param id A string.
#' @param password A string
#'
#' @return An S3 object of class openreview.
#' \describe{
#'     \item{url}{A string of the url part of the request}
#'     \item{response}{A list. The return of the POST call}
#'     \item{content}{A list. The return of the content call}
#' }
#'
#' @importFrom jsonlite toJSON
#' @importFrom httr POST accept_json content_type_json content
#'
#' @export
request_users <- function(id, password) {
    # define server and type of request
    server <- "https://api.openreview.net"
    type <- "login"

    url <- paste(server, type, sep = '/')

    # parse parameters
    ## TODO: find a better way to parse only args
    params <- as.list(match.call())[-1]

    # convert list to JSON
    body <- toJSON(params, auto_unbox = TRUE)

    # make request
    res <- POST(url = url,
                body = body,
                accept_json(),
                content_type_json())

    # parse content
    cont <- content(res)

    # TODO: modify the content before returning. For example an S3 object

    # return an object with url, response and cont
    structure(
        list(url = url,
             response = res,
             content = cont),
        class = 'openreview'
    )
}

#' Request a profile
#'
#' @param email A string
#' @param first A string
#' @param middle A string
#' @param last A string
#' @param group A string
#' @inheritParams request_users
#'
#' @return An S3 object of class openreview.
#' \describe{
#'     \item{url}{A string of the url part of the request}
#'     \item{response}{A list. The return of the GET call}
#'     \item{content}{A list. The return of the content call}
#' }
#'
#' @examples
#' request_profiles(email = 'mahshaaban@gnu.ac.kr')
#'
#' @importFrom httr GET content modify_url
#'
#' @export
request_profiles <- function(id, email, first, middle, last, group) {
    # define server and type of request
    server <- "https://api.openreview.net"
    type <- "profiles"

    url <- paste(server, type, sep = '/')

    # parse parameters
    ## TODO: find a better way to parse only args
    params <- as.list(match.call())[-1]

    # modify url by adding query
    url <- modify_url(url, query = params)

    # make request
    res <- GET(url)

    # parse content
    cont <- content(res)

    # TODO: modify the content before returning. For example an S3 object

    # return an object with url, parameters, response and cont
    structure(
        list(url = url,
             response = res,
             content = cont),
        class = 'openreview'
    )
}
