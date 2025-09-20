mun = sf::read_sf("Datos/Municipios/municipiosjair.shp")

archivos = list.files(path = "Img/Municipios/", pattern = "\\.png$", full.names = T, recursive = T) |>  data.frame()
archivos = archivos |> 
  dplyr::rename(img_direccion = list.files.path....Img.Municipios....pattern.......png....full.names...T..)

archivos = archivos |> 
  dplyr::mutate(municipio = basename(img_direccion) |> gsub(pattern = ".png", replacement = "") |>  stringr::str_squish())


mun = mun |> 
  dplyr::left_join(y = archivos, by = c("NOM_MUN" = "municipio")) 

mun = mun |> 
  dplyr::select(CVEGEO, NOM_MUN, Area, PERIMETER, img_direccion, geometry)

mun = mun |>  
  dplyr::left_join(y = git, by = c("NOM_MUN" = "municipios")) 

library(leaflet)

mapa = leaflet() |> 
  addTiles() |> 
  addPolygons(data = mun, 
              label = paste0(
                "<div style='display:flex; align-items:center;'>",
                "<img src='", mun$links, "' style='width:30px; height:30px; margin-right:5px;'>",
                "<span>", "<b>", mun$NOM_MUN, "</b>", "</span>",
                "</div>"
              ) |> lapply(FUN =  function(x){htmltools::HTML(x)}),
              popup = paste0(
                "<div style='display:flex; align-items:center;'>",
                "<img src='", mun$links, "' style='width:30px; height:30px; margin-right:5px;'>",
                "<span>", "<b>", mun$NOM_MUN, "</b>", "</span>",
                "</div>"
              ) |> lapply(FUN =  function(x){htmltools::HTML(x)})
              )
mapa


