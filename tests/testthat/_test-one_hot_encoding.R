test_that("one-hot-encoding tests", {
  local_edition(3)
  expect_snapshot(
    one_hot_encoding(warpbreaks)
  )
  expect_snapshot(
    one_hot_encoding(warpbreaks, variables = "tension")
  )
  expect_snapshot(
    one_hot_encoding(warpbreaks, drop_one = TRUE)
  )
})
