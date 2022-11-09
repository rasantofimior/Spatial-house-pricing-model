source("./data_prep.R")

library("tidyverse")
library("sf")
library("osmdata")
library("spdep")
library("dplyr")

houses_bog <- dplyr::filter(bog_med, city == "Bogotá D.C")
houses_med <- dplyr::filter(bog_med, city == "Medellín")

bog_geo <- st_as_sf(x = houses_bog, coords = c("lon", "lat"), crs = 4326)
med_geo <- st_as_sf(x = houses_med, coords = c("lon", "lat"), crs = 4326)
cal_geo <- st_as_sf(x = cal, coords = c("lon", "lat"), crs = 4326)

rm(list = c("bog_med", "cal", "houses_bog", "houses_med", "houses_preproc"))

# Get neighbors for points in a df
get_nb <- function(df, dist) {
    # Get buffer around points
    df_sp <- df %>%
        st_buffer(dist) %>%
        as_Spatial()
    # Get neighbors
    df_nb <- poly2nb(pl = df_sp, queen = TRUE)
    df_nb
}

# Neighbors to houses in Bogota, Medellin and Cali - 50 meters
bog_nb <- get_nb(bog_geo, 50)
saveRDS(bog_nb, "../stores/nei_bog.Rds")
med_nb <- get_nb(med_geo, 50)
saveRDS(med_nb, "../stores/nei_med.Rds")
cal_nb <- get_nb(cal_geo, 50)
saveRDS(cal_nb, "../stores/nei_cal.Rds")

# Neighbors to houses in Bogota, Medellin and Cali - 500 meters
bog_nb_500 <- get_nb(bog_geo_500, 500)
saveRDS(bog_nb, "../stores/nei_bog_500.Rds")
med_nb_500 <- get_nb(med_geo_500, 500)
saveRDS(med_nb, "../stores/nei_med_500.Rds")
cal_nb_500 <- get_nb(cal_geo, 500)
saveRDS(cal_nb_500, "../stores/nei_cal_500.Rds")
