function [M]=HesBSM(K,t,S0,r,sig,v0,rho,sigma,k,theta,j)
% K: strike price
% t: time to maturity
% S0: initial asset price
% r: risk free rate
% sig: constant volatility in BSM world
% v0: initial value of volatility
% rho: correlation coefficient
% sigma: square root of variance of volatility process
% k: speed of mean reversion
% theta: long run mean of volatility
% j: 1 for call, -1 for put
M=zeros(length(K),2);
for i = 1:length(K)
    M(i,1)=PHeston(S0,K(i),t,r,v0,theta,rho,k,sigma,j);
    M(i,2)=BSM(S0,K(i),r,t,sig,j);
end
