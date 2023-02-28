
# Define test data
strings <- c("A", "B", "C", "D")

# Define tests
test_that("str_c2 returns a concatenated string", {
  expect_warning(str_c2(strings))
})
