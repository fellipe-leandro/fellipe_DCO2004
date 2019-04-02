clc; close all;clear all;               % Limpa variáveis e fecha todos os gráficos
%% Geração da janela
fsampling = 64;                         % Frequência de amostragem em kHz
tf = 2;                                 % Duração do sinal em s
t = 0 : (1/fsampling) : tf;             % Determinação do eixo do tempo
fm = 8;                                 % Frequência do sinal
Am = 1;                                 % Amplitude do sinal
m1 = Am*cos(2*pi*fm*t);                 % Sinal senoidal puro
m2 = zeros(size(t));                    % Sinal zeros
m2(length(t)/3+1:length(t)*2/3)=1;      % Sinal zeros com "1" entre 1/3 a 2/3 de seu comprimento (janela quadrada)
m=m1.*m2;                               % Sinal resultante

%% Efeito da janela na frequência do sinal
lfft = 1000;                            % Número de pontos da fft
m1fft = fft(m1,lfft)/lfft;              % Cálculo da fft para a senoide
m2fft = fft(m2,lfft)/lfft;              % Cálculo da fft para a janela
mfft = fft(m,lfft)/lfft;                % Cálculo da fft para sinal com janela
% Definição do eixo das frequências unilateral
freq1 = [0 : fsampling/lfft : fsampling/2 - fsampling/lfft];
m1fftuni = m1fft(1:lfft/2);             % fft unilateral senoide
m2fftuni = m2fft(1:lfft/2);             % fft unilateral janela
mfftuni = mfft(1:lfft/2);               % fft unilateral senoide com janela

%% Gráficos
subplot(3,1,1);
plot(freq1,abs(m1fftuni));
title('Senoide na frequência' );
subplot(3,1,2);
plot(freq1,abs(m2fftuni));
title('Janela na frequência' );
subplot(3,1,3);
plot(freq1,abs(mfftuni));
title('Senoide com janela na frequência' );

% Senoide discreta no tempo
figure;
subplot (3,1,1)
stem(t,m1)
axis([0 2 -1.5 1.5])
title('Senoide no tempo' )
% Janela Retangula no tempo
subplot (3,1,2)
stem(t,m2)
axis([0 2 -1.5 1.5])
title('Janela no tempo' )
% Senoide com janela no tempo
subplot (3,1,3)
stem(t,m)
axis([0 2 -1.5 1.5])
title('Senoide com janela no tempo' )