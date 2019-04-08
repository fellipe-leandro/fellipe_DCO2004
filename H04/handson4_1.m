clc; close all;clear all;               % Limpa tela variáveis e fecha gráficos
%% Parâmetros do sinal 
M=1000;                                 % Número de atrasos
N=1000;                                 % Número de amostras
f1=10;                                  % Frequência do seno (kHz)
Fs=2000;                                % Frequência de amostragem (kHz)
n=0:N-1;                                % Vetor com índices de amostra
Am=5;                                   % Determina a amplitude
x=Am*sin(2*pi*f1*n/Fs);                 % Gera o sinal x(n)
t=[1:N]*(1/Fs);                         % Definiçao do eixo do tempo
%% Cálculo da Autocorrelação
Rxx=zeros(1,M);
for m = 1: M                            % Laço do número de atrasos
   for n = 1 : N-m                      % Laço do número de amostras
      Rxx(m)=Rxx(m)+x(n)*x(n+m-1);      % Cálculo de um ponto de Rxx
    end
end
Rxx=Rxx/M;
% Plot do sinal
subplot(2,1,1);                         
plot(t,x);                              
title('Sinal senoidal no tempo');
xlabel('Tempo [s]');
ylabel('Amplitude');
grid;
% Plot da autocorrelação
subplot(2,1,2);                         
plot(Rxx);                              
title('Autocorrelação do sinal senoidal');
xlabel('Atrasos');
ylabel('Autocorrelação');
grid;

