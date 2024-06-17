# Conexión a bases de datos
# `r lifecycle::badge("experimental")`
#
#   Crea una conexión con un sistema de base de datos.
#
# @param db_name [character]: nombre de la base de datos
# @param db_host [character]: dirección del host de la base de datos
# @param db_port [numeric]: puerto de la base de datos
# @param db_user [character]: nombre de usuario de la base de datos.
# @param db_pass [character]: contraseña de la base de datos.
# @param db_sys [character]: nombre del sistema de base de datos.
# Para utilizar el driver correcto.
# @param k_service_id [character]: "keyring service id" si está utilizando keyring
#  para almacenar sus credenciales.
# @param trusted_connection [logical]: si es `TRUE` se conectará a la base de datos
#  con autenticación de Windows. Útil para SQL Server.
# @param ...: otros argumentos que se pasan a la función de conexión de la base de datos.
#
# @return conexión a base de datos. Vea \code{DBI::\link[DBI:dbConnect]{dbConnect}}
#
# @seealso
#
#   \href{https://db.rstudio.com/best-practices/managing-credentials/#encrypt-credentials-with-keyring}{Databases using R}
#
#
#
# @examples
# \dontrun{
# conn <- db_connect()
# }
db_connect <- function(
    db_user = NULL,
    db_pass = NULL,
    db_sys = "PostgreSQL",
    db_name = "encft",
    db_host = "localhost",
    db_port = 5432,
    k_service_id = "postgre",
    ...,
                       trusted_connection = 'Yes',
                       ...
                       ) {
  .args <- list(...)

  if (db_name %in% c("enft1", "enft2")) {
    cli::cli_alert_warning(
      paste0("Usa db_name = 'enft' en lugar de db_name = '", db_name, "'.")
    )
    db_name <- "enft"
  }

  rlang::check_installed("DBI")
  rlang::check_installed('odbc')

  if (!is.null(k_service_id)) {
    rlang::check_installed("keyring")
    uname <- keyring::key_list(k_service_id)[1, 2]
    pass <- keyring::key_get(k_service_id, uname)
  } else {
    uname <- db_user
    pass <- db_pass
  }

  if (db_sys == 'SQL Server') {
    rlang::check_installed("odbc")
    conn <- DBI::dbConnect(odbc::odbc(),
      Driver = "ODBC Driver 17 for SQL Server",
      Server = db_host,
      Database = db_name,
      Trusted_Connection = trusted_connection,
      ...
    )

    return(conn)
  }

  if (db_sys == "PostgreSQL") {
    rlang::check_installed("RPostgres")
    conn <- DBI::dbConnect(RPostgres::Postgres(),
      dbname = db_name,
      host = db_host,
      port = db_port,
      user = uname,
      password = pass
    )
  } 

  stop(cli::cli_alert_error(
    paste0("El sistema de base de datos '", db_sys, "' no está soportado.")
  ), call. = FALSE)
}




# Conexión a bases de datos
#   `r lifecycle::badge("deprecated")`
#
#   Crea una conexión con un sistema de base de datos.
#
# @param db_name [character]: nombre de la base de datos
# @param db_host [character]: dirección del host de la base de datos
# @param db_port [numeric]: puerto de la base de datos
# @param db_user [character]: nombre de usuario de la base de datos.
# @param db_pass [character]: contraseña de la base de datos.
# @param db_sys [character]: nombre del sistema de base de datos. P
# ara utilizar el driver correcto.
# @param k_service_id [character]: "keyring service id" si está utilizando keyring
#  para almacenar sus credenciales.
#
# @return conexión a base de datos. Vea \code{DBI::\link[DBI:dbConnect]{dbConnect}}
#
# @seealso
#
#   \href{https://db.rstudio.com/best-practices/managing-credentials/#encrypt-credentials-with-keyring}{Databases using R}
#
#
#
# @examples
# \dontrun{
# conn <- db_connect()
# }
dbConnect <- function(db_user = NULL,
                      db_pass = NULL,
                      db_sys = "PostgreSQL",
                      db_name = "encft",
                      db_host = "localhost",
                      db_port = 5432,
                      k_service_id = "postgre") {
  deprecate_warn("0.2.5", "Dmisc::dbConnect()", "db_connect()")
  db_connect(db_user, db_pass, db_sys, db_name, db_host, db_port, k_service_id)
}
