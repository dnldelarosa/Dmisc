test_that("cut3", {
  local_edition(3)
  tbl <- data.frame(
    age = 1:10,
    freq = c(5,5,5,4,3,3,5,3,4,5)
  )
  expect_snapshot(cut3(tbl, var_name = "age", breaks = 2))
  expect_snapshot(cut3(tbl, var_name = "age", breaks = c(0, 5, 10)))
  expect_snapshot(cut3(tbl, var_name = "age", breaks = c(2, 5, 8)))
  expect_snapshot(cut3(tbl, var_name = "age", breaks = quantile, bf_args = list(x = tbl$age)))
  expect_snapshot(cut3(tbl, var_name = "age", breaks = quantile, bf_args = list(x = tbl$age), include.lowest = T))
  expect_snapshot(cut3(tbl, var_name = "age", breaks = c(0, quantile), bf_args = list(x = tbl$age)))
  expect_snapshot(cut3(tbl, var_name = "age", breaks = 2, labels = F))
  expect_snapshot(cut3(tbl, var_name = "age", breaks = 2, labels = c("Menor o igual que 5", "Mayor a 5")))
  expect_snapshot(cut3(tbl, var_name = "age", breaks = 2, groups = "sex"))
})
