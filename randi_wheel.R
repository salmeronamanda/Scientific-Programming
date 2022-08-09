randi_wheel = function(fitness){
  tmp_weights=fitness/sum(fitness)
  tmp_order=cumsum(tmp_weights)
  x=which(runif(1)<=tmp_order)[1]
  return(x)
}