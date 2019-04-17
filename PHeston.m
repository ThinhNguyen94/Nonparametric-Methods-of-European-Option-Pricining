function HesP=PHeston(S0,K,t,r,v0,theta,rho,k,sigma,j)
% S0: initial asset price 
% K: strike price
% t: time to maturity
% r: risk free rate
% v0: initial value of volatility
% theta: long run mean of volatility
% rho: correlation coefficient
% k: speed of mean reversion
% sigma: square root of variance of volatility process
% j: 1 for call, -1 for put
    function p=P1(ohm,S0,K,t,r,v0,theta,rho,k,sigma)
        i=1i;
        p=real(exp(-i*log(K)*ohm).*cfHeston(ohm-i,S0,t,r,v0,theta,rho,k,sigma)./(i*ohm*S0*exp((r*t))));
    end
    function p=P2(ohm,S0,K,t,r,v0,theta,rho,k,sigma)
        i=1i;
        p=real(exp(-i*log(K)*ohm).*cfHeston(ohm,S0,t,r,v0,theta,rho,k,sigma)./(i*ohm));
    end
    function cf=cfHeston(ohm,S0,t,r,v0,theta,rho,k,sigma)
        d=sqrt((rho*sigma*1i*ohm-k).^2+sigma^2*(1i*ohm+ohm.^2));
        g2=(k-rho*sigma*1i*ohm-d)./(k-rho*sigma*1i*ohm+d);
        cf1=1i*ohm.*(log(S0)+r*t);
        cf2=theta*k/(sigma^2)*((k-rho*sigma*1i*ohm-d)*t-2*log((1-g2.*exp(-d*t))./(1-g2)));
        cf3=v0/sigma^2*(k-rho*sigma*1i*ohm-d).*(1-exp(-d*t))./(1-g2.*exp(-d*t));
        cf=exp(cf1+cf2+cf3);
    end
if abs(j)==1
    vP1=0.5+j*1/pi*quadl(@P1,0,200,[],[],S0,K,t,r,v0,theta,rho,k,sigma);
    vP2=0.5+j*1/pi*quadl(@P2,0,200,[],[],S0,K,t,r,v0,theta,rho,k,sigma);
    HesP=j*S0*vP1-j*exp(-r*t)*K*vP2;
else
    HesP='NA';
end
end