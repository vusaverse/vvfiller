test_that("It correctly fills missing values in a column by group using mean", {
  df <- data.frame(
    group_col = c("A", "A", "B", "B"),
    value = c(10, NA, 25, NA)
  )
  expected_output <- c(10, 10, 25, 25)
  result <- fill_col_with_agg_by_group(df, group = "group_col", col = "value", statistic = mean)
  expect_equal(result, expected_output)
})

test_that("It correctly fills missing values in a column by group using median", {
  df <- data.frame(
    group_col = c("A", "A", "B", "B"),
    value = c(10, NA, 25, NA)
  )
  expected_output <- c(10, 10, 25, 25)
  result <- fill_col_with_agg_by_group(df, group = "group_col", col = "value", statistic = median)
  expect_equal(result, expected_output)
})
