# Set a name to a time series
# `r lifecycle::badge("experimental")`
#
# @param .ts [ts]: time series
# @param .name [character]: name to set
#
# @return [ts]: time series with name set in .name attribute
#
# @examples
# \dontrun{
# ts <- ts_name(ts, "my_ts")
# attr(ts, ".name")
# }
#
ts_name <- function(.ts, .name) {
    attr(.ts, ".name") <- .name
    .ts
}
