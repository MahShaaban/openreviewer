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
#'
#' @export
request_users <- function(id, password) {
    # parse parameters and convert to JSON
    params <- .make_params(match.call())
    params <- toJSON(params, auto_unbox = TRUE)
    .post_request('login', params)
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
#' @export
request_profiles <- function(id, email, first, middle, last, group) {
    params <- .make_params(match.call())
    .get_request(type = 'profiles', params)
}

#' Request groups
#'
#' @inheritParams request_users
#' @param regrex A string
#' @param member A string
#' @param signature A string
#' @param limit An integer
#' @param offset An integer
#'
#' @return An S3 object of class openreview.
#' \describe{
#'     \item{url}{A string of the url part of the request}
#'     \item{response}{A list. The return of the GET call}
#'     \item{content}{A list. The return of the content call}
#' }
#'
#' @examples
#' request_groups(id = 'bioconductor.org')
#'
#' @export
request_groups <- function(id, regrex, member, signature, limit, offset) {
    params <- .make_params(match.call())
    .get_request(type = 'groups', params)
}

#' Request notes
#'
#' @inheritParams request_users
#' @inheritParams request_groups
#' @param invitation A string
#' @param forum A string
#' @param number A string
#' @param trash A logical
#' @param content.authorids A string
#' @param content.pdf A string
#' @param content.paperhash A string
#' @param details A string
#'
#' @return An S3 object of class openreview.
#' \describe{
#'     \item{url}{A string of the url part of the request}
#'     \item{response}{A list. The return of the GET call}
#'     \item{content}{A list. The return of the content call}
#' }
#'
#' @examples
#' # notes on this submission https://openreview.net/forum?id=B1gabhRcYX
#' request_notes(id = 'B1gabhRcYX')
#'
#' @export
request_notes <- function(id, invitation, forum, number, trash,
                         content.authorids, content.pdf, content.paperhash,
                         details, limit, offset) {
    params <- .make_params(match.call())
    .get_request(type = 'notes', params)
}

#' Request invitations
#'
#' @inheritParams request_users
#' @inheritParams request_groups
#' @param replyForum A string
#' @param replyInvitation A string
#' @param minduedate A string
#' @param tags A logical
#'
#' @return An S3 object of class openreview.
#' \describe{
#'     \item{url}{A string of the url part of the request}
#'     \item{response}{A list. The return of the GET call}
#'     \item{content}{A list. The return of the content call}
#' }
#'
#' @export
request_invitations <- function(id, regrex, replyForum, replyInvitation,
                                minduedate, tags, limit, offset) {
    params <- .make_params(match.call())
    .get_request(type = 'invitations', params)
}

#' Request tags
#'
#' @inheritParams request_users
#' @inheritParams request_groups
#' @inheritParams request_notes
#' @param invitation A string
#' @param replyto A string
#' @param deleted A logical
#'
#' @return An S3 object of class openreview.
#' \describe{
#'     \item{url}{A string of the url part of the request}
#'     \item{response}{A list. The return of the GET call}
#'     \item{content}{A list. The return of the content call}
#' }
#'
#' @examples
#' request_tags(id = 'mahshaaban@gnu.ac.kr')
#'
#' @export
request_tags <- function(id, invitation, forum, replyto, deleted, limit,
                         offset) {
    params <- .make_params(match.call())
    .get_request(type = 'tags', params)
}

.make_url <- function(type, server = "https://api.openreview.net") {
    if (missing(type)) stop("type must be provided.")
    paste(server, type, sep = '/')
}

.make_params <- function(args) {
    ## TODO: find a better way to parse only arguments
    ## TODO: handle different types of arguments
    as.list(args)[-1]
}

#' @importFrom httr POST accept_json content_type_json content http_error has_content status_code
.post_request <- function(type, params) {
    # make url
    url <- .make_url(type)

    # make request
    res <- POST(url = url,
                body = params,
                accept_json(),
                content_type_json())

    # if error, return status code and error message
    if(http_error(res)) {
        stop(sprintf("API request failed with code %s and the following error/s
                     were returnd: %s",
                     status_code(res),
                     paste(unlist(content(res, 'parsed'), use.names = FALSE),
                           collapse = '. ')),
             call. = FALSE)
    }

    # parse content
    if(has_content(res)) {
        cont <- content(res)
    } else {
        # or stop
        stop("Return has no content.")
    }

    # return an object with url, response and cont
    structure(
        list(url = url,
             response = res,
             content = cont),
        class = 'openreview'
    )
}

#' @importFrom httr GET content modify_url http_error has_content status_code
.get_request <- function(type, params) {
    # make and modify url by adding query
    url <- .make_url(type)
    url <- modify_url(url, query = params)

    # make request
    res <- GET(url)

    # if error, return status code and error message
    if(http_error(res)) {
        stop(sprintf("API request failed with code %s and the following error/s
                     were returnd: %s",
                     status_code(res),
                     paste(unlist(content(res, 'parsed'), use.names = FALSE),
                           collapse = '. ')),
             call. = FALSE)
    }

    # parse content
    if(has_content(res)) {
        cont <- content(res)
    } else {
        # or stop
        stop("Return has no content.")
    }

    # return an object with url, response and cont
    structure(
        list(url = url,
             response = res,
             content = cont),
        class = 'openreview'
    )
}
