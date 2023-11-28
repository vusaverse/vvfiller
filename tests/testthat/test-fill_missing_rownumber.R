test_that("no missing values", {
  expect_equal(fill_missing_rownumber(c(1,2,3,4)), c(1,2,3,4))
})

test_that("all values missing", {
  expect_equal(fill_missing_rownumber(c(NA,NA,NA)), c(NA,NA,NA))
})

test_that("missing values but no need for imputation", {
  expect_equal(fill_missing_rownumber(c(5,NA,7,9)), c(5,NA,7,9))
})

test_that("missing values with need for imputation", {
  expect_equal(fill_missing_rownumber(c(NA,4,NA,NA)), c(NA,4,5,6))
})

test_that("negative values and missing values", {
  expect_equal(fill_missing_rownumber(c(NA,-2,NA,NA,5)), c(NA,-2,NA,NA,5))
})

test_that("large sequence of missing values", {
  expect_equal(fill_missing_rownumber(rep(NA,10)), c(NA,NA,NA,NA,NA,NA,NA,NA,NA,NA))
})

test_that("positive and negative values, needing inputation", {
  expect_equal(fill_missing_rownumber(c(3,NA,-1,NA,NA,10)), c(3,NA,-1,NA,NA,10))
})

test_that("non-numeric input", {
  expect_equal(fill_missing_rownumber(c("a","b","c")), c("a","b","c"))
})

