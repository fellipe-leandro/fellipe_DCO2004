% Desempenho de modulação digital sujeito a Desvanecimento Rice
clc;clear all; close all;
% Parâmetros
N = 10^6;                           % Número de símbolos BPSK a serem transmitidos
EbN0dB = -5:2:20;                   % Valores EbN0 a simular
EbN0=10.^(EbN0dB/10);                % EbN0 em escala linear
totPower=1;                         % Potência total (LOS + NLOS)
K=[0,5,30];                          % Valores K Ricianos a simulacao
% Transmissor
d=and(1,N)>0.5;                     % Dados binários 
x = 2*d -1;                         % Símbolos BPSK: 0 representado por -1 e 1 representado por 1
%
% Inicialização de vetores de BER simulada e teórica
simBER_ricean=zeros(1,length(EbN0dB));
% Configuração da figuras e linhas
figure(1)
plotStyleSim=['b*','ro','k-d','g-^','m->','c-<'];
%
% Loop de K Riciano
for index = 1:length(K)

    k = K(index);                   % Valor de K corrente
    % Mensagem de progresso da simulação
    disp(['Simulando K = ',num2str(k)])
    % Canal
    % Parâmetro de não-centralidade e sigma de Rice
    s = sqrt( k/(k+1)*totPower ) ;
    sigma = totPower/sqrt(2*(k+1));
    %
    % Loop de EbNo
    for ii = 1:length(EbN0dB)
        % Continuação do Canal
        % 
        % Ruído AWGN complexo com média 0 e variância 1 (vetor base)
        noise = 1/sqrt(2)*(randn(1,N)+1j*randn(1,N));
        % Vetor de ruído com potência proporcional a EbNo corrente    
        n = noise*10^(-EbN0dB(ii)/20); 
        % Desvanecimento Rice
        h = ((sigma*randn(1,N)+s)+1j*(randn(1,N)*sigma+0));
        %
        % Receptor
        % Sinal recebido do canal Rice e AWGN
        y_ricean=h.*x+n; 
        % Receptor coerente: equalização + decisão
        y_ricean_cap=y_ricean./h; 
        r_ricean=real(y_ricean_cap)>0;
        % Contador de erro
        simBER_ricean(ii)=sum(xor(d,r_ricean));
        % Fim do loop de EbN0
    end
    % Cálculo da BER para o valor de K corrente
    simBER_ricean=simBER_ricean/N;
    %
    % Gráficos
    semilogy(EbN0dB,simBER_ricean,'*-');
    hold all;

end
    %

    
% Pes Teóricas
% Implementação direta da equação de Pe para o canal Rayleigh+AWGN
BER_rayleigh_teorica = 0.5*(1-sqrt(EbN0./(1+EbN0)));
% Implementação direta da equação de Pe para o canal somente AWGN
BER_awgn_teorica = 0.5*erfc(sqrt(EbN0));
%
% Graficos
% Rayleigh teórico
semilogy(EbN0dB,BER_rayleigh_teorica,'k-');
% AWGN teórico
semilogy(EbN0dB,BER_awgn_teorica,'b--');
legend()
title('Eb/N0 Vs BER for BPSK over Rician Fading Channels with AWGN noise')
xlabel('Eb/N0(dB)')
ylabel('Bit Error Rate or Symbol Error Rate')
xlim([-5,20]);
legend(['K= ',num2str(K(1)),' simulado'],['K= ',num2str(K(2)),' simulado'],['K= ',num2str(K(3)),' simulado'],'Rayleigh Teórica','AWGN Teórica');
ylim([10^(-5),10^0])
grid on
