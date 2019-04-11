clc; close all;clear all;     
%%Calculo do periodograma de uma modulação FM
Fs = 15000; % Sampling rate of signal
Fc = 3000; % Carrier frequency
N=5000;
t = [0:N-1]/Fs; % Sampling times
s1 = sin(2*pi*300*t)+2*sin(2*pi*600*t); % Channel 1
x = s1;
dev = 50; % Frequency deviation in modulated signal
y = fmmod(x,Fc,Fs,dev); % Modulate both channels.
%z = fmdemod(y,Fc,Fs,dev); % Demodulate both channels.
plot(t,y);
axis([0 0.05 -2 2]);
[pxx,f] = periodogram(y,hamming(length(y)),length(y),Fs,'power');
figure(2)
[pwrest,idx] = max(pxx);
plot(f,pxx);
title('Peridiograma');
xlabel('Frequência');
ylabel('Potência (W)');
disp(['A potência máxima ocorre em ' num2str(f(idx)) ' Hz' ] );
disp(['A potência estimada é ' num2str(pwrest) ] );