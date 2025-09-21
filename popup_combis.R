datos = readxl::read_excel("Datos/Combis/Rutas ZMP.xlsx")

names(datos) = c("numero", "mnemotecnica", "derrotero", "unidades", "extra")

datos = datos |> 
  dplyr::filter(derrotero != "DERROTERO")

layers_pachuca_kml = ("Datos/Combis/Pachuca de Soto.kml" |> sf::st_layers())$name |> 
  lapply(\(x){sf::st_read("Datos/Combis/Pachuca de Soto.kml", layer = x )})

rutas_pachuca = do.call(rbind,layers_pachuca_kml)
rutas_pachuca = rutas_pachuca |> sf::st_zm()

source("Funcion_Github.R")
imagenes = imagenes_git(folder = "Img/Combis/")
imagenes = imagenes[-c(nrow(imagenes), (nrow(imagenes) - 1)),]

descripciones = datos |> 
  dplyr::select(mnemotecnica, derrotero) |> 
  dplyr::mutate(mnemotecnica = gsub(pattern = " ", replacement = "", x = mnemotecnica) |>  stringr::str_squish())

interes = rutas_pachuca |> 
  dplyr::right_join(y = imagenes, by = c("Name"  = "nombre_principal")) |>
  dplyr::left_join(y = descripciones, by = c("Name" = "mnemotecnica")) |> 
  dplyr::filter(!sf::st_is_empty(geometry))


imagenes_icon = imagenes_git(folder = "Img/Combis/")


library(htmltools)


library(leaflet)
mapa = leaflet() |> 
  addTiles() |> 
  addPolylines(data = interes, 
              label = paste0(
                "<div style='display:flex; align-items:center;'>",
                "<img src='", interes$links, "' style='width:auto; height:30px; margin-right:5px;'>",
                "<span>", "<b>", interes$Name, "</b>", "</span>",
                "</div>"
              ) |> lapply(FUN =  function(x){htmltools::HTML(x)}),
              popup = HTML("
<div style='width:100%; height:auto;'>
  <svg viewBox='0 0 16635.89 7646.24' xmlns='http://www.w3.org/2000/svg' style='width:99%; height:auto; display:block;'>
    <path d='M16504.46 4309.75c-24.06,-6.42 -19.45,-8.32 -27.87,-35.06 -39.42,-489.76 125.83,-723.59 -399.16,-1228.58 -68.05,-65.44 -182.94,-116.59 -248.42,-175.54 -110.24,-99.2 -211.68,-196.06 -334.34,-286.18 -27.42,-20.14 -24.72,-21.66 -52.78,-45.62l-753.04 -588.4c-158.45,-118.96 -308.75,-231.12 -472.26,-345.91 -304.28,-213.61 -645.89,-444.8 -993.27,-644.33 -792.5,-455.2 -1495.89,-831 -2453.27,-842.15 -1145.06,-13.34 -8766.16,-88.83 -9748.62,96.08 -125.55,23.62 -294.91,335.32 -362.18,470.66 -281.84,567.08 -430.16,1316.76 -498.73,1956.98 -56.28,525.35 -74.86,1058.83 -67.57,1590.49 3.41,249.51 23.32,1388.29 107.27,1531.18l14.49 50.96 -110.01 3.7c-16.41,162.03 13.35,513.53 114.46,595.62 47.34,38.44 507.85,98.77 605.67,109.21l-8.43 -118.38 235.05 12.64 936.34 91.24c65.86,22.17 39.62,8.8 70.71,56.03 30.19,-123.62 111.93,-231.02 221.12,-260.48 -114.08,492.46 313.96,1141.84 959.39,1238.27 451.04,67.4 886.79,-139.92 1128.04,-510.42 118.63,-182.17 102.74,-232.88 144.63,-335.34 12.04,-29.45 10.28,-20.84 25.03,-41.04l172.82 -16.34 19.41 -103.7 5617.65 11.39c480.89,0.94 1181.24,-11.65 1651.81,2.93 67.23,2.1 127.31,18.49 204.96,21.68 1.27,131.99 112.29,307.7 175.62,398.74 549.21,789.28 1844.43,541.56 2039.26,-429.18 16.96,-84.49 25.72,-173.21 23.08,-262.34 -2.49,-83.05 -32.78,-176.01 -23.71,-250.58 178.16,98.14 313.65,257.27 236.89,464.41 160.97,-0.77 688.76,-22.15 835.69,-54.07 115.58,-25.11 132.21,-55.51 165.25,-64.73 67.16,-18.72 334.75,36.62 567.1,-90.43 218.48,-119.48 286.73,-264.77 303.38,-582.6l4.8 -677.97c-1.34,-70.81 10.2,-181.35 -26.37,-183.67 -25.09,-27.14 -27.13,14.84 -2.1,-52.17l39.03 -172.78c6.06,-89.09 1.48,-192.34 1.48,-282.99 -15.24,-30.44 2.03,-9.28 -20.84,-18.02 -2.83,-1.09 -15.04,-2.53 -17.48,-3.18z'
          fill='#FFEDD9' stroke='#680b0b' stroke-width='180'
          stroke-linejoin='round' stroke-linecap='round'/>
    <image href='Img/Combis/19PCHC.png' x='1050' y='10' width='7000' height='4000'/>
    <rect x='8500' y='500' width='2000' height='600' fill='black'/>
    <text x='8600' y='1000' font-size='500' fill='white' font-family='Arial' font-weight='bold'>RUTA</text>
    <text x='8500' y='2200' font-size='700' fill='red' font-family='Arial' font-weight='bold'>Automatizada</text>
    <rect x='8500' y='2900' width='4000' height='600' fill='blue'/>
    <text x='8600' y='3400' font-size='500' fill='white' font-family='Arial' font-weight='bold'>DESCRIPCIÓN</text>
    <text x='1050' y='4500' font-size='400' fill='blue' font-family='Arial' font-weight='bold'>
      <tspan x='1050' dy='0'>PUNTA AZUL - PIRACANTOS SANTA JULIA PLUTARCO</tspan>
      <tspan x='1050' dy='600'>E. CALLES COL. DOCTORES CÉSPEDES UAEH </tspan>
      <tspan x='1050' dy='600'>PACHUQUILLA Y VICEVERSA</tspan>
    </text>
  </svg>
</div>
")
  )
mapa
