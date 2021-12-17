test_that("big_button", {
  local_edition(3)
  expect_snapshot(big_button("Get started", ""))
})
