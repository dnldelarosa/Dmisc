test_that("dend_to_list works", {

  # Crea un objeto dendrograma de ejemplo
  dend <- as.dendrogram(hclust(dist(USArrests), "ave"))

  # Prueba la función dend_to_list con el dendrograma de ejemplo
  result <- dend_to_list(dend)

  #expect_true(all(sapply(result, function(x) {
  #  !is.list(x) || is.character(x) && length(x) == 1
  #})))

  # Verifica que la longitud del resultado sea igual a la longitud del dendrograma
  expect_equal(length(result), length(dend))

  # Crea un objeto dendrograma más complejo
  dend2 <- as.dendrogram(hclust(dist(mtcars), "ward.D2"))

  # Prueba la función dend_to_list con el segundo dendrograma
  result2 <- dend_to_list(dend2)

  # Verifica que los valores en el resultado sean etiquetas de hojas o sublistas
  expect_true(all(sapply(result2, function(x) {
    is.list(x) || (is.character(x) && length(x) == 1)
  })))
})

test_that("dend_to_list returns a nested list", {
  dend <- as.dendrogram(hclust(dist(mtcars), "ward.D2"))
  result <- dend_to_list(dend)
  expect_true(is.list(result))
  expect_true(all(sapply(result, function(x) is.list(x) || is.character(x))))
})



test_that("dend_to_df returns a data frame", {
  dend <- as.dendrogram(hclust(dist(mtcars), "ward.D2"))
  result <- dend_to_df(dend)
  expect_true(is.data.frame(result))
})

#test_that("dend_to_df has the correct number of rows", {
#  dend <- as.dendrogram(hclust(dist(mtcars), "ward.D2"))
#  result <- dend_to_df(dend)
#  expect_equal(nrow(result), length(dend))
#})

#test_that("dend_to_df has the correct number of columns", {
#  dend <- as.dendrogram(hclust(dist(mtcars), "ward.D2"))
#  result <- dend_to_df(dend)
#  expect_equal(ncol(result), 2 + max(stringr::str_count(labels(dend), "[\\.]")))
#})

test_that("dend_to_df contains correct values", {
  dend <- as.dendrogram(hclust(dist(mtcars), "ward.D2"))
  result <- dend_to_df(dend)
  expect_equal(result[["label"]], labels(dend))
})



#test_that("dend_to_df returns a data frame", {
#  dend <- as.dendrogram(hclust(dist(mtcars)))
#  df <- dend_to_df(dend)
#
#  expect_is(df, "data.frame")
#  expect_equal(ncol(df), length(attributes(dend)$order) + 1)
#})

#test_that("dend_to_df returns a data frame with correct structure", {
#  dend <- as.dendrogram(hclust(dist(mtcars)))
#  df <- dend_to_df(dend)
#
#  expect_equal(colnames(df)[1], "label")
#  expect_equal(colnames(df)[-1], attributes(dend)$order)
#})


#test_that("find_labels_path returns a character vector", {
#  dend_df <- dend_to_df(hclust(dist(mtcars), "average"))
#  result <- find_labels_path(dend_df, c("Mazda RX4", "Datsun 710"), sep = ".", pre = 2)
#  expect_is(result, "character")
#})

#test_that("find_labels_path correctly separates the labels", {
#  dend_df <- dend_to_df(hclust(dist(mtcars), "average"))
#  result <- find_labels_path(dend_df, c("Mazda RX4", "Datsun 710"), sep = ".", pre = 2)
#  expect_equal(result, c("5.3", "3.1"))
#})

#test_that("find_labels_path correctly handles the .pre argument", {
#  dend_df <- dend_to_df(hclust(dist(mtcars), "average"))
#  result <- find_labels_path(dend_df, c("Mazda RX4", "Datsun 710"), sep = ".", pre = 1)
#  expect_equal(result, c("53", "31"))
#})

#test_that("find_labels_path returns the correct path when multiple labels are present", {
#  dend_df <- dend_to_df(hclust(dist(mtcars), "average"))
#  result <- find_labels_path(dend_df, c("Mazda RX4", "Datsun 710", "Hornet 4 Drive"), sep = ".", pre = 2)
#  expect_equal(result, c("5.3", "3.1", "8.7"))
#})
