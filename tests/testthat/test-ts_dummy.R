test_that("ts_dummy", {
  local_edition(3)
  expect_snapshot(
    ts_dummy(
      dates = 2005,
      start = 2000,
      end = 2021
      )
    )
  expect_snapshot(
    ts_dummy(
      dates = c(2005, 3),
      start = 2000,
      end = c(2021, 4),
      frequency = 4
      )
    )
  expect_snapshot(
    ts_dummy(
      dates = data.frame(c(2005, 2006), c(8, 11)),
      start = 2000,
      end = c(2021, 12),
      frequency = 12
      )
    )
})
