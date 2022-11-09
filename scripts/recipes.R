library("tidyverse")
library("tidymodels")

houses_bog <- readRDS("../stores/lum_dist_vars_imputed_bog.Rds")
houses_med <- readRDS("../stores/lum_dist_vars_imputed_med.Rds")
std_scaler <- sd(houses_med$price) / sd(houses_bog$price)
houses_bog$price <- houses_bog$price * std_scaler
mean_transformer <- mean(houses_med$price) - mean(houses_bog$price)
houses_bog$price <- houses_bog$price + mean_transformer

data <- rbind(houses_bog, houses_med)
data <- data %>%
    group_by(city) %>%
    slice_sample(n = 500)

# Create dummies

data <- recipe(~., data = data) %>%
    step_impute_mode(P6210) %>%
    step_dummy(
        Depto, P5090, P6210
    ) %>%
    step_interact(
        terms = ~ Nper:starts_with("P6210") +
            Oc:starts_with("P6210") +
            P6020:starts_with("P6210") +
            P6040:starts_with("P6210")
    ) %>%
    step_poly(
        Nper, Oc, P5000, P5010, P6020, P6090, P6040,
        degree = 3
    ) %>%
    prep() %>%
    bake(new_data = NULL)

# Create train and test samples
set.seed(10)
data_split <- data %>% initial_split(prop = 0.8)
train <- data_split %>% training()
test <- data_split %>% testing()

set.seed(10)
validation_split <- vfold_cv(train, v = 5)

# Recipes to prepare data for classification
rec_reg <- recipe(Ingpcug ~ ., data = train) %>%
    step_rm(Lp, Pobre) %>%
    step_impute_mode(
        P6920, P7040, P7090, P7505
    ) %>%
    step_dummy(
        P6920, P7040, P7090, P7505
    )
