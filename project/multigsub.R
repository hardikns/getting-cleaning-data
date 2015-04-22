mgsub <- function(pattern, replacement, x, ...) {
    if (length(pattern) != length(replacement)) {
        stop("pattern not of same length as replacement")
    }
    for (i in seq_along(pattern)) {
        x = gsub(pattern[i], replacement[i], x, ... )
    }
    x
}