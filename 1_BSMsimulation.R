P.simp = function(S0,mu,sig,t,n,m) {
  # S0: initial asset value
  # mu: drift of the diffussion process
  # sig: volatility of asset price (assumed constant)
  # t: the time period of interest
  # n: number of simulated final asset prices
  # m: number of time steps of the brownian process
  ST=matrix(0,nrow=n,ncol=1)
  for (i in 1:n){
    St=matrix(0,nrow=m,ncol=1)
    for (j in 1:m){
      if (j==1){
        St[j]=S0*exp((mu-0.5*sig^2)*t/m+sig*sqrt(t/m)*rnorm(1,0,1))
      } else{
        St[j]=St[j-1]*exp((mu-0.5*sig^2)*t/m+sig*sqrt(t/m)*rnorm(1,0,1))
      }
    }
    ST[i]=St[m]
  }
  return(ST)   # return vector of simulated final asset value
}