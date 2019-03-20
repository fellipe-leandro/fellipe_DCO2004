close all;clc;clear all;                                          % Limpa variáveis e fecha todos os gráficos
soundFile = ['../../DCO2004_2019/MATERIAL/HD_02_MATLAB/sound_02.wav'];             % Especifica do local e nome do arquivo de áudio
[vtSom, dFa] = audioread(soundFile);                              % Abre arquivo
tf = 10;                                                          % Tempo que deseja tocar o arquivo
amostrasTf = ceil(tf*dFa);                                        % Número de amostras para o tempo especificado
vtSom = vtSom(1:amostrasTf,:);                                    % Considera somente as amostras para o tempo especificado
dta = 1/dFa;                                                      % Tempo entre amostras
dTFinal = (length(vtSom)-1)*dta;                                  % Tempo da última amostra do sinal de áudio
vtTSom = 0:dta:dTFinal;                                           % Eixo temporal do arquivo de áudio
subplot(3,1,1);                                                   % Primeiro gráfico do subplot
plot(vtTSom,vtSom);                                               % Plota gráfico do áudio
set(gcf,'color',[1 1 1]);                                         % Configura área da figura
set(gca,'FontWeight','bold','FontSize',12);                       % Configura área do gráfico
title(['Sinal de Áudio']);                                        % Configura título do gráfico
ylabel('Amplitude');                                              % Configura eixo X do gráfico
xlabel('Tempo (s)');                                              % Configura eixo Y do gráfico
p = audioplayer(vtSom, 1*dFa);                                    % Reproduzir arquivo de áudio
play(p);
pause(tf);
% Modifica o arquivo incluindo eco (uma réplica atrasada do sinal oirginal)
n = 1000;                                                          % Atraso da réplica do sinal                                                          
vtSomEco = vtSom + [zeros(n,2); vtSom(1:end-n,:)];                % Geração da réplica e soma com sinal original
subplot(3,1,2);                                                   % Segundo gráfico do subplot
plot(vtTSom,vtSomEco);                                            % Plota gráfico do áudio
set(gcf,'color',[1 1 1]);                                         % Configura área da figura
set(gca,'FontWeight','bold','FontSize',12);                       % Configura área do gráfico
title(['Sinal de Áudio + Réplica']);                              % Configura título do gráfico
ylabel('Amplitude');                                              % Configura eixo X do gráfico
xlabel('Tempo (s)');                                              % Configura eixo Y do gráfico
p = audioplayer(vtSomEco, 1*dFa);                                 % Reproduzir arquivo de áudio
play(p);
subplot(3,1,3);                                                   % Terceiro gráfico do subplot
plot(vtTSom,vtSom-vtSomEco); 
% Plota gráfico do áudio
set(gcf,'color',[1 1 1]);                                         % Configura área da figura
set(gca,'FontWeight','bold','FontSize',12);                       % Configura área do gráfico
title(['Sinal Réplica']);                                         % Configura título do gráfico
ylabel('Amplitude');                                              % Configura eixo X do gráfico
xlabel('Tempo (s)');                                              % Configura eixo Y do gráfico
p = audioplayer(vtSomEco-vtSom, 1*dFa);                                 % Reproduzir arquivo de áudio
play(p);