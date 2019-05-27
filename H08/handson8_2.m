% %Estimar SNR de sinais recebidos com ruido
% %Tenho informações do sinal enviado (Am,fm) -> consigo encontrar a potencia
% %do sinal enviado
% %Calculo a potencia do sinal recebido (y=x+n)
% % n=y-x ...
% 
% clear all; clc; close all;
% load('Pratica_08_sinal_real.mat')
% N=length(y);
% t=0:1/fs:(N-1)/fs;   
% x_orig=Am*cos(2*pi*fm*t); %Sinal original
% %Calcular Potência do Sinal Original:
% Px = sum(abs(x_orig).^2)/N;
% %O sinal y corresponde a y=x+n -> n=y-x
% n=y-x_orig;
% %Potencia do ruido n:
% Pn=sum(abs(n).^2)/N;
% %Determinando SNR:
% SNR=Px/Pn;
% SNR_dB=10*log10(SNR);
% %%
% %Plotagens
% figure(1)
% subplot(3,1,1);
% plot(t,x_orig);
% title('Sinal Original');
% xlabel('t[s]');
% subplot(3,1,2);
% plot(t,y);
% title(['Sinal Recebido - SNR = ' num2str(SNR_dB) 'dB']);
% xlabel('t[s]');
% ylim([-2 2])
% subplot(3,1,3);
% plot(t,n);
% xlabel('t[s]');
% title('Ruído');
% 
%Estimar SNR de sinais recebidos com ruido
%Tenho informações do sinal enviado (Am,fm) -> consigo encontrar a potencia
%do sinal enviado
%Calculo a potencia do sinal recebido (y=x+n)
% n=y-x ...

clear all; clc; close all;
load('Pratica_08_sinal_complexo.mat')
N=length(y);
t=0:1/fs:(N-1)/fs;   
x_orig=Ar*cos(2*pi*fm*t)+1i*Ai*cos(2*pi*fm*t); %Sinal original
%Calcular Potência do Sinal Olriginal:
Px = sum(abs(x_orig).^2)/N;
%O sinal y corresponde a y=x+n -> n=y-x
n=y-x_orig;
%Potencia do ruido n:
Pn=sum(abs(n).^2)/N;
%Determinando SNR:
SNR=Px/Pn;
SNR_dB=10*log10(SNR);
%%
%Plotagens
figure(1)
subplot(3,1,1);
plot(t,abs(x_orig));
title('Sinal Original');
xlabel('t[s]');
subplot(3,1,2);
plot(t,abs(y));
title(['Sinal Recebido - SNR = ' num2str(SNR_dB) 'dB']);
xlabel('t[s]');
%ylim([-2 2])
subplot(3,1,3);
plot(t,n);
xlabel('t[s]');
title('Ruído');


