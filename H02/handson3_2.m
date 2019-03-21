close all;clc;clear all;                                          % Limpa variáveis e fecha todos os gráficos
soundFile = ['../../DCO2004_2019/MATERIAL/HD_02_MATLAB/sound_01.wav'];             % Especifica do local e nome do arquivo de áudio
[vtSom, dFa] = audioread(soundFile);                              % Abre arquivo de áudio de um arquivo
% vtSom: amplitude das amostras de som
% dFa: frequência de amostrasgem do som (amostragem no tempo)
%vtSom = 4*vtSom;
%PARA ENTREGAR:
vtSom = [vtSom; vtSom];
dta = 1/dFa;                                                      % Tempo entre amostras
dTFinal = (length(vtSom)-1)*dta;                                  % Tempo da última amostra do sinal de áudio
vtTSom = 0:dta:dTFinal;                                           % Eixo temporal do arquivo de áudio
plot(vtTSom,vtSom);                                               % Plota gráfico do áudio
set(gcf,'color',[1 1 1]);                                         % Configura área da figura
set(gca,'FontWeight','bold','FontSize',12);                       % Configura área do gráfico
title(['Sinal de Áudio']);                                        % Configura título do gráfico
ylabel('Amplitude');                                              % Configura eixo X do gráfico
xlabel('Tempo (s)');                                              % Configura eixo Y do gráfico
p = audioplayer(vtSom, 1*dFa);                                    % Reproduzir arquivo de áudio
play(p);                                                          % Reproduzir arquivo de áudio