test_that("describe", {
  local_edition(3)
  expect_snapshot(describe(mtcars[[1]]))
  expect_snapshot(describe(mtcars, digits = 2))
  expect_snapshot(describe(mtcars, digits = 2, t = F))
  expect_snapshot(describe(mtcars, digits = 2, t = F, flextable = T))
  expect_snapshot(describe(mtcars, digits = 2, t = F, flextable = T, ft_args = list(cwidth = 2)))
  expect_snapshot(describe(mtcars, digits = 2, t = F, flextable = T, ft_args = list(cwidth = 2), maxsum = 2))
})
