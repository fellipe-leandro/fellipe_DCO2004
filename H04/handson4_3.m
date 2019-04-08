clc; close all;clear all;
%% Cálculo da potência média por vários métodos
fc=0.04;                              % Frequência do seno
Fs=10;                                % Frequência de amostragem
Ts = 1/Fs;                            % Tempo entre amostras
A = 10;                               % Amplitude do sinal
nC = 20000;                            % Número de períodos da onda   
t=0:Ts:nC/fc-Ts;                      % Vetor tempo
x=A*cos(2*pi*fc*t);                   % Gera o sinal x(n)
N = length(x);                        % Número de amostras do sinal
sT1 = tic; 
Px_tempo =(norm(x)^2)/N; % Cálculo da potência no tempo
disp(['Potência via amostras no tempo = ' num2str(Px_tempo) ', ' num2str(toc(sT1)) ' segundos para calcular.' ]);

sT2 = tic;
Nfft = 1000;                          % Número de pontos da FFT
Xfft=fft(x,Nfft);                     % Encontra a FFT
Xfft = Xfft/Nfft;                     % Encontra a FFT 
Px_fft = sum(Xfft.*conj(Xfft));       % Cálculo da potência na frêquencia
disp(['Potência via FFT (Parseval) = ' num2str(Px_fft) ', ' num2str(toc(sT2)) ' segundos para calcular.' ]);

sT3 = tic;
Rxx=xcorr(x,'biased');                % Estima a autocorrelaçao de x(n)
Px_Rxx = Rxx(N);                      % Cálculo da potência duas bandas via autocorrelação
disp(['Potência via autocorrelação = ' num2str(Px_Rxx) ', ' num2str(toc(sT3)) ' segundos para calcular.' ]);

sT4 = tic;
Px_bPower = bandpower(x);             % Cálculo da potência via bandpower
disp(['Potência via função bandpower = ' num2str(Px_bPower) ', ' num2str(toc(sT4)) ' segundos para calcular.' ]);

sT5 = tic;
Pvar = var(x);                        % Cálculo da potência duas bandas via variancia
disp(['Potência via variância = ' num2str(Pvar) ', ' num2str(toc(sT5)) ' segundos para calcular.' ]);