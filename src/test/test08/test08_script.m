clear
load('src/data/CS3_1_Sysclima.mat')
load('src/data/CS3_4_production.mat')

prod = ProduccionMenaka2021(2:end,:);
%%
clf
plot(prod.FechaDeEntrega,prod.Neto,'.')