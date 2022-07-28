test_that("check_some_missing works", {
  expect_equal(check_some_missing(c(1, 5, 7, 3, 0, NA, 3)), TRUE)
  expect_equal(check_some_missing(c(1, 2, 5, 7, 8, 3)), FALSE)
})
