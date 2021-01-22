#' Conexión a bases de datos
#'
#'   `r lifecycle::badge("experimental")`
#'
#'   Crea una conexión con un sistema de base de datos.
#'
#' @param db_name [character]: nombre de la base de datos
#' @param db_host [character]: dirección del host de la base de datos
#' @param db_port [numeric]: puerto de la base de datos
#' @param db_user [character]: nombre de usuario de la base de datos.
#' @param db_pass [character]: contraseña de la base de datos.
#' @param db_sys [character]: nombre del sistema de base de datos. Para utilizar el driver correcto.
#' @param k_service_id [character]: "keyring service id" si está utilizando keyring
#'  para almacenar sus credenciales.
#'
#' @return conexión a base de datos. Vea \code{DBI::\link[DBI:dbConnect]{dbConnect}}
#'
#' @seealso
#'
#'   \href{https://db.rstudio.com/best-practices/managing-credentials/#encrypt-credentials-with-keyring}{Databases using R}
#'
#' @export
#'
#' @examples
#' \dontrun{
#'   conn <- dbConnect()
#' }
dbConnect <- function(db_user = NULL,
                       db_pass = NULL,
                       db_sys = 'PostgreSQL',
                       db_name = 'encft',
                       db_host = 'localhost',
                       db_port = 5432,
                       k_service_id = 'postgre'){

  uname <- ifelse(!is.null(k_service_id), keyring::key_list(k_service_id)[1,2], db_user)
  pass <- ifelse(!is.null(k_service_id), keyring::key_get(k_service_id, uname), db_pass)
  if(db_sys == 'PostgreSQL'){
    DBI::dbConnect(RPostgres::Postgres(),
                   dbname = db_name,
                   host = db_host,
                   port = db_port,
                   user = uname,
                   password = pass)
  }
}
