function ecfprice = EmpiricalCF(S0,K,St_sample,r,t,delta,j)
% S0: initial asset price
% K: strike price
% St_sample: sample of terminal asset price
% r: risk free rate
% t: time to maturity
% delta: size of increments for ECF calculation
% j: 1 for call, -1 for put
i=1i;
if abs(j)==1
    Xt=log(St_sample/S0);
    p=t/delta;
    n=length(Xt);
    Cf_hat=exp(Xt)/n;
    ohm_hat=-log(sum(Cf_hat))/delta;
    ecfprice=S0-(sqrt(S0*K)/pi)*exp(-r*t/2+ohm_hat*t/2)*quadl(@ECFIntegrand,0,500)+min(0,j)*(S0-K*exp(-r*t));
else 
    ecfprice='NA';
end

function Int = ECFIntegrand(u)
Cf_n=exp(Xt*(-i*u+1/2))/n;
Cf_t=(sum(Cf_n)).^p;
Int=real(exp(-i*u*(log(S0/K)+r*t+ohm_hat*t)).*Cf_t)./(u.^2+1/4);
end

end



