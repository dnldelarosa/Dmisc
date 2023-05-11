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

test_that("ts_dummy with single dates", {
  expect_identical(
    ts_dummy(dates = 2005, start = 2000, end = 2021),
    ts(0, start = 2000, end = 2021, frequency = 1)
  )
})

test_that("ts_dummy with vector of dates", {
  expect_identical(
    ts_dummy(dates = c(2005, 3), start = 2000, end = c(2021, 4), frequency = 4),
    ts(c(0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0), start = c(2000, 1), frequency = 4)
  )
})

test_that("ts_dummy with dataframe of dates", {
  expect_identical(
    ts_dummy(
      dates = data.frame(c(2005, 2006), c(8, 11)),
      start = 2000,
      end = c(2021, 12),
      frequency = 12
    ),
    ts(c(rep(0, 8), 1, rep(0, 3), 1, rep(0, 2), 1, rep(0, 7)), start = c(2000, 1), frequency = 12)
  )
})
