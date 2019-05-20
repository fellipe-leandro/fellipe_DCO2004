clc;clear all; close all;
%% Parâmetros
mu = 5000;                                                 % Média
sigma = 40;                                            % Desvio padrâo
T=0.1;                                                % Taxa de amostragem
Ti=3500;
Tf=6500;
x=Ti:T:Tf;                                               % Eixo x       
point=5038;
% Distribuição
DistNorm=normpdf(x,mu,sigma);                           % Distribuição normal    
% Estimação da probabilidade
%indices = max(find(x<=-sigma))+1:min(find(x>=sigma)); % Encontra o local que se deseja estimar
indices = round((point-Ti)/T):round((Tf-Ti)/T);
prob1=sum(DistNorm(indices))*T*100;                     % Probabilidade de um evento ocorrer no intervalo
plot(x,DistNorm);                                       
title([ 'Probabilidade de =  ' num2str(prob1)  ]);      % Mostra valor verdadeiro de prob1
hold on;
area(x(indices),DistNorm(indices));                      % Probabilidade 
% Outra maneira de calcular
syms xs fs;
fs = 1/(sqrt(2*pi*sigma^2))*exp(-(xs-mu)^2/(2*sigma^2));
prob2 = eval(int(fs,5038,inf))*100;
disp([' Probabilidade pela integral da fórmula da PDF = ' num2str(prob1) ' %']);
disp([' Probabilidade pela área da PDF = ' num2str(prob2) ' %']);