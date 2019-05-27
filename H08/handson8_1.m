%% AWGN real
clc;clear all;close all;
% Parâmetros
SNR_dB = 10;                              % Determina o valor da SNR em dB
Ts=0.00001;
Fs=1/Ts;
t = 0:Ts:5;                           % Eixo do tempo
A = 2;                                    % Amplitude do sinal de entrada x(t)
x=A*cos(2*pi*100*t);                       % Sinal qualquer x(t)
%
% Geração manual das amostras de ruído 
N = length(x);                            % Calcula o comprimento de x
Ps = sum(abs(x).^2)/N;                    % Calcula a potência do sinal
SNR = 10^(SNR_dB/10);                     % Calcula a SNR linear
Pn = Ps/SNR;                              % Calcula a potência do ruído
noiseSigma = sqrt(Pn);                    % Desvio padrão do ruído AWGN (amostras reais)
n = noiseSigma* randn(1,N);               % Vetor do ruído 
y = x + n;                                % Sinal ruidoso na recepção
%
% Estimação da SNR pelas amostras do sinal recebido
pTx = sum(abs(x.^2))/N;                   % Potência do sinal x(t)
pNe = sum(abs(n.^2))/N;                   % Potência estimada do ruído
SNR1 = pTx/pNe;                           % Estimação da SNR linear
SNR1= 10*log10(SNR1);                     % SNR em dB
%
% Gerar ruído com a função awgn.m
y2 =  awgn(x,SNR_dB,'measured');
%
% Estimação da SNR pelas amostras do sinal geradas pela função awgn.m
n2 = y2-x;
potN2 = sum(abs(n2.^2))/N;                % Potência estimada do ruído
SNR2 = pTx/potN2;                         % Estimação da SNR linear
SNR2 = 10*log10(SNR1);                    % SNR em dB
%p=audioplayer(y2,1/Ts);
%play(p);

%audiowrite('ruido_r2.wav',y2,1/Ts);
%audiowrite('sinal.wav',x,1/Ts);
%%
%Análise Espectral
lfft=10000;
%Construção do Single-sided amplitude spectrum
yfft=fft(n2,lfft);                                          %Utilizando a função built-in
freq=[0:Fs/lfft:Fs/2-Fs/lfft];
yfftuni = abs(yfft(1:lfft/2));
figure(1);
stem(freq,(yfftuni/max(yfftuni)),'r');
title('Espectro y2');
xlabel('Frequência (Hz)');
ylabel('Amplitude Normalizada');
%xlim([0,500])
%%
%Calculando autocovariancia normalizada
maxlag = length(t);
[c,lags] = xcov(n2,1000,'coeff');
figure(2)
stem(lags,c)

%
% % Mostrar informações
% disp('Estimação de SNR: ')
% disp(['   SNR de entrada: ' num2str(SNR_dB) ' dB']);
% disp(['   SNR de entrada: ' num2str(SNR1) ' dB']);
% disp(['   SNR de entrada: ' num2str(SNR2) ' dB']);
% %
% % Gráficos
% fig=figure;
% subplot(5,1,1);
% plot(t,x);
% title('Sinal original')
% axis([0 1 -2 2]);
% %
% subplot(5,1,2);
% plot(t,y);
% title('Sinal Com Ruido AWGN gerado manualmente');
% axis([0 1 -4 4]);
% %
% subplot(5,1,3);
% plot(t,n);
% title('Ruido AWGN gerado manualmente');
% axis([0 1 -2 2]);
% %
% subplot(5,1,4);
% plot(t,y2);
% title('Sinal Com Ruido AWGN gerado pela função awgn.m');
% axis([0 1 -4 4]);
% %
% subplot(5,1,5);
% plot(t,n2);
% title('Ruido AWGN gerado pela função awgn.m');
% axis([0 1 -2 2]);
% fig.PaperUnits = 'inches';
% fig.PaperPosition = [0 0 12 6];
