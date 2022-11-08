vars_from_dist <- function(city, value) {
    path <- paste0("../stores/dist_", city, "_", value, ".Rds")
    data <- readRDS(path)
    less_500m_name <- paste0("less_500m_", value)
    closest_name <- paste0("closest_", value)
    grouped_vars <- data.frame(numeric(nrow(data)), numeric(nrow(data)))
    colnames(grouped_vars) <- c(less_500m_name, closest_name)
    for (i in seq_len(nrow(data))) {
        y <- data[i, ] %>% as.numeric()
        less_500m <- y[y < 500] %>% length()
        closest <- min(y)
        grouped_vars[i, less_500m_name] <- less_500m
        grouped_vars[i, closest_name] <- closest
    }
    grouped_vars
}

houses_bog <- readRDS("../stores/imputed_bog.Rds")
houses_med <- readRDS("../stores/imputed_med.Rds")
houses_cal <- readRDS("../stores/imputed_cal.Rds")
keyvals <- read.csv("../stores/st_maps_key_val.csv")

append_dist_vars <- function(df, city) {
    for (i in keyvals[, "value"]) {
        vars <- vars_from_dist(city, i)
        df <- cbind(df, vars)
    }
    df
}

houses_bog <- append_dist_vars(houses_bog, "bog")
saveRDS(houses_bog, "../stores/dist_vars_imputed_bog.Rds")
houses_med <- append_dist_vars(houses_med, "med")
saveRDS(houses_med, "../stores/dist_vars_imputed_med.Rds")
houses_cal <- append_dist_vars(houses_cal, "cal")
saveRDS(houses_cal, "../stores/dist_vars_imputed_cal.Rds")
