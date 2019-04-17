function P=PHessim(m,S0,r,v0,t,n,rho,sigma,k,theta)
% m: sample size
% S0: initial asset price
% r: risk free rate
% v0: initial volatility
% t: time to maturity
% n: number of time steps in one simulation process
% rho: correlation coefficients
% sigma: square root of variance of asset price's volatility
% k: speed of mean reversion
% theta: long run mean of volatility
P=zeros(m,1);
for i = 1:m
  P(i)=HestonPSim(S0,r,v0,t,n,rho,sigma,k,theta);
end

