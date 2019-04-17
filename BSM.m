function BSM_Price=BSM(S0,K,r,t,sig,j)
% S0: initial asset price
% K: strike price
% r: risk free rate
% t: time to maturity
% sig: constant volatility 
% j: 1 for 'call', -1 for 'put'
if abs(j)==1
    d2=(log(S0/K)+(r-0.5*sig^2)*t)/(sig*sqrt(t));
    d1=d2+sig*sqrt(t);
    BSM_Price=j*S0*normcdf(j*d1)-j*K*exp(-r*t)*normcdf(j*d2);
else
    BSM_Price='NA';
end

    