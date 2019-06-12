clc;clear all;close all;
%% Parametros
K = 20;                                         % Número de amostras
l = 0 : K;                                      % Eixo amostras
%
% Definindo forma de onda
s_0 = ones(1,K);                                % Sinal 1: Um degrau
s_1 = [ ones(1,K/2), -ones(1,K/2) ];            % Sinal 2: Soma de degraus
%
% Inicializando sinais de saida do correlator
r_0 = zeros(1,K);                               % Inicializa vetor r_0
r_1 = zeros(1,K);                               % Inicializa vetor r_1
vtVar = [0 0.1 1];                              % Variâncias a simular
% Figura para sinais no tempo
fig1 = figure;
fig1.PaperUnits = 'inches';
fig1.PaperPosition = [0 0 15 6];
subplot(length(vtVar)+1, 2, 1 );
plot(1:K,s_0); 
legend('s_0(t)');
subplot(length(vtVar)+1, 2, 2 );
plot(1:K,s_1,'r');
legend('s_1(t)');
% Figura para saídas dos correlatores
fig2 = figure;
fig2.PaperUnits = 'inches';
fig2.PaperPosition = [0 0 15 6];
% Cálculo da saída do correlator para cada valor de variância do ruído
for  ik = 1 : length(vtVar)
    vtNoise = sqrt(vtVar(ik))*randn(1,K);        % Vetor de ruído
    %
    %% Sinais quando s_0 é transmitido
    rs_0 = s_0 + vtNoise;                        % Sinal recebido
    % Correlacionando sinais
    for n = 1 : K
        r_0(n)=sum(rs_0(1:n).*s_0(1:n));
        r_1(n)=sum(rs_0(1:n).*s_1(1:n));
    end
    %% Gráficos 
    %
    % Gráficos da autocorrelação
    figure(fig2);
    subplot( length(vtVar), 2, 2*ik-1 );
    plot(l,[0 r_0],'-');
    hold all;
    plot(l,[0 r_1],'--');
    legend('r_{0}','r_{1}','Location','northwest');
    xlabel(['\sigma^{2}= ' num2str(vtVar(ik)) ' & s_{0} é transmitido'])
    %
    % Gráficos do sinal+ruído no tempo
    figure(fig1);
    subplot(length(vtVar)+1, 2, 2*(ik+1) - 1  );
    plot(1:K,rs_0);
    legend(['s_0(t) + n(t), \sigma^{2}= ' num2str(vtVar(ik))])
    % 
    %% Sinais quando s_1 é transmitido
    rs_1 = s_1 + vtNoise;                         % Sinal recebido
    % Correlacionando sinais
    for n = 1 : K
        r_0(n)=sum(rs_1(1:n).*s_0(1:n));
        r_1(n)=sum(rs_1(1:n).*s_1(1:n));
    end
    %
    %% Gráficos 
    %
    % Gráficos da autocorrelação
    figure(fig2);
    subplot( length(vtVar), 2, 2*ik );
    plot(l,[0 r_0],'-')
    hold all;
    plot(l,[0 r_1],'--')
    legend('r_{0}','r_{1}','Location','northwest');
    xlabel(['\sigma^{2}= ' num2str(vtVar(ik)) ' & s_{1} é transmitido'])
    %
    % Gráficos do sinal+ruído no tempo
    figure(fig1);
    subplot(length(vtVar)+1, 2, 2*(ik+1) );
    plot(1:K,rs_1);
    legend(['s_1(t) + n(t), \sigma^{2}= ' num2str(vtVar(ik))])
    % 
end

