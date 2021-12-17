test_that("progress_bar", {
  local_edition(3)
  expect_snapshot(progress_bar(77))
})
