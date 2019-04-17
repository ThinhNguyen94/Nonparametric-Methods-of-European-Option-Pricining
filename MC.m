function [Price,stdev]=MC(ST,t,K,r,j)
% ST: sample of terminal asset price
% t: time to maturity
% K: strike price
% r: risk free rate
% j: 1 for call, -1 for put
if abs(j)==1
    n=length(ST);
    payoff=zeros(n,1);
    for i=1:n
        payoff(i)=max(0,j*(ST(i)-K))*exp(-r*t);
    end
    Price=mean(payoff);
    stdev=std(payoff)/sqrt(n);
else
    Price='NA';
    stdev='NA';
end
