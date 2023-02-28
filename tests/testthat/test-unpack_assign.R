test_that("test %<...% with positional arguments", {
  c("num1", "num2") %<...% c(1, 2)
  expect_equal(num1, 1)
  expect_equal(num2, 2)
})

test_that("test %<...% with named arguments", {
  c("num1", "num2") %<...% list(num2 = 1, num1 = 2)
  expect_equal(num1, 2)
  expect_equal(num2, 1)
})

test_that("test %<...% with mixed arguments", {
  c("num1", "num2") %<...% list(2, num1 = 1)
  expect_equal(num1, 2)
  expect_equal(num2, 1)
})
