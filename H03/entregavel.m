clc; close all;clear all;               % Limpa variáveis e fecha todos os gráficos
%%  Analise do espectro de um arquivo de audio
soundFile = ['../../DCO2004_2019/MATERIAL/HD_03_MATLAB/Flauta.wav'];             % Especifica do local e nome do arquivo de áudio
[vtSom, dFa] = audioread(soundFile);                              % Abre arquivo de áudio de um arquivo
% vtSom: amplitude das amostras de som
% dFa: frequência de amostrasgem do som (amostragem no tempo)
%vtSom = 4*vtSom;
%PARA ENTREGAR:

dta = 1/dFa;                                                      % Tempo entre amostras
dTFinal = (length(vtSom)-1)*dta;                                  % Tempo da última amostra do sinal de áudio
vtTSom = 0:dta:dTFinal;                                           % Eixo temporal do arquivo de áudio
plot(vtTSom,vtSom);                                               % Plota gráfico do áudio
%%
%Trabalhando o espectro
lfft=1000;
%Construção do Single-sided amplitude spectrum
yfft=fft(vtSom,lfft);                                          %Utilizando a função built-in
freq=[0:dFa/lfft:dFa/2-dFa/lfft];
yfftuni = abs(yfft(1:lfft/2));
figure(1);
plot(freq,(yfftuni/max(yfftuni)));
title('Espectro Violino.wav');
xlabel('Frequência (Hz)');
ylabel('Amplitude Normalizada');
grid on;
axis([0 8000 0 1]);
%%
%Utilizando Janelamento:
xh=flattopwin(length(vtSom));
xw=vtSom.*xh;
XW=fft(xw,lfft);
XWuni=abs(XW(1:lfft/2));
figure(2);
plot(freq,(XWuni/max(XWuni)));
axis([0 8000 0 1]);
grid on;
%%
%NOVO SOM:




