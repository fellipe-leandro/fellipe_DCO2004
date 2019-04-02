clc; close all;clear all;                                     % Limpa variáveis e fecha todos os gráficos
%% Aalise do espectro com funcoes built-in
fsampling = 20;                                               % Taxa de amostragem
tf = 2;                                                     % Tempo entre amostras
t = 0 : (1/fsampling) : tf;                                   % Eixo do tempo
fm = 08;                                                    % Frequência da senoide
Am = 2;                                                       % Amplitude da senoide
m = Am*cos(2*pi*fm*t);                                        % Sinal senoidal
t1=tic;                                                       % Contador de tempo

%% Visualizando a amplitude do espectro com um tamanho arbitrário para a fft
lfft = 1000;                                                   % Tamanho da FFT  
% Construção do single-sided amplitude spectrum.
yfft = fft(m,lfft)/lfft;                                      % Cálculo da FFT via função do Matlab
freq1 = [0 : fsampling/lfft : fsampling/2 - fsampling/lfft];  % Definição do eixo das frequências unilateral (eixo com 512 pontos)
yfftuni = yfft(1:lfft/2);                                     % Coleta da FFT unilateral
stem(freq1,abs(yfftuni));                                     % Plotagem do espectro unilateral M(f)
tempo_FFT=toc(t1);                                            % Conta tempo de execução até esse ponto do código
disp(['Tempo da FFT = ' num2str(tempo_FFT)]);                 % Mostra de tempo de execução
title('Amplitude unilateral do Espectro de m(t)');            % Configuração do título do gráfico 
xlabel('Frequencia (kHz)');                                   % Configuração do eixo x do gráfico 
ylabel('|M(f)|');                                             % Configuração do eixo y do gráfico  
grid on;                                                      % Adiona o grid  
axis([ 0 20 0 1.2]);                                         % Zoom do gráfico