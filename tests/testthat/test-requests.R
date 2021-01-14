context("Test requests")

test_that("request_users works", {
    # ursr <- request_users(id, password)
    #
    # expect_s3_class(ursr, 'openreview')
    # expect_length(ursr, 3)
})

test_that("request_profiles works", {
    prof <- request_profiles(email = 'mahshaaban@gnu.ac.kr')

    expect_s3_class(prof, 'openreview')
    expect_length(prof, 3)
})

test_that("request_groups works", {
    groups <- request_groups(id = 'mahshaaban@gnu.ac.kr')

    expect_s3_class(groups, 'openreview')
    expect_length(groups, 3)
})

test_that("request_notes works", {
    notes <- request_notes(id = 'mahshaaban@gnu.ac.kr')

    expect_s3_class(notes, 'openreview')
    expect_length(notes, 3)
})

test_that("request_invitations works", {
    invit <- request_invitations(id = 'mahshaaban@gnu.ac.kr')

    expect_s3_class(invit, 'openreview')
    expect_length(invit, 3)
})

test_that("request_tags works", {
    tags <- request_tags(id = 'mahshaaban@gnu.ac.kr')

    expect_s3_class(tags, 'openreview')
    expect_length(tags, 3)
})


