#' Retrieve or Create a Pin
# `r lifecycle::badge("experimental")`
#'
#' This function attempts to retrieve a specified pin from a board.
#' If the pin doesn't exist or the data is different, it creates a new pin.
#'
#' @param .data The data to be pinned if a new pin is to be created.
#' @param .board The board where the pin is located or should be created.
#' @param .name The name of the pin to be retrieved or created.
#' @param type The type of data being pinned, defaults to 'csv'.
#' @param ... Additional arguments to be passed to `pins::pin_write`.
#'
#' @return The version of the pin that was retrieved or created.
#'
#' @examples
#' \dontrun{
#'   board <- pins::board_register_local()
#'   data <- mtcars
#'   pin_version <- pin_get_or_create(data, board, "mtcars_pin")
#' }
pin_get_or_create <- function(.data, .board, .name, type = 'csv', ...) {
  .versions <- character()
  .version <- NULL
  . <- NULL
  created <- NULL
  tryCatch(
    {
      .versions <- pins::pin_versions(.board, .name)[['version']]
    },
    error = function(e) {
    }
  )
  if (length(.versions) > 0) {
    for (.v in .versions) {
      .old <- pins::pin_read(.board, .name, .v)
      if (identical(.data, .old)) {
        .version <- .v
        break
      }
    }
  }
  if (is.null(.version)) {
    pins::pin_write(.board, .data, .name, type, ...)
    .versions <- pins::pin_versions(.board, .name)
    .version <- .versions %>%
      dplyr::arrange(created) %>%
      utils::tail(1) %>%
      dplyr::pull(version) %>%
      .[[1]]
  }
  return(.version)
}
