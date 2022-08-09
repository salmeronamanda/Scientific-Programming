shannon_diversity <- function(comm) {
  sp <- ncol(comm) - 1
  H <- 0
  N <- sum(comm[,2:sp + 1])

  for(i in seq(1, sp)){
    p <- sum(comm[,i + 1]) / N
    Hi <- p * log( p )
    H <- H - Hi
  }
  return(H)
}
