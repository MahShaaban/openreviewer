context("Test requests")

test_that("request_users works", {
    # add <email> as id and <password>
    # curl -X POST "https://api.openreview.net/login"
    #     -H "accept: application/json"
    #     -H "Content-Type: application/json"
    #     -d "{\"id\":\"<email>\",\"password\":\"<pasword>\"}"

    # ursr <- request_users()
})

test_that("request_profiles works", {
    # add <email>
    # curl -X GET "https://api.openreview.net/profiles?email=<email>"
    #     -H "accept: application/json"

    prof <- request_profiles(email = 'mahshaaban@gnu.ac.kr')

    expect_s3_class(prof, 'openreview')
    expect_length(prof, 3)
})
