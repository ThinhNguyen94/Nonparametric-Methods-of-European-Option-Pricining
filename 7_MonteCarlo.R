### Monte Carlo Function
MC=function(St,t,K,r,j){
  # St: Simulated terminal asset price sample
  # t: the time interval (or time to maturity)
  # K: Strike price
  # r: the risk-free rate (assumed constant) 
  # j: -1 for "Put option", and 1 for "Call option"
  
  if (abs(j)==1){
    n=length(St)
    payoff=matrix(0,nrow=n,ncol=1)
    for (i in 1:n){
      payoff[i]=max(0,j*(St[i]-K))*exp(-r*t)
    }
    # Price obtained by Monte Carlo Method
    Price=sum(payoff)*(1/n)
    return(Price)
  } else {
    return(NA)
  }
}

### Monte Carlo Estimator standard deviation
=function(St,t,K,r,j){
  # St:  Simulated terminal asset price sample
  # t: time to maturity
  # K: Strike Price
  # r: the risk-free rate (assumed constant) 
  # j: -1 for "Put option", and 1 for "Call option"
  
  if (abs(j)==1){
    n=length(St)
    payoff=matrix(0,nrow=n,ncol=1)
    for (i in 1:n){
      payoff[i]=max(0,j*(St[i]-K))*exp(-r*t)
    }
    # Price obtained by Monte Carlo Method
    Price=sum(payoff)*(1/n)
    stdev=sqrt((sum((payoff-Price)^2)/(n-1))/n)
    return(stdev)
  } else {
    return(NA)
  }
}