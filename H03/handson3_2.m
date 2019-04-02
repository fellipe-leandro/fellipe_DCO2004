clc; close all;clear all;                             % Limpa variáveis e fecha todos os gráficos
%% Geração do sinal cosenoidal
fsampling = 10;                                       % Taxa de amostragem
T =1/fsampling;                                       % Tempo entre amostras
L = 2000;                                             % Número de amostras
t = 0 : (1/fsampling) : (L-1)*T;                      % Eixo do tempo
fm = 0.04;                                            % Frequência da senoide
Am = 2;                                               % Amplitude da senoide
m = Am*cos(2*pi*fm*t);                                % Sinal senoidal
t1=tic;                                               % Contador de tempo

%% Montando a DFT
N=length(m);                                          % Comprimento do sinal m(t)
n=0:N-1;                                              % Vetor n
k=0:N-1;                                              % Vetor k
WN=exp(-j*2*pi/N);                                    % Cálculo de Wn = e^{-j2pi/N}
nn=n'*k;                                              % Monta a Matriz DFT
WNnk=WN.^nn;                                          % Monta a Matriz DFT
X=m*WNnk/L;                                           % Implementa o somatório da DFT via operação matricial    
f = fsampling/2*linspace(0,1,(L/2)+1);                % Monta o eixo das frequências
tempo_DFT=toc(t1);                                    % Conta tempo de execução até esse ponto do código
disp(['Tempo da DFT = ' num2str(tempo_DFT) ' s']);    % Mostra tempo de execução
stem(f,2*abs(X(1:L/2+1)));                            % Mostra gráfico do espectro 
axis([ 0 0.1 0 2.2]);                                 % Zoom para melhor visualização 
% A função 'whos' é responsável por mostrar todas as variáveis que foram criadas no workspace,
% identificando suas principais caracteristicas.
whos