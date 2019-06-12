%Geração de Canal Plano Rayleigh
clc;clear all;close all;
%Parâmetros
N=20000;    %Numero de amostras
ts=0.1;
x=0:ts:5;   %eixo x
sigma = 1;  %Parâmetro Rayleigh
u=rand(1,N);  %Amostras aleatorias

%Canal Rayleigh pelo metodo da inversao
rReal=sigma*sqrt(-2*log(u));
%PDF Rayleigh Teórico
pdfTeo=x/(sigma^2).*exp(-(x/sigma).^2/2);
%Canal Rayleigh COMPLEXO via VAs Gaussianas Independetes
rComplexo=randn(1,N)+1j*randn(1,N);
%Gráficos
figure(1)
subplot(3,1,1)
%Histograma do Canal Real vs PDF teórica
h=histogram(rReal,x,'Normalization','pdf');
%bar(x,h/(sum(h)*ts));
hold on;
plot(x,pdfTeo,'r');
legend('Histograma - Canal Real','PDF Teórica Rayleigh')
title('PDF da envoltória do Canal Rayleigh Real')
%Canal Complexo:
subplot(3,1,2)
h1=histogram(abs(rComplexo),x,'Normalization','pdf');
%bar(x,h1/(sum(h1)*ts));
hold on;
plot(x,pdfTeo,'r');
title('PDF da envoltória do Canal Rayleigh Complexo')
legend('Histograma - Canal Complexo','PDF teórica Rayleigh')
%Histograma da Fase
subplot(3,1,3)
h_fase=histogram(angle(rComplexo));

%bar(h_fase/(sum(h_fase)*ts));
hold on;
%xlim([-180 180])
title('PDF da Fase do Canal Rayleigh Complexo');



