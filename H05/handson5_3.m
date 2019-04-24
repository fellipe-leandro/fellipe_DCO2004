clc; clear all; close all;
load('../../DCO2004_2019/MATERIAL/HD_05/signal.mat')        % Abre o sinal a ser modulado
fs=1/Ts;                                   % Frequência de amostragem
Ac = 1;                                    % Amplitude da portadora
fc = 25;                                   % Frequência da portadora
c = Ac*cos(2*pi*fc*t);                     % Sinal portadora
s= c.*msg;                                 % Sinal AM-DSB-SC
%% Espectro do sinal
lfft=length(s)*10;                         % Comprimento da fft (Arbitrário)
freq=(-fs/2:fs/lfft:fs/2-fs/lfft);         % Eixo de frequência 
Mfft=fft(s,lfft)/lfft;                     % Calcula a FFT
M_sig=fftshift(Mfft);                      % Posiciona a FFT no centro
% Gráfico do AM-DSB-SC e a mensagem no tempo
subplot(2,1,1);
plot (t,s,t,msg);
legend('Sinal modulante m(t)','Sinal modulado s(t)');
title('AM-DSB-SC no tempo');
ylabel('Amplitude');
xlabel('Tempo [s]');
% Gráfico AM-DSB-SC e a mensagem na frequência 
subplot(2,1,2);
plot (freq ,abs(M_sig));
title('AM-DSB-SC na frequência');
ylabel('Magnitude');
xlabel('Frequência [Hz]');
axis([-50 50 0 0.01]);