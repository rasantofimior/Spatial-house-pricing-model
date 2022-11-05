## Getting Polution and light behaviour for houses in database
##Nicolas Velasquez                                                                                     

rm(list=ls())

#### **Instalar/llamar las librerías de la clase**
require(pacman) 
p_load(tidyverse,rio,skimr,viridis,osmdata,
       ggsn, ## scale bar
       raster,stars, ## datos raster
       ggmap, ## get_stamenmap
       sf, ## Leer/escribir/manipular datos espaciales
       leaflet) ## Visualizaciones dinámicas

## solucionar conflictos de funciones
select <- dplyr::select
scalebar <- ggsn::scalebar
