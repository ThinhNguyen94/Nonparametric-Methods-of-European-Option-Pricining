BSM=function(S0,K,r,t,sigma,j){
  # S0: initial asset price
  # K: Strike Price
  # r: risk-free rate
  # t: time to maturity
  # sigma: volatility of asset price (assumed constant)
  # j: j=1 for "Call Option" , and j=-1 for "Put Option"
  
  if (abs(j)==1){
    d2=(log(S0/K)+(r-0.5*sigma^2)*t)/(sigma*sqrt(t))
    d1=d2+sigma*sqrt(t)
    Price=j*S0*pnorm(j*d1)-j*K*exp(-r*t)*pnorm(j*d2)
    return(Price)
  } else{
    return(NA)
  }
}