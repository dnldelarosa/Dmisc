
dend_to_list <- function(dend){
  res <- list()
  for (br in seq_along(dend)) {
    len <- length(dend[[br]])
    if(len > 1){
      res[[as.character(br)]] <- dend_to_list(dend[[br]])
    } else {
      res[[as.character(br)]] <- labels(dend[[br]])
    }
  }
  res
}

dend_to_df <- function(dend){
  N1 <- NULL
  name <- NULL
  dend_to_list(dend) %>%
    as.data.frame() %>%
    tidyr::pivot_longer(dplyr::everything(), values_to = "label") -> res
  mpoints <- max(stringr::str_count(res[["name"]], "[\\.]"))
  res %>%
    tidyr::separate(name, into = paste0("N", 1:(mpoints+1)), sep = "\\.", fill = "right") %>%
    dplyr::mutate(N1 = stringr::str_remove(N1, "X")) %>%
    dplyr::mutate(dplyr::across(dplyr::starts_with("N"), as.numeric)) %>%
    dplyr::mutate(dplyr::across(dplyr::starts_with("N"), ~replace_na(.x, 0)))
}

find_label_node <- function(dend_df, .label, node_num = NULL){
  label <- NULL
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
