# Create a simple feature object
sf_obj <- sf::st_as_sf(mtcars, coords = c("wt", "mpg"), crs = 4326)

test_that("st_view should return an invisible sf object", {
  expect_invisible(st_view(sf_obj))
})

test_that("st_view should return an sf object with one less column than the input", {
  expect_equal(ncol(sf::st_drop_geometry(sf_obj)), ncol(st_view(sf_obj))-1)
})

test_that("st_view should have the same number of rows as the input", {
  sf_view <- st_view(sf_obj)
  expect_equal(nrow(sf_obj), nrow(sf_view))
})
