#' Instalar un paquete si no esta presente
#'
#' Esta función verifica si un paquete de R esta instalado. Si no lo esta,
#' pregunta al usuario si desea instalarlo. Si el usuario responde afirmativamente,
#' instala el paquete. Si el usuario responde negativamente, la función se detiene
#' y muestra un mensaje indicando que el paquete es necesario.
#'
#' @param nombre_del_paquete El nombre del paquete que se quiere verificar e instalar.
#' 
#' @return Invisible NULL. La función se utiliza principalmente por sus efectos
#'   secundarios (instalación de paquetes), y no devuelve ningún valor.
#' @export
#' 
#' @importFrom utils install.packages
#' 
#' @examples
#' \dontrun{
#'  instalar_paquete_si_falta("dplyr")
#' }
instalar_paquete_si_falta <- function(nombre_del_paquete) {
  if (!requireNamespace(nombre_del_paquete, quietly = TRUE)) {
    mensaje <- paste("El paquete", nombre_del_paquete, "no esta instalado. Desea instalarlo ahora? (y/n)")
    respuesta <- readline(prompt = mensaje)
    
    if (tolower(respuesta) == "y") {
      install.packages(nombre_del_paquete)
    } else {
      stop(paste("El paquete", nombre_del_paquete, "es necesario y no esta instalado."))
    }
  }
}
