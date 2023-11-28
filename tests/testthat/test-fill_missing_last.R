test_that("filling works", {
  expect_equal(fill_missing_last(c(NA, 1, 2, NA)), c(2, 1, 2, 2))
})
