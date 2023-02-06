#' st_view
#'  `r lifecycle::badge("experimental")`
#'
#' The function provides a simple way to view the data of a sf object without
#' the geospatial component.
#'
#' @param sf An object of class sf (Simple Features).
#'
#' @return Returns an invisble sf object.
#'
#' @export
#'
#' @examples
#' \dontrun{
#'
#' # Create an sf object
#' sf_obj <- sf::st_as_sf(mtcars, coords = c("wt", "mpg"), crs = 4326)
#'
#' st_view(sf_obj)
#' }
st_view <- function(sf){
  View(sf::st_drop_geometry(sf))
  invisible(sf)
}
