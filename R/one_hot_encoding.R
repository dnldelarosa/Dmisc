#' Apply One-Hot-Encoding to factor variables
#' `r lifecycle::badge("experimental")`
#'
#' @param tbl [data.frame]: dataset with the variables
#' @param variables variables to apply one-hot-encoding. If [NULL] all factor
#'   variables are processed.
#' @param drop_one [logical]: especify if one of categories is drop in final dataset
#' @param ... other arguments passed to \link[tidyr]{pivot_wider}
#'
#' @return a dataset with new binary variables
#'
#' @export
#'
#' @examples
#' \dontrun{
#'   warpbreaks
#'   one_hot_encoding(warpbreaks)
#' }
one_hot_encoding <- function(tbl, variables = NULL, drop_one = FALSE, ...) {
  if(is.null(variables)){
    variables <- names(dplyr::select_if(tbl, is.factor))
  }

  tbl[["xyz1rn"]] <- 1:nrow(tbl)
  tbl <- tibble::rownames_to_column(tbl)

  all_vals <- vector("character")
  for (var in variables) {
    if(is.factor(tbl[[var]])){
      all_vals <- append(all_vals, unique(levels(tbl[[var]])))
    } else {
      all_vals <- append(all_vals, unique(tbl[[var]]))
    }
  }

  for (pos in seq_along(variables)) {
    old_names <- names(tbl)
    id_cols <- old_names[old_names != variables[pos]]
    vals_dup <- length(all_vals[all_vals %in% unique(tbl[[variables[pos]]])]) > length(unique(tbl[[variables[pos]]]))
    tbl <- tidyr::pivot_wider(tbl,
      dplyr::all_of(id_cols),
      names_from = variables[pos],
      values_from = variables[pos],
      names_prefix = dplyr::if_else(vals_dup, paste0(variables[pos], "_"), ""),
      ...
    )
    new_names <- names(tbl)
    tbl <- dplyr::mutate(
      tbl,
      dplyr::across(
        new_names[!(new_names %in% c("xyz1rn", old_names))],
        ~ as.numeric(!is.na(.x))
      )
    )
    if (drop_one) {
      tbl <- dplyr::select(tbl, -dplyr::last(names(tbl)))
    }
  }

  tbl[["xyz1rn"]] <- NULL
  tibble::column_to_rownames(tbl)
}
