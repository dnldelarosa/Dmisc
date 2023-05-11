test_that("cut3", {
  local_edition(3)
  tbl <- data.frame(
    age = 1:10,
    freq = c(5,5,5,4,3,3,5,3,4,5),
    sex = rep(c("F", "M"), each = 5)
  )
  f1 <- function(x){
    "a2"
  }
  expect_snapshot(cut3(tbl, var_name = "age", breaks = 2))
  expect_snapshot(cut3(tbl, var_name = "age", breaks = c(0, 5, 10)))
  expect_snapshot(cut3(tbl, var_name = "age", breaks = c(5), .inf = TRUE))
  expect_snapshot(cut3(tbl, var_name = "age", breaks = c(2, 5, 8)))
  expect_snapshot(cut3(tbl, var_name = "age", breaks = c(2, 5, 8), .inf = TRUE))
  expect_snapshot(cut3(tbl, var_name = "age", breaks = stats::quantile))
  expect_snapshot(cut3(tbl, var_name = "age", breaks = stats::quantile, include.lowest = T))
  expect_snapshot(cut3(tbl, var_name = "age", breaks = stats::quantile, .inf = TRUE))
  expect_snapshot(cut3(tbl, var_name = "age", breaks = c(0, stats::quantile(tbl$age))))
  expect_snapshot(cut3(tbl, var_name = "age", breaks = stats::quantile, probs = c(0.3, 0.7)))
  expect_snapshot(cut3(tbl, var_name = "age", breaks = 2, labels = FALSE))
  expect_snapshot(cut3(tbl, var_name = "age", breaks = 2, labels = c("Menor o igual que 5", "Mayor a 5")))
  expect_snapshot(cut3(tbl, var_name = "age", breaks = 2, labels = c("low", "high")))
  expect_snapshot(cut3(tbl, var_name = "age", breaks = 2, groups = "sex"))
  #expect_warning(cut3(tbl, var_name = "age", breaks = c(1, 2)))
  #expect_warning(cut3(tbl, var_name = "age", breaks = c(0, 10, 20)))
  expect_snapshot(cut3(tbl, var_name = "age", breaks = function(x) { quantile(x, probs = c(0.3, 0.7)) }))
  expect_snapshot(cut3(tbl, var_name = "age", breaks = function(x) { quantile(x, probs = c(0.3, 0.7)) }, .inf = TRUE))
  expect_snapshot(cut3(tbl, var_name = "age", breaks = 2, groups = "sex"))
  expect_error(cut3(tbl, var_name = "age", breaks = "2"))
  expect_error(cut3(tbl, var_name = "age", breaks = c(2, 4, "x")))
  expect_error(cut3(tbl, var_name = "age", breaks = 0))
  expect_error(cut3(tbl, var_name = "age", breaks = list()))
  expect_error(cut3(tbl, var_name = "age", breaks = 2, groups = "nonexistent"))
})
