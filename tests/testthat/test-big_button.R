test_that("big_button", {
  local_edition(3)
  expect_snapshot(big_button("Get started", ""))
  # test default parameters
  expect_snapshot(big_button(text = "Get started", href = "./articles/Dmisc.html"))
  # test custom width and height
  expect_snapshot(big_button(text = "Get started", href = "./articles/Dmisc.html", width = 200, height = 50))
  # test custom font size and family
  expect_snapshot(big_button(text = "Get started", href = "./articles/Dmisc.html", font_size = 24, font_family = "Arial"))
  # test custom background color
  expect_snapshot(big_button(text = "Get started", href = "./articles/Dmisc.html", bg_color = "#000000"))
  # test custom styles
  expect_snapshot(big_button(text = "Get started", href = "./articles/Dmisc.html", styles = "text-align: center;"))
})
