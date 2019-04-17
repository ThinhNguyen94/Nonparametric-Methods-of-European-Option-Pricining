P.Hes = function(m,S0,r,v0,t,n,rho,sigma,k,theta) {
  # m: the sample size of simulation 
  # S0: intial asset price
  # r: risk-free rate (assumed constant)
  # v0: intial volatility of asset's return
  # t: time to maturity
  # n: number of time steps in Wiener process
  # rho: correlation coefficients 
  # sigma: square root of variance of asset return's volatility
  # k: speed of mean reversion
  # theta: long run mean of volatility
  
  # (a) Create Euler discretization process to generate 1 terminal asset price
  Price=function(S0,r,v0,t,n,rho,sigma,k,theta){
    W=rnorm(n,0,1)  # an independent Wiener process  
    Z=rnorm(n,0,1)  # an independent Wiener process in volatility process
    W.hat=rho*Z+sqrt(1-rho^2)*W # Wiener process in asset price process
    
    # Simulate the volatility process
    v=matrix(0,nrow=n,ncol=1)
    for (i in 1:n){
      if (i==1){
        v[1]=max(0,v0+k*(theta-v0)*t/n+sigma*sqrt(v0)*sqrt(t/n)*Z[1])
      } else{
        v[i]=max(0,v[i-1]+k*(theta-v[i-1])*t/n+
                   sigma*sqrt(v[i-1]*t/n)*sqrt(t/n)*Z[i])
      }
    }
    
    # Simulate the asset price process
    St=matrix(0,nrow=n,ncol=1)
    for (i in 1:n){
      if (i==1){
        St[i]=S0*exp((r-0.5*v0)*t/n+sqrt(v0)*sqrt(t/n)*W.hat[i])
      } else {
        St[i]=St[i-1]*exp((r-0.5*v[i-1])*t/n+sqrt(v[i-1])*sqrt(t/n)*W.hat[i])
      }
    }
    ST=St[n]
    return(ST)
  }
  # (b) replicate the Euler discretization function above m times of simulation
  St.sample=replicate(m,Price(S0,r,v0,t,n,rho,sigma,k,theta))
  return(St.sample)
} 