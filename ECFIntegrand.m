function Int = ECFIntegrand(u,St_sample,S0,K,r,t,delta)
% u: variable
% St_sample: sample of terminal asset price
% S0: initial asset price
% K: strike price
% r: risk free rate
% t: time to maturity
% delta: size of time increments in ECF calculation
i=1i;
Xt=log(St_sample/S0);
p=t/delta;
n=length(Xt);
Cf_hat=zeros(n,1);
for s = 1:n
    Cf_hat(s)=exp(Xt(s))/n;
end
ohm_hat=-log(sum(Cf_hat))/delta;
Cf_n=zeros(n,1);
for s = 1:n
    Cf_n(s)=exp((-i*u+1/2)*Xt(s))/n;
end
Cf_t=(sum(Cf_n))^p;
Int=real(exp(-i*u*(log(S0/K)+r*t+ohm_hat*t))*Cf_t)/(u^2+1/4);