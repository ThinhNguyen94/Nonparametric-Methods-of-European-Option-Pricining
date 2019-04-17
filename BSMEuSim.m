function [ST,St]=BSMEuSim(S0,mu,sig,t,m,n)
% ST: simulated terminal asset price
% St: simulated price process
% S0: spot price
% mu: drift (or risk free rate)
% sig: constant volatility
% t: time to maturity
% m: number of simulations
% n: number of discretized increments
ST=zeros(m,1);
for i = 1:m
    St=zeros(n,1);
    for j = 1:n
        if j==1
            St(j)=S0*exp((mu-0.5*sig^2)*t/n+sig*sqrt(t/n)*randn(1,1));
        elseif j>1
            St(j)=St(j-1)*exp((mu-0.5*sig^2)*t/n+sig*sqrt(t/n)*randn(1,1));
        end
    end
    ST(i)=St(n);
end

