source("../scripts/get_mode.R")
source("./data_prep.R")

library("tidyverse")
# library("sf")
# library("osmdata")
# library("spdep")
library("dplyr")

houses_bog <- dplyr::filter(bog_med, city == "Bogotá D.C")
houses_med <- dplyr::filter(bog_med, city == "Medellín")

# bog_geo <- st_as_sf(x = houses_bog, coords = c("lon", "lat"), crs = 4326)
# med_geo <- st_as_sf(x = houses_med, coords = c("lon", "lat"), crs = 4326)
# cal_geo <- st_as_sf(x = cal, coords = c("lon", "lat"), crs = 4326)

# rm(list = c("bog_med", "cal", "houses_bog", "houses_med", "houses_preproc"))

nei_bog <- readRDS("../stores/nei_bog.Rds")
nei_med <- readRDS("../stores/nei_med.Rds")
nei_cal <- readRDS("../stores/nei_cal.Rds")



mode_imputer <- function(df, neighbors) {
    vars_to_impute <- c(
        "bathrooms",
        "sala_com",
        "upgrade_in",
        "upgrade_out",
        "garage",
        "light"
    )

    for (variable in vars_to_impute) {
        imputed_var <- paste0("imputed_", variable)
        df[, imputed_var] <- numeric(nrow(df))
        for (value in seq_len(nrow(df))) {
            values_neighbors <- df[neighbors[[value]], variable][[1]]
            imputed <- get_mode(values_neighbors)
            df[value, imputed_var] <- imputed
        }
    }
    df
}


mean_imputer <- function(df, neighbors) {
    vars_to_impute <- c("surface_total")
    for (variable in vars_to_impute) {
        imputed_var <- paste0("imputed_", variable)
        df[, imputed_var] <- numeric(nrow(df))
        for (value in seq_len(nrow(df))) {
            values_neighbors <- df[neighbors[[value]], variable][[1]]
            imputed <- mean(values_neighbors, na.rm = TRUE)
            if (is.nan(imputed)) {
                imputed <- NA
            }
            df[value, imputed_var] <- imputed
        }
    }
    df
}



tidy_base <- function(df) {
    df <- df %>%
        mutate(
            bathrooms = if_else(
                bathrooms == 0 | is.na(bathrooms), imputed_bathrooms, bathrooms
            ),
            sala_com = if_else(
                sala_com == 0 | is.na(sala_com), imputed_sala_com, sala_com
            ),
            upgrade_in = if_else(
                upgrade_in == 0 | is.na(upgrade_in), imputed_upgrade_in, upgrade_in
            ),
            upgrade_out = if_else(
                upgrade_out == 0 | is.na(upgrade_out), imputed_upgrade_out, upgrade_out
            ),
            garage = if_else(
                garage == 0 | is.na(garage), imputed_garage, garage
            ),
            light = if_else(
                light == 0 | is.na(light), imputed_light, light
            ),
            surface_total = if_else(
                surface_total == 0 | is.na(surface_total), imputed_surface_total, surface_total
            )
        ) %>%
        select(-starts_with("imputed"))

    df
}

houses_bog <- mode_imputer(houses_bog, nei_bog)
houses_bog <- mean_imputer(houses_bog, nei_bog)
houses_bog <- tidy_base(houses_bog)
saveRDS(houses_bog, "../stores/imputed_bog.Rds")
houses_med <- mode_imputer(houses_med, nei_med)
houses_med <- mean_imputer(houses_med, nei_med)
houses_med <- tidy_base(houses_med)
saveRDS(houses_med, "../stores/imputed_med.Rds")
houses_cal <- mode_imputer(houses_cal, nei_cal)
houses_cal <- mean_imputer(houses_cal, nei_cal)
houses_cal <- tidy_base(houses_cal)
saveRDS(houses_cal, "../stores/imputed_cal.Rds")
