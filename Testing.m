K=[35 41.13 45];
% Heston model vs BSM model
HB=HesBSM(K,1/2,41.13,0.05,0.04,0.04,-0.5,0.4,3,0.04,1);
HB1=HesBSM(K,2/3,41.13,0.05,0.04,0.04,-0.5,0.4,3,0.04,1);
HB2=HesBSM(K,1,41.13,0.05,0.04,0.04,-0.5,0.4,3,0.04,1);
HB3=HesBSM(K,3/2,41.13,0.05,0.04,0.04,-0.5,0.4,3,0.04,1);

% Heston model vs 3 methods results with 300 simulated sample size of 300
HT=Heston_tab(300,1000,K,1/2,41.13,0.05,0.04,1/252,-0.5,0.4,3,0.04,10,1);
HT1=Heston_tab(300,1000,K,2/3,41.13,0.05,0.04,1/252,-0.5,0.4,3,0.04,10,1);
HT2=Heston_tab(300,1000,K,1,41.13,0.05,0.04,1/252,-0.5,0.4,3,0.04,10,1);
HT3=Heston_tab(300,1000,K,3/2,41.13,0.05,0.04,1/252,-0.5,0.4,3,0.04,10,1);

% Heston model vs 3 methods results with simulated sample size of 5000
HT4=Heston_tab(5000,1000,K,1/2,41.13,0.05,0.04,1/252,-0.5,0.4,3,0.04,10,1);
HT5=Heston_tab(5000,1000,K,2/3,41.13,0.05,0.04,1/252,-0.5,0.4,3,0.04,10,1);
HT6=Heston_tab(5000,1000,K,1,41.13,0.05,0.04,1/252,-0.5,0.4,3,0.04,10,1);
HT7=Heston_tab(5000,1000,K,3/2,41.13,0.05,0.04,1/252,-0.5,0.4,3,0.04,10,1);

% BSM model vs 3 methods results with simulated sample size of 300
BT=BSM_tab(300,1000,K,1/2,41.13,0.05,0.2,1/252,10,1);
BT1=BSM_tab(300,1000,K,2/3,41.13,0.05,0.2,1/252,10,1);
BT2=BSM_tab(300,1000,K,1,41.13,0.05,0.2,1/252,10,1);
BT3=BSM_tab(300,1000,K,3/2,41.13,0.05,0.2,1/252,10,1);

% BSM model vs 3 methods results with simulated sample size of 5000
BT4=BSM_tab(5000,1000,K,1/2,41.13,0.05,0.2,1/252,10,1);
BT5=BSM_tab(5000,1000,K,2/3,41.13,0.05,0.2,1/252,10,1);
BT6=BSM_tab(5000,1000,K,1,41.13,0.05,0.2,1/252,10,1);
BT7=BSM_tab(5000,1000,K,3/2,41.13,0.05,0.2,1/252,10,1);

% ECF vs Heston over longer time maturity
P1=PHessim(5000,41.13,0.05,0.04,1/252,1000,-0.5,0.4,3,0.04);
T=[1/2, 2/3,1,3/2, 2, 3, 4, 5];
M=zeros(length(T),2);
for i = 1:length(T)
    M(i,1)=PHeston(41.13,45,T(i),0.05,0.04,0.04,-0.5,3,0.4,1);
    M(i,2)=EmpiricalCF(41.13,45,P1,0.05,T(i),1/252,1);
end
M1=M(:,2)-M(:,1);
plot(T, M1);
M2=(M(:,2)-M(:,1))./M(:,1);
plot(T,M2);
