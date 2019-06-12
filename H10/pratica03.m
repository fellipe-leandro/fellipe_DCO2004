%Desempenho de modulação digital sujeito a Desvanecimento Rayleigh
clc;clear all; close all;
% Parâmetros
N = 10^6;                       % Número de símbolos BPSK a serem transmitidos
EbN0dB =-5:2:20;     % Valores EbN0 a simular
% Transmissor
d =rand(1,N) > 0.5 ;    % Dados binários 
x = 2*d -1;                      % Símbolos BPSK: 0 representado por -1 e 1 representado por 1
%
% Inicialização de vetores de BER simulada e teórica
BER_rayleigh_simulada = zeros(1,length(EbN0dB));
BER_awgn_simulada =zeros(1,length(EbN0dB));
for i=1:length(EbN0dB)
    % Canal
    % Ruído AWGN complexo com média 0 e variância 1 (vetor base)
    noise = 1/sqrt(2)*(randn(1,N)+1j*randn(1,N)); 
    % Vetor de ruído com potência proporcional a EbNo corrente
    n = noise*10^(-EbN0dB(i)/20);  
    % Desvanecimento Rayleigh normalizado
    h = 1/sqrt(2)*(randn(1,N)+1j*randn(1,N));
    %
    % Sinal recebido para caso com somente ruído AWGN
    y_awgn = x + n; 
    % Sinal recebido para caso com desvanecimento Rayleigh e ruído AWGN
    y_rayleigh = h.*x + n;
    %
    % Receptor coerente para o canal Rayleigh (supondo conhecimento de h no receptor)
    y_rayleigh_cap=y_rayleigh./h; % Equalizador
    % Os símbolos positivos recebidos são 1, os demais são 0 (lembrar da simbologia)
    r_rayleigh = real(y_rayleigh_cap)>0;
    %
    % Receptor para o canal somente AWGN
    r_awgn = real(y_awgn) > 0;
    % Contador de erro para o caso com Rayleigh e AWGN
    BER_rayleigh_simulada(1,i) = sum(xor(d,r_rayleigh));
    % Contador de erro para o caso com somente AWGN
    BER_awgn_simulada(1,i) = sum(xor(d,r_awgn));
    % Fim do loop de EbN0
end
% Cálculo da BER para o caso com Rayleigh e AWGN
BER_rayleigh_simulada =BER_rayleigh_simulada/N ;
% Cálculo da BER para o caso com somente AWGN
BER_awgn_simulada =BER_awgn_simulada/N;
%
% Pe Teórica
EbN0=10.^(EbN0dB/10);            % Eb/N0 em escala linear
% Implementação direta da equação de Pe para o canal Rayleigh+AWGN
BER_rayleigh_teorica = 0.5*(1-sqrt(EbN0./(1+EbN0))); 
% Implementação direta da equação de Pe para o canal somente AWGN
BER_awgn_teorica = 0.5*erfc(sqrt(EbN0));
%
%
figure
% Rayleigh simulado
semilogy(EbN0dB,BER_rayleigh_simulada,'go')%,'Display Name','Rayleigh simulada')
hold all;
% AWGN simulado
semilogy(EbN0dB,BER_awgn_simulada,'ro')%'Display Name','AWGN simulada')
% Rayleigh teórico
semilogy(EbN0dB,BER_rayleigh_teorica,'K--')%''Display Name','Rayleigh teórica')
% AWGN teórico
semilogy(EbN0dB,BER_awgn_teorica,'b--')%'Display Name','AWGN teórica')
xlim([-5,20]);
ylim([10^(-5),1.2])
%plt.axis([-5,20,10**(-5),1.2])
legend
title('E_b/N_0 Vs BER para BPSK em canais Rayleigh e AWGN')
xlabel('E_b/N_0(dB)')
ylabel('BER ou Pe')
grid on
legend('Rayleigh Simulada','AWGN Simulada','Rayleigh Teórica','AWGN teórica')

