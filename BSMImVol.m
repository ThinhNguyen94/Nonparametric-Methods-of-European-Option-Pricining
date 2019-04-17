function [IV]=BSMImVol(S0,K,t,r,P,a,j)
% S0: initial asset price
% K: strike price
% t: time to maturity
% r: risk free rate
% P: actual price
% a: inital value of fzero() function
% j: 1 for call, -1 for put
if abs(j)==1
   fun=@impvol;
   IV=fzero(fun,a);
else
    IV='NA';
end
function f=impvol(sig)
   f=P-BSM(S0,K,r,t,sig,j);
end
end

