function [M] = BSM_tab(m,n,K,t,S0,r,sig,delta,a,j)
% m: number of simulations
% n: number of discretized increments
% K: Strike price
% t: time to maturity
% S0: spot price
% r: risk free rate
% sig: constant volatility in BSM
% delta: size of time increment in ECF
% a: intial value for fzero() function
% j: 1 for call; -1 for put
P1=BSMEuSim(S0,r,sig,delta,m,n);
PT=BSMEuSim(S0,r,sig,t,m,n);
M=zeros(length(K),5);
for i = 1:length(K)
    M(i,1)=BSM(S0,K(i),r,t,sig,j);
    M(i,2)=MC(PT,t,K(i),r,j);
    M(i,3)=EEsscherPrice(r,t,S0,PT,K(i),a,j);
    M(i,4)=EmpiricalCF(S0,K(i),P1,r,t,delta,j);
    M(i,5)=MCStd(PT,t,K(i),r,j);
end