clc;clear all; close all;
%% Abrindo o guitar.wav - Definições de parâmetros 
[y,fs]=  audioread('../../DCO2004_2019/MATERIAL/HD_02_MATLAB/sound_01.wav');    % Endereço do nosso sinal
timelag = 0.5;                                                  % Atraso do eco
delta = round(fs*timelag);                                      % Inteiro correspondente a posição do eco
alfa = 0.5;                                                     % Define a amplitude do eco "alfa" 

%% Montagem do eco
orig = [y;zeros(delta,1)];                                      % Completa o final do vetor y com zeros
eco = [zeros(delta,1);y]*alfa;                                  % Completa o início do vetor eco com zeros
Yeco = orig + eco;                                              % Soma som original com o eco
t = (0:length(Yeco)-1)/fs;                                      % Definiçao do eixo do tempo com o comprimento do novo vetor Yeco

%% Cálculo do vetor autocorrelação positivo
[Rxx,lags] = xcorr(Yeco,'unbiased');                            % Calcula a autocorrelação normalizada com o comprimento 
Rxx = Rxx(lags>0);                                              % Pega apenas a parte positiva do vetor Rxx
lags = lags(lags>0);                                            % Pega apenas a parte positiva do vetor lags

%% Encontrando e removendo o eco com filtro            
% Teremos que descobrir onde fica na autocorrelação o local do eco (pico da
% correlação). Usaremos a função findpeaks pra encontrar. Porém por ser um 
% sinal periódico, encontraremos vários picos de correlação. Portanto 
% entende-se como local do eco o pico mais distante e de maior altura. 

[~,dl] = findpeaks(Rxx,lags,'MinPeakHeight',1.5e-3);            % Encontra picos num intervalo minimo entre eles de 2x10-3
newdelta= max(dl)-1;                                            % Novo delta (vetor local de eco)
Ynew = filter(1,[1 zeros(1,newdelta-1) alfa],Yeco);             % Filtra no vetor Yeco a partir da posição newdelta o eco

%% Plotting
% Plotta Sinal Original e Sinal filtrado 
% Plota o sinal original
figure(3)
subplot(2,1,1)
plot(t,orig)
title('Sinal Original')
legend('Original')
xlabel('Tempo (s)')
% Plota o sinal filtrado (que deve ser idêntico ao sinal original).
subplot(2,1,2)
plot(t,Ynew)
title('Sinal Filtrado')
legend('Filtrado')
xlabel('Tempo (s)')

%% Plotting vetor da autocorrelação
figure (2)
plot(lags/fs,Rxx)
title('Autocorrelaçao Com Eco')
xlabel('Lag (s)')

%% Plota os vetores do som original e eco no mesmo gráfico
% Plota o som original
figure (1)                                                      
subplot(2,1,1)                                                  
plot(t,[orig eco])
title('Sinal Original e Eco')
legend('Original','Eco')
xlabel('Tempo (s)')
% Plota a soma do som original com eco 
subplot(2,1,2)                                                 
plot(t,Yeco)
title('Soma Dos Sinais')
legend('Total')
xlabel('Tempo (s)')

%% Áudio
% Para ouvir os sons digite:
 soundsc(y,fs);
 soundsc(Yeco,fs);
 soundsc(Ynew,fs);
