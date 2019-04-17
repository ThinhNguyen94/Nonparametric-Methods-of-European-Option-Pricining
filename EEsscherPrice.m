function EPrice = EEsscherPrice(r,t,S0,St_sample,K,a,j)
% r: risk free rate
% t: time to maturity
% S0: initial asset price
% St_sample: sample of terminal asset price
% K: strike price
% a: initial value for root solving function 'fzero()'
% j: 1 for call, -1 for put
n=length(St_sample);
theta=EsscherPa(r,t,S0,St_sample,a);
Xt=log(St_sample/S0);
q=zeros(n,1);
for i = 1:n
    f=zeros(n,1);
    for k = 1:n
        f(k)=exp(theta*(Xt(k)-Xt(i)));
    end
    q(i)=1/sum(f);
end
if abs(j)==1
    payoff=zeros(n,1);
    for s = 1:n
        payoff(s)=max(0,j*(exp(Xt(s))*S0-K));
    end
    EPrice=sum(payoff.*q)*exp(-r*t);
else
    EPrice= 'NA';
end

