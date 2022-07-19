test_that("fill_value works", {
  expect_equal(fill_value(c(NA,1), 2), c(2, 1))
  expect_equal(fill_value(c(NA, NA, 5), 5), c(5, 5 ,5))
})

test_that("fill_value error", {
  expect_error(fill_value(c(NA, 0)))
})
