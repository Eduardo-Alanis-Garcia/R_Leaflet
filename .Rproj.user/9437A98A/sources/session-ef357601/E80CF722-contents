mun = sf::read_sf("Datos/Municipios/municipiosjair.shp")
mun = mun |> 
  dplyr::arrange(CVE_MUN)
mun$geometry[69] |>  plot()

for (i in 1:nrow(mun)) {
  fila = mun[i,]
  png(filename = paste0("Img/Municipios/",fila$NOM_MUN, ".png"), width = 1920, height = 1470)
  plot(fila$geometry, col = "black")
  dev.off()

}
