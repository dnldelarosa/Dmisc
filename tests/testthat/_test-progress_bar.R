test_that("progress_bar returns expected output with 0 progress", {
  local_edition(3)
  expect_snapshot(progress_bar(0))
})

test_that("progress_bar returns expected output with 25 progress", {
  local_edition(3)
  expect_snapshot(progress_bar(25))
})

test_that("progress_bar returns expected output with 50 progress", {
  local_edition(3)
  expect_snapshot(progress_bar(50))
})

test_that("progress_bar returns expected output with 75 progress", {
  local_edition(3)
  expect_snapshot(progress_bar(75))
})

test_that("progress_bar returns expected output with 100 progress", {
  local_edition(3)
  expect_snapshot(progress_bar(100))
})

test_that("progress_bar returns expected output with progress as character", {
  local_edition(3)
  expect_error(progress_bar("50%"))
})

test_that("progress_bar returns expected output with non-default font_size", {
  local_edition(3)
  expect_snapshot(progress_bar(50, font_size = 20))
})

test_that("progress_bar returns expected output with non-default font_family", {
  local_edition(3)
  expect_snapshot(progress_bar(50, font_family = "Arial"))
})

test_that("progress_bar returns expected output with non-default bg_color", {
  local_edition(3)
  expect_snapshot(progress_bar(50, bg_color = "#00ff00"))
})

test_that("progress_bar returns expected output with non-default styles", {
  local_edition(3)
  expect_snapshot(progress_bar(50, styles = "display: inline-block;"))
})
