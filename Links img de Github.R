library(httr)
library(jsonlite)

# Parámetros del repositorio
owner <- "Eduardo-Alanis-Garcia"
repo  <- "R_Leaflet"
branch <- "main"
folder <- "Img/Municipios"
exts <- c(".png")

# URL de la API para listar el árbol completo del repositorio
url <- paste0("https://api.github.com/repos/", owner, "/", repo, "/git/trees/", branch, "?recursive=1")

# Realizar la solicitud a la API
resp <- GET(url)
stop_for_status(resp)
data <- content(resp, as = "text", encoding = "UTF-8")
json <- fromJSON(data)

# Filtrar archivos que son imágenes
files <- json$tree[json$tree$type == "blob", "path"]
images <- files[sapply(files, function(f) any(endsWith(tolower(f), exts)))]

# Construir URLs RAW
links <- paste0("https://raw.githubusercontent.com/", owner, "/", repo, "/", branch, "/", images)

# Mostrar los enlaces
print(links)




git = links |>  as.data.frame()
git = git |>  
  dplyr::mutate(municipios = links |> basename() |>  gsub(pattern = ".png", replacement = "") |>  stringr::str_squish())


