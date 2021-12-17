test_that("train-test-split tests", {
  local_edition(3)
  tts <- train_test_split(warpbreaks)
  expect_snapshot(str(tts))
  expect_snapshot(train_split(tts))
  expect_snapshot(test_split(tts))
  expect_snapshot(valid_split(train_test_split(warpbreaks, valid_split = TRUE)))
})
