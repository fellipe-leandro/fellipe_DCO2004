close all;clc;clear all;                                          % Limpa variáveis e fecha todos os gráficos
soundFile = ['../../DCO2004_2019/MATERIAL/HD_02_MATLAB/sound_01.wav'];             % Especifica do local e nome do arquivo de áudio
[vtSom, dFa] = audioread(soundFile);                              % Abre arquivo de áudio de um arquivo
vtSom = [vtSom 4*vtSom];
% vtSom: amplitude das amostras de som
% dFa: frequência de amostrasgem do som (amostragem no tempo)
sInfo = audioinfo(soundFile);
dta = 1/dFa;                                                      % Tempo entre amostras
dTFinal = (length(vtSom)-1)*dta;                                  % Tempo da última amostra do sinal de áudio
vtTSom = 0:dta:dTFinal;                                           % Eixo temporal do arquivo de áudio
plot(vtTSom,vtSom(:,1),vtTSom,vtSom(:,2));                                               % Plota gráfico do áudio
set(gcf,'color',[1 1 1]);                                         % Configura área da figura
set(gca,'FontWeight','bold','FontSize',12);                       % Configura área do gráfico
title(['Sinal de Áudio']);                                        % Configura título do gráfico
ylabel('Amplitude');                                              % Configura eixo X do gráfico
xlabel('Tempo (s)');                                              % Configura eixo Y do gráfico
p = audioplayer(vtSom, 1*dFa);                                    % Reproduzir arquivo de áudio
play(p);                                                          % Reproduzir arquivo de áudio
% Mostra informações gerais sobre o arquivo
disp(['Amostragem:']);
disp([' Taxa de amostragem = ' num2str(dFa) ' Hz']);
disp([' Tempo entre amostras = ' num2str(dta) ' Segundos']);
disp(' ');
disp(['Quantização e Codificação:']);
disp([' Número de bits por amostra = ' num2str(sInfo.BitsPerSample) ' bits']);
disp(' ');
disp(['Informações gerais do arquivo de áudio:']);
disp([' Nome do Arquivo = ' sInfo.Filename]);
disp([' Número de canais = ' num2str(sInfo.NumChannels)]);
disp([' Número de amostras = ' num2str(sInfo.TotalSamples) ' amostras']);
disp([' Duração = ' num2str(sInfo.Duration) ' segundos']);