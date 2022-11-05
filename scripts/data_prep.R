library("tidyverse")
library("sf")
library("osmdata")

houses <- readRDS("../stores/train.Rds")
houses_bog <- houses %>% filter(city == "Bogotá D.C")
houses_med <- houses %>% filter(city == "Medellín")

bog_geo <- st_as_sf(x = houses_bog, coords = c("lon", "lat"), crs = 4326)
med_geo <- st_as_sf(x = houses_med, coords = c("lon", "lat"), crs = 4326)

get_feature <- function(place, key, value) {
    feature <- opq(bbox = getbb(place)) %>%
        add_osm_feature(key = key, value = value) %>%
        osmdata_sf() %>%
        .$osm_polygons %>%
        select(osm_id)

    feature
}

parks_bog <- get_feature("Bogota Colombia", "leisure", "park")
parks_med <- get_feature("Medellin Colombia", "leisure", "park")

dist_parks_bog <- st_distance(x = bog_geo, y = parks_bog)
dist_parks_med <- st_distance(x = med_geo, y = parks_med)
