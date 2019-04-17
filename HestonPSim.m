function [ST,St,v]=HestonPSim(S0,r,v0,t,n,rho,sigma,k,theta)
% S0: initial asset price
% r: risk free rate
% v0: initial volatility
% t: time to maturity
% n: number of time steps in one simulation process
% rho: correlation coefficient
% sigma: square root of variance of volatility process
% k: speed of mean reversion
% theta: long run mean of volatility
W=randn(n,1);    
Z=randn(n,1);  
Y=rho*Z(1:n)+sqrt(1-rho^2)*W(1:n);
v=zeros(n,1);
for i =1:n
    if i==1
        v(1)=max(0,v0+k*(theta-v0)*t/n+sigma*sqrt(v0)*sqrt(t/n)*Z(1));
    elseif i > 1
        v(i)=max(0,v(i-1)+k*(theta-v(i-1))*t/n+sigma*sqrt(v(i-1))*sqrt(t/n)*Z(i));
    end
end
St=zeros(n,1);
for j=1:n
    if (j==1)
        St(1)=S0*exp((r-0.5*v0)*t/n+sqrt(v0)*sqrt(t/n)*Y(1));
    elseif j>1
        St(j)=St(j-1)*exp((r-0.5*v(j-1))*t/n+sqrt(v(j-1))*sqrt(t/n)*Y(j));
    end 
end
ST=St(n);


        