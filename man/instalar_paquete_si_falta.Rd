% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{instalar_paquete_si_falta}
\alias{instalar_paquete_si_falta}
\title{Instalar un paquete si no esta presente}
\usage{
instalar_paquete_si_falta(nombre_del_paquete)
}
\arguments{
\item{nombre_del_paquete}{El nombre del paquete que se quiere verificar e instalar.}
}
\value{
Invisible NULL. La función se utiliza principalmente por sus efectos
secundarios (instalación de paquetes), y no devuelve ningún valor.
}
\description{
Esta función verifica si un paquete de R esta instalado. Si no lo esta,
pregunta al usuario si desea instalarlo. Si el usuario responde afirmativamente,
instala el paquete. Si el usuario responde negativamente, la función se detiene
y muestra un mensaje indicando que el paquete es necesario.
}
\examples{
\dontrun{
 instalar_paquete_si_falta("dplyr")
}
}
