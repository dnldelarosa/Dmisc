
`%<...%` <- function(names, values, .envir = .GlobalEnv, .warn = TRUE) {
  # Emitir una advertencia si 'warn' es TRUE
  if (.warn) {
    warning("This function assigns variables to the global environment by default. ",
            "This may overwrite existing objects. To assign to a different environment, ",
            "use the '.envir' argument.")
  }

  if (inherits(values, "list")) {
    if (all(names %in% names(values))) {
      for (variable in seq_along(values)) {
        assign(names[variable], values[[names[variable]]], envir = .envir)
      }
    } else {
      for (variable in seq_along(values)) {
        assign(names[variable], values[variable][[1]], envir = .envir)
      }
    }
  } else {
    if (all(names %in% names(values))) {
      for (variable in seq_along(values)) {
        assign(names[variable], values[[names[variable]]], envir = .envir)
      }
    } else {
      for (variable in seq_along(values)) {
        assign(names[variable], values[variable], envir = .envir)
      }
    }
  }
}





`%...>%` <- function(values, names, .envir = .GlobalEnv, .warn = TRUE) {
  `%<...%`(names, values, .envir = .envir, .warn = .warn)
}
