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
get_nb <- function(df) {
    # Get buffer around points
    df_sp <- df %>%
        st_buffer(50) %>%
        as_Spatial()
    # Get neighbors
    df_nb <- poly2nb(pl = df_sp, queen = TRUE)
    df_nb
}

# Neighbors to houses in Bogota, Medellin and Cali
bog_nb <- get_nb(bog_geo)
saveRDS(bog_nb, "../stores/nei_bog.Rds")
med_nb <- get_nb(med_geo)
saveRDS(med_nb, "../stores/nei_med.Rds")
cal_nb <- get_nb(cal_geo)
saveRDS(cal_nb, "../stores/nei_cal.Rds")
