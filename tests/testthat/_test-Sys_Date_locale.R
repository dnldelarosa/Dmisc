test_that("Sys_Date_locale", {
  withr::with_locale(new = c("LC_TIME" = "usa"),
                     expect_equal(Sys_Date_locale("usa"), format(Sys.Date(), "%B %d, %Y")))
  expect_equal(Sys_Date_locale("usa", format = NULL), Sys.Date())
  expect_warning(Sys_Date_locale())
})
