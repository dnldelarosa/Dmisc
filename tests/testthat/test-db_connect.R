test_that("db_connect", {
  expect_error(
    db_connect()
  )
  expect_error(
    db_connect(db_name = "enft1")
  )
})
