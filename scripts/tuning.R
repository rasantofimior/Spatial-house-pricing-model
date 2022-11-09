library("yardstick")
library("tune")

tuning <- function(object, grid, resamples, ...) {
    tune <- tune::tune_grid(
        object = object,
        grid = grid,
        metrics = yardstick::metric_set(rmse),
        resamples = resamples
    )
    tune
}
