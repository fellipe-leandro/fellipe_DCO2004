clc; clear all; close all;
load('../../DCO2004_2019/MATERIAL/HD_05/signal.mat')        % Abre o sinal a ser modulado
%% Espectro do sinal
lfft=length(msg)*10;                       % Comprimento da fft (Arbitrário)
fs=1/Ts;
freq=(-fs/2:fs/lfft:fs/2-fs/lfft);         % Eixo de frequência 
msgfft=fft(msg,lfft)/lfft;                 % Calcula a FFT
msgfft=fftshift(msgfft);
% Gráfico no tempo
subplot(2,1,1);
plot(t,msg);
title('Sinal m(t) a ser modulado');
ylabel('Amplitude');
xlabel('Tempo [s]')
% Gráfico na frequência
subplot(2,1,2);
plot (freq ,abs(msgfft));
title('Sinal M(f)');
ylabel('Magnitude');
xlabel('Frequência [Hz]');
axis([-10 10 0 0.02]);