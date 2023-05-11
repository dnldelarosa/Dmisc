test_that("describe", {
  local_edition(3)

  expect_snapshot(describe(mtcars[[1]]))
  expect_snapshot(describe(mtcars, digits = 2))
  withr::with_package('tibble', {
  expect_snapshot(describe(mtcars, digits = 2, t = F))
  })
  suppressWarnings({
    withr::with_package("flextable", {
      expect_snapshot(describe(mtcars, digits = 2, t = F, flextable = T))
      expect_snapshot(describe(mtcars, digits = 2, t = F, flextable = T, ft_args = list(cwidth = 2)))
      expect_snapshot(describe(mtcars, digits = 2, t = F, flextable = T, ft_args = list(cwidth = 2), maxsum = 2))
    })
  })

  #new_lib <- tempfile()
  #dir.create(new_lib)
  #withr::with_libpaths(new = new_lib, {
  #  print(new_lib)
  #  print(.libPaths())
  #  expect_error(describe(mtcars, digits = 2, t = F))
  #  expect_error(describe(mtcars, digits = 2, t = F, flextable = T))
  #})
  #unlink(new_lib, recursive = TRUE)
})
