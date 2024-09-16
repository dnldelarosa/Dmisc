countrypops <- NULL
warning('Se ha removido el conjunto de datos countrypops cargado con el paquete `gt` porque dificultaba el uso de la función `count` de `dplyr`.')
conflicted::conflict_prefer("filter", "dplyr")
conflicted::conflict_prefer("lag", "dplyr")