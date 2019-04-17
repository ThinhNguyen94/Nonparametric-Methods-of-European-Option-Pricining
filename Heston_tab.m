function [M]=Heston_tab(m,n,K,t,S0,r,v0,delta,rho,sigma,k,theta,a,j)
% m: size of simulated sample 
% n: number of time increments in simulation process
% K: strike price
% t: time to maturity
% S0: initial asset price
% r: risk free rate
% v0: initial value of volatility
% delta: size of time increments used in ECF method (=1/252)
% rho: correlation coefficient
% sigma: square root of variance of volatility process
% k: speed of mean reversion
% theta: long run mean of volatility
% a: initial value of root solving function 'fzero()'
% j: 1 for call, -1 for put
P1=PHessim(m,S0,r,v0,delta,n,rho,sigma,k,theta);
PT=PHessim(m,S0,r,v0,t,n,rho,sigma,k,theta);
M=zeros(length(K),5);
for i = 1:length(K)
    M(i,1)=PHeston(S0,K(i),t,r,v0,theta,rho,k,sigma,j);
    M(i,2)=MC(PT,t,K(i),r,j);
    M(i,3)=EEsscherPrice(r,t,S0,PT,K(i),a,j);
    M(i,4)=EmpiricalCF(S0,K(i),P1,r,t,delta,j);
    M(i,5)=MCStd(PT,t,K(i),r,j);
end
