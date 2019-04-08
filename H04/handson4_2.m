clc; close all;clear all;               % Limpa tela variáveis e fecha gráficos
%% Autocorrelação usando built-in function
N=1000;                                 % Número de amostras
f1=10;                                  % Frequência do seno (kHz)
Fs=2000;                                % Frequência de amostragem (kHz)
n=0:N-1;                                % Números de índice de amostra
Am=5;                                   % Amplitude do seno
x=Am*sin(2*pi*f1*n/Fs);                 % Gera o sinal x(n)
t=[1:N]*(1/Fs);                         % Definiçao do eixo do tempo
Rxx=xcorr(x,'biased');                  % Estima a autocorrelaçao de x(n)

%% Plotting
% Plota x(n)
subplot(2,1,1);                         
plot(t,x);                              
title('Sinal senoidal no tempo');
xlabel('Tempo, [s]');
ylabel('Amplitude');
grid;
% Plota Autocorrelação
subplot(2,1,2);                         
plot(Rxx);                             
title('Autocorrelação');
xlabel('Atrasos');
title('Autocorrelação do sinal senoidal');
grid;
