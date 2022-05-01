test_that("cut3", {
  local_edition(3)
  tbl <- data.frame(
    age = 1:10,
    freq = c(5,5,5,4,3,3,5,3,4,5)
  )
  f1 <- function(x){
    "a2"
  }
  expect_snapshot(cut3(tbl, var_name = "age", breaks = 2))
  expect_snapshot(cut3(tbl, var_name = "age", breaks = c(0, 5, 10)))
  expect_snapshot(cut3(tbl, var_name = "age", breaks = c(2, 5, 8)))
  expect_snapshot(cut3(tbl, var_name = "age", breaks = quantile))
  expect_snapshot(cut3(tbl, var_name = "age", breaks = quantile, include.lowest = T))
  expect_snapshot(cut3(tbl, var_name = "age", breaks = c(0, quantile)))
  expect_snapshot(cut3(tbl, var_name = "age", breaks = 2, labels = F))
  expect_error(cut3(tbl, var_name = "age", breaks = "2"))
  expect_snapshot(cut3(tbl, var_name = "age", breaks = 2, labels = c("Menor o igual que 5", "Mayor a 5")))
  expect_snapshot(cut3(tbl, var_name = "age", breaks = 2, groups = "sex"))
})
