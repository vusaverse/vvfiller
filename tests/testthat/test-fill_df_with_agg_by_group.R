test_that("fills missing values in columns by group using mean", {
  df <- data.frame(
    group_col = c("A", "A", "B", "B"),
    value1 = c(10, 15, NA, 25),
    value2 = c(20, NA, 30, 35)
  )
  expected_output <- data.frame(
    group_col = c("A", "A", "B", "B"),
    value1 = c(10, 15, NA, 25),
    value2 = c(20, NA, 30, 35),
    value1_imputed = c(10, 15, 25, 25),
    value2_imputed = c(20, 20, 30, 35)
  )
  result <- fill_df_with_agg_by_group(df, group = "group_col", columns = c("value1", "value2"), statistic = mean)
  expect_equal(result, expected_output)
})

test_that("fills missing values in columns by group using median", {
  df <- data.frame(
    group_col = c("A", "A", "B", "B"),
    value1 = c(10, 15, NA, 25),
    value2 = c(20, NA, 30, 35)
  )
  expected_output <- data.frame(
    group_col = c("A", "A", "B", "B"),
    value1 = c(10, 15, NA, 25),
    value2 = c(20, NA, 30, 35),
    value1_imputed = c(10, 15, 25, 25),
    value2_imputed = c(20, 20, 30, 35)
  )
  result <- fill_df_with_agg_by_group(df, group = "group_col", columns = c("value1", "value2"), statistic = median)
  expect_equal(result, expected_output)
})

test_that("fill_empty_group is TRUE", {
  df <- data.frame(
    group_col = c("A", "A", "B", "B"),
    value1 = c(10, 15, NA, NA),
    value2 = c(20, NA, 30, NA)
  )


  result <- fill_df_with_agg_by_group(df, group = "group_col", columns = c("value1", "value2"),
                                      overwrite_col = FALSE, statistic = mean, fill_empty_group = TRUE)

  expect_equal(result$value1, c(10, 15, NA, NA))
  expect_equal(result$value2, c(20, NA, 30, NA))
})

test_that("assign values to existing columns when overwrite_col is TRUE", {
  df <- data.frame(
    group_col = c("A", "A", "B", "B"),
    value1 = c(10, 15, NA, 25),
    value2 = c(20, NA, 30, 35)
  )

  result <- fill_df_with_agg_by_group(df, group = "group_col", columns = c("value1", "value2"),
                                      overwrite_col = TRUE, statistic = mean)

  expect_equal(result$value1, c(10, 15, 25, 25))
  expect_equal(result$value2, c(20, 20, 30, 35))
})
