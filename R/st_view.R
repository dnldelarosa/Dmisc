# st_view
#  `r lifecycle::badge("experimental")`
#
# The function provides a simple way to view the data of a sf object without
# the geospatial component.
#
# @param sf An object of class sf (Simple Features).
#
# @return Returns an invisble sf object.
#
# 
st_view <- function(sf){
  if(interactive()){
    utils::View(sf::st_drop_geometry(sf))
  }
  invisible(sf)
}
