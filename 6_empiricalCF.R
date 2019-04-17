ECF=function(S0,K,St.sample,r,t,delta,j){
  # S0: initial asset price
  # K: Strike price
  # St.sample: sample of the simulated asset price over 'delta t' time period
  # r: annual risk-free rate
  # t: time to maturity (in fraction of years)
  # delta: size of time increment (in fraction of years) between observations
  # j : 1 for "call option", or -1 for "put option"
  
  if (abs(j)==1){ 
    X=log(St.sample/S0)
    p=t/delta  # number of time increments
    n=length(X)
    i=1i
    CF.hat=matrix(0,nrow=n,ncol=1)
    for (s in 1:n){
      CF.hat[s]=(1/n)*exp(X[s])  # ECF of log returns 
    }
    ohm.h=-log(sum(CF.hat))/delta # martingale condition (equation 3.28)
    
    # The integrand inside equation (3.27)
    Integrand=function(u){
      CF.n=matrix(0,nrow=n, ncol=1)
      for(s in 1:n){
        CF.n[s]=(1/n)*exp((-i*u+1/2)*X[s])
      }
      CFT=(sum(CF.n))^p
      Int=Re(exp(-i*u*(log(S0/K)+r*t+ohm.h*t))*CFT)/(u^2+1/4)
      return(Int)
    }
    # Option price under Empirical Characteristic Function:
    Price=(S0-(sqrt(S0*K)/pi)*exp(-r*t/2+ohm.h*t/2)*integrate(Integrand,
                                                              lower = 0,upper = Inf)$value + min(0,j)*(S0-K*exp(-r*t)))
    return(Price)  
  } else{
    return(NA)
  }
}