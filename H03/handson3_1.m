clc; close all;clear all;                           % Limpa variáveis e fecha todos os gráficos
%% Geração do sinal cosenoidal
fsampling = 10;                                     % Taxa de amostragem  (kHz)
tf = 200;                                           % Tempo final 
t = 0 : (1/fsampling) : tf;                         % Vetor tempo discreto, obedecendo o tempo de amostragem
fm = 0.04;                                          % Frequência do sinal senoidal
Am = 2;                                             % Amplitude do sinal senoidal
m = Am*sin(2*pi*fm*t);                              % Geração de amostras do sinal senoidal

plot(t,m,'linewidth',2);                            % Plota gráfico do coseno com taxa de amostragem fsampling
xlabel('Tempo');                                    % Definição do texto do eixo X
ylabel('Amplitude');                                % Definição do texto do eixo Y 
grid on;                                            % Desenhar o grid do gráfico                           
hold on;                                            % Comando para plotar multiplas linhas no mesmo gráfico

%% Gráfico do coseno com nova taxa de amostragem = 0.08 (o dobro da banda do sinal)
fsampling = 0.08;                                   % Taxa de amostragem (kHz)
t2 = 0 : (1/fsampling) : tf;                        % Geração de amostras do sinal m(t) com nova taxa de amostragem
m2 = Am*sin(2*pi*fm*t2);                            % Geração de amostras do sinal m(t) com nova taxa de amostragem    
plot(t2,m2,'r-s','linewidth',2);                    % Plota com nova taxa de amostragem (linha com marcador quadrado) 

%% Gráfico do coseno com nova taxa de amostragem = 0.04 (igual a banda do sinal)
fsampling = 0.04;                                   % Taxa de amostragem (kHz)
t3 = 0 : (1/fsampling) : tf;                        % Geração de amostras do sinal m(t) com nova taxa de amostragem
m3 = Am*sin(2*pi*fm*t3);                            % Geração de amostras do sinal m(t) com nova taxa de amostragem
plot(t3,m3,'k-o','linewidth',2);                    % Plota com nova taxa de amostragem (linha com marcador circular) 
legend('Taxa de amostragem = 10 kHz',...
'Taxa de amostragem = 0.08 kHz',...
'Taxa de amostragem = 0.04 kHz');                   % Adiciona legenda ao gráfico
title('Sinal seno com frequência = 0.04 kHz');    % Adiciona título ao gráfico
axis([0 2*1/fm -3 4]);                              % Zoom em dois períodos da onda

% A função 'whos' é responsável por mostrar todas as variáveis que foram criadas no workspace,
% identificando suas principais caracteristicas.