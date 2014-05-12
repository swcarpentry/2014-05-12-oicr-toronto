m <- matrix(c(seq(from = 2, to = 100, by = 2)),nrow=10,ncol=5)

apply(m, 2, sum)

f <- function(x) {
  for (i in 1:length(x)) {
    if (x[i] %% 3 == 0) {
      x[i] <- NA
    }
  }
  return(x)
}

f(m[1,])

apply(m, 2, f)

m[sample(nrow(m)),]
m[,sample(ncol(m))]
