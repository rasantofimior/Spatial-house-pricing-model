get_mode <- function(x) { # Create mode function
    unique_x <- unique(x)
    tabulate_x <- tabulate(match(x, unique_x))
    if (length(tabulate_x) > 1) {
        unique_x <- na.omit(unique(x))
        tabulate_x <- tabulate(match(x, unique_x))
        modes <- unique_x[tabulate_x == max(tabulate_x)]
        if (length(modes > 1)) {
            set.seed(10)
            modes <- sample(modes, size = 1)
            return(modes)
        } else {
            return(modes)
        }
    } else {
        return(unique_x[tabulate_x == max(tabulate_x)])
    }
}
