## Esscher Parameter 
Esscher.par=function(r,t,S0,St.sample,a,b){
  # r: risk-free rate (assuemd constant)
  # t: time to maturity (in fraction of years)
  # S0: initial asset price
  # St.sample: simulated terminal asset price sample
  # a: lower bound for interval search
  # b: upper bound for interval search
  
  n=length(St.sample)
  Xt=log(St.sample/S0)  # sample of log-returns
  
  # Use 'uniroot' to find optimal solution of Esscher Parameter
  Esscher=function (theta){
    f1=matrix(0,ncol=1,nrow=length(Xt))
    for (i in 1:length(Xt)){
      f=matrix(0,ncol=1,nrow=length(Xt))
      for (j in 1:length(Xt)){
        f[j]=exp(theta*(Xt[j]-Xt[i])-Xt[i])
      }
      f1[i]=1/sum(f)
    }
    f2=exp(r*t)-sum(f1)
    return(f2)
  }
  if ((Esscher(a)*Esscher(b))>0){
    return(NA)
  } else {
    theta=uniroot(Esscher,interval=c(a,b))$root
    return(theta)
  } 
}

## Esscher Function
EET.P= function(K,S0,St.sample,t,r,j,a,b) {
  # K: Strike price
  # S0: initial asset price
  # St.sample: simulated terminal asset price sample
  # t: time to maturity (in fraction of years)
  # r: risk-free rate (assumed constant)
  # j: 1 (for call option), or -1 (for put option)
  
  n=length(St.sample) # n: size of simulated sample
  theta=Esscher.par(r,t,S0,St.sample,a,b) # find the risk-neutral 
  #     Esscher parameter
  Xt=log(St.sample/S0) # log-return
  q=matrix(0,nrow=n,ncol=1)
  for (i in 1:n){
    f=matrix(0,ncol=1,nrow=n)
    for (k in 1:n){
      f[k]=exp(theta*(Xt[k]-Xt[i]))
    }
    q[i]=1/sum(f)  # Esscher transformed risk-neutral measure 
  }
  if (abs(j)==1){
    Pay.off=matrix(0,nrow=n,ncol=1)
    for (l in 1:n){
      Pay.off[l]=max(j*(exp(Xt[l])*S0-K),0)
    }
    Price=sum(Pay.off*q)*exp(-r*t) # European Option Price
    return(Price)
  } else {
    return(NA)
  }
}