HesOV=function(S0,K,t,r,v0,theta,rho,kappa,sig,j){
  # S0: initial asset price
  # K: Strike price
  # t: time to maturity
  # r: risk free rate
  # v0: initial volatility 
  # theta: long run mean of volatility
  # rho: correlation coefficient
  # kappa: speed of mean reversion
  # sig: square root of variance of volatility
  # j: j=1 for "Call Option" , and j=-1 for "Put Option"
  
  if (abs(j)==1){
    P1=function(ohm,S0,K,t,r,v0,theta,rho,kappa,sig){
      i=1i
      p=Re(exp(-i*log(K)*ohm)*cfHeston(ohm-i,S0,t,r,v0,
                                       theta,rho,kappa,sig)/(i*ohm*S0*exp(r*t)))
      return(p)
    }
    P2=function(ohm,S0,K,t,r,v0,theta,rho,kappa,sig){
      i=1i
      p=Re(exp(-i*log(K)*ohm)*cfHeston(ohm,S0,t,r,v0,theta,rho,kappa,sig)/(i*ohm))
      return(p)
    }
    cfHeston=function(ohm,S0,t,r,v0,theta,rho,kappa,sig){
      d=sqrt((rho*sig*1i*ohm-kappa)^2+sig^2*(1i*ohm+ohm^2))
      g2=(kappa-rho*sig*1i*ohm-d)/(kappa-rho*sig*1i*ohm+d)
      cf1=1i*ohm*(log(S0)+r*t)
      cf2=theta*kappa/(sig^2)*((kappa-rho*sig*1i*ohm-d)*t-
                                 2*log((1-g2*exp(-d*t))/(1-g2)))
      cf3=v0/sig^2*(kappa-rho*sig*1i*ohm-d)*(1-exp(-d*t))/(1-g2*exp(-d*t))
      cf=exp(cf1+cf2+cf3)
      return(cf)
    }
    vP1=0.5+j*1/pi*integrate(P1,lower = 0,upper=200,S0,K,t,r,v0,theta,
                             rho,kappa,sig)$value
    vP2=0.5+j*1/pi*integrate(P2,lower = 0,upper=200,S0,K,t,r,v0,theta,
                             rho,kappa,sig)$value
    price=j*S0*vP1-j*exp(-r*t)*K*vP2
    return(price)
  } else{
    return(NA)
  } 
}