function h = EsscherPa(r,t,S0,St_sample,a)
% r: risk free rate
% t: time to maturity
% S0: initial asset price
% St_sample: sample of terminal asset price
% a: intial value for root solving function 'fzero()'
n=length(St_sample);
Xt=log(St_sample/S0);
fun=@Esscher;
    function f2=Esscher(theta)
    f1=zeros(n,1);
    for i = 1:n
        f=zeros(n,1);
        for j = 1:n
            f(j)=exp(theta*(Xt(j)-Xt(i))-Xt(i));
        end
        f1(i)=1/sum(f);
    end
    f2=exp(r*t)-sum(f1);
    end
h=fzero(fun,a);
end



