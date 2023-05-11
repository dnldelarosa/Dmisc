# Convert a Dendrogram Object to a List
# `r lifecycle::badge("experimental")`
#
# This function takes as input a dendrogram object, and returns a nested list,
# where each node in the dendrogram is represented as a list in the returned list.
# If a node is a leaf node, it is represented as a character vector of length one,
# containing the label of the leaf node.
#
# @param dend a dendrogram object
#
# @return a nested list, where each node in the dendrogram is represented as a
# list in the returned list. If a node is a leaf node, it is represented as a
# character vector of length one, containing the label of the leaf node.
#
# @examples
# \dontrun{
# # Create a dendrogram object
# dend <- as.dendrogram(hclust(dist(USArrests), "ave"))
#
# # Convert the dendrogram to a list
# dend_to_list(dend)
# }
#
# 
dend_to_list <- function(dend){
  res <- list()
  for (br in seq_along(dend)) {
    len <- length(dend[[br]])
    if(len > 1){
      res[[as.character(br)]] <- dend_to_list(dend[[br]])
    } else {
      lab <- labels(dend[[br]])
      if(is.null(lab)){
        res[[as.character(br)]] <- dend_to_list(dend[[br]])
      } else {
        res[[as.character(br)]] <- lab
      }
    }
  }
  res
}



# dend_to_df: Transform a dendrogram into a data frame
# `r lifecycle::badge("experimental")`
#
# This function takes a dendrogram object and converts it into a data frame.
# The resulting data frame has columns representing each level of the dendrogram
# and the values representing the label for each leaf.
#
# @param dend A dendrogram object.
#
# @return A data frame with one row for each leaf in the dendrogram, and columns
# representing each level of the dendrogram with values representing the label
# for each leaf.
#
# @examples
# \dontrun{
# # create example dendrogram
# dend <- as.dendrogram(hclust(dist(USArrests), "ave"))
#
# # use the function
# df <- dend_to_df(dend)
#}
# 
dend_to_df <- function(dend){
  N1 <- NULL
  name <- NULL
  dend |>
    dend_to_list() %>%
    as.data.frame() %>%
    tidyr::pivot_longer(dplyr::everything(), values_to = "label") -> res
  mpoints <- max(stringr::str_count(res[["name"]], "[\\.]"))
  res %>%
    tidyr::separate(name, into = paste0("N", 1:(mpoints+1)), sep = "\\.", fill = "right") %>%
    dplyr::mutate(N1 = stringr::str_remove(N1, "X")) %>%
    dplyr::mutate(dplyr::across(dplyr::starts_with("N"), as.numeric)) %>%
    dplyr::mutate(dplyr::across(dplyr::starts_with("N"), ~tidyr::replace_na(.x, 0)))
}


# Find Label Node
# `r lifecycle::badge("experimental")`
#
# This function takes a dendrogram data frame dend_df, a label .label, and a
# node number node_num, and returns the node number corresponding to the provided
# label. If node_num is provided, the function returns only the specified node
# number. If node_num is not provided, the function returns all node numbers
# corresponding to the provided label.
#
# @param dend_df A data frame that represents a dendrogram.
# @param .label The label for which to find the node number(s).
# @param node_num The node number to return (optional).
#
# @return A numeric value or a vector of numeric values, depending on whether
# node_num is provided.
#
# 
#
# @examples
# \dontrun{
# dend_df <- dend_to_df(as.dendrogram(hclust(dist(mtcars))))
#
# # Example usage
# find_label_node(dend_df, "label1")
# find_label_node(dend_df, "label1", node_num = 1)
#
# find_label_node(dend_df, "Mazda RX4")
# # returns [1] 5 5 5 5 5
#
# find_label_node(dend_df, "Datsun 710")
# # returns [1] 2 2 2 2 2
#
# find_label_node(dend_df, "Mazda RX4 Wag", node_num = 1)
# # returns 6
# }
find_label_node <- function(dend_df, .label, node_num = NULL){
  label <- NULL
  if (!requireNamespace("tibble", quietly = TRUE)) {
    stop("The tibble package is required to use this function. Please install it using install.packages(\"tibble\")")
  }
  dend_df %>%
    dplyr::filter(label == .label) %>%
    dplyr::select(-label) %>%
    tidyr::pivot_longer(dplyr::everything()) %>%
    tibble::deframe() -> res
  if(!is.null(node_num)){
    res[[node_num]]
  } else {
    res
  }
}


# Find Labels Path
# `r lifecycle::badge("experimental")`
#
# @param dend_df A data frame representing the dendrogram
# @param .label The labels of the nodes to be found
# @param .sep The separator for the path elements
# @param .pre The number of characters to remove from the end of the path elements
#
# @return A character vector of the paths to the nodes with the specified labels
# 
#
# @examples
# \dontrun{
# dend <- as.dendrogram(hclust(dist(USArrests), "ave"))
#
# # Convert dendrogram to dataframe
# dend_df <- dend_to_df(dend)
#
# # Find the path to node with label "Volvo 142E"
# find_labels_path(dend_df, "Volvo 142E", .sep = ".", .pre = 1)
# #> [1] "3.3.8"
#
# # Find the path to nodes with labels "Volvo 142E" y "Honda Civic"
# find_labels_path(dend_df, c("Volvo 142E", "Honda Civic"), .sep = ".", .pre = 1)
# #> [1] "3.3.8" "2.6.11"
# }
find_labels_path <- function(dend_df, .label, .sep = "", .pre = 1){
  label <- NULL
  path <- NULL
  . <- NULL
  dend_df %>%
    tidyr::unite("path", dplyr::starts_with("N"), sep = .sep) %>%
    dplyr::filter(label %in% .label) %>%
    dplyr::mutate(path = stringr::str_remove_all(path, "0+$")) %>%
    dplyr::mutate(path = stringr::str_sub(path, 1, -(.pre+1))) %>%
    .[["path"]]
}
