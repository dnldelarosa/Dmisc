test_that("insertHTML", {
  local_edition(3)
  expect_warning(insertHTML(path = "", name = "insertHtml2.html"))
  expect_snapshot(insertHTML(file = test_path("insertHtml.html")))
  expect_snapshot(insertHTML(file = test_path("insertHtml_sc.html")))
})
