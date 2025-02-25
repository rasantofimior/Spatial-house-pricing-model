library("tidymodels")
library("ranger")
library("xgboost")

specs <- function(model) {
    # Ridge/Lasso/Elastic - Regression
    if (model %in% c("ridge", "lasso", "elastic")) {
        spec <- linear_reg(
            penalty = tune(),
            mixture = tune()
        ) %>%
            set_engine("glmnet")
    }


    # RF - Regression
    if (model == "rf") {
        spec <- rand_forest(
            trees = 200,
            mtry = tune(),
            min_n = tune(),
        ) %>%
            set_engine("ranger", verbose = TRUE, num.threads = 3) %>%
            set_mode("regression")
    }

    # XGB - Regression
    if (model == "xgb") {
        spec <- boost_tree(
            trees = 200,
            mtry = tune(),
            min_n = tune(),
            sample_size = tune(),
            stop_iter = 5,
            tree_depth = tune(),
            learn_rate = tune(),
            loss_reduction = tune()
        ) %>%
            set_engine("xgboost", nthread = 3) %>%
            set_mode("regression")
    }


    spec
}
