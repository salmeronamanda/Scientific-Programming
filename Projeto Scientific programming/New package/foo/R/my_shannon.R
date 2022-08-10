#' Shannon diversity
#'
#' @param x A vector with values of abundance in the community
#'
#' @return A numeric vector of length 1 with the value of the Shannon diversity
#' @export
#'
#' @examples
#' com <- c(1, 2, 3)
#' my_shannon(com)
#'
my_shannon <- function(x) {
  x <- x[x > 0]
  sum_all <- sum(x)
  pi <- x/sum_all
  -sum(pi*log(pi))
}

