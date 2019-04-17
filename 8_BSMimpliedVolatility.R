## BSM implied volatility 
ImpliedVol<-function(S0,K,r,t,Price,j,a,b) {
  # S0: initial asset price
  # K: Strike price
  # r: risk free rate
  # t: time to maturity
  # Price: actual price
  # j: -1 (for put option), or 1 (for call option)
  # a: lower bound of search interval
  # b: upper bound of search interval
  
  f=function(x){
    d2=(log(S0/K)+(r-0.5*x^2)*t)/(x*sqrt(t))
    d1=d2+x*sqrt(t)
    BSM_Price=j*S0*pnorm(j*d1)-j*K*exp(-r*t)*pnorm(j*d2)
    g= BSM_Price-Price
    return(g)
  }
  if (f(a)*f(b)>0){
    return(NA)
  } else{
    Sigma=uniroot(f,c(a,b))$root
    print(Sigma)}
}