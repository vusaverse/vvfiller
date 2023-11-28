test_that("Impute missing values", {
  data <- data.frame(
    var = c(1,2,3,NA,NA),
    year_column = c(2014,2014,2014,2014,2014)
  )

  result <- na_impute_median(data, "var", 2014, "year_column")
  expect_equal(sum(is.na(result$var_imputed)), 0)
})

test_that("Check addition of missing value indicator", {
  test_data <- data.frame(
    var = c(1, 2, NA, NA),
    year_column = c(2014, 2014, 2014, 2014)
  )

  result <- na_impute_median(test_data, "var", 2014, "year_column")
  expect_true("NA_ind_var" %in% names(result))
})

test_that("Check if median is correct", {
  test_data <- data.frame(
    var = c(1, 2, 5, 6, NA, NA, NA),
    year_column = c(2014, 2014, 2014, 2014, 2015, 2015, 2017)
  )

  imputed_data <- na_impute_median(test_data, "var", 2014, "year_column")

  expected_median_2014 <- median(test_data$var[test_data$year_column == 2014], na.rm = TRUE)
  actual_median_2014 <- median(imputed_data$var_imputed[imputed_data$year_column == 2014], na.rm = TRUE)

  expect_equal(actual_median_2014, expected_median_2014)
})
