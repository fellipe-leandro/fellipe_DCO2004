

clear all;close all;      % Limpa variáveis e fecha todos os gráficos
% Parâmetros da onda
tf = 1;                   % Tempo de duração da nota
fc = 512;                 % Frequência da nota Dó
fs = 50*fc;              % Frequência de amostragem da nota. 
t = 0:1/fs:tf;            % Vetor tempo. Para cada elemento do vetor t, haverá um elemento em y correspondente.
A = 1;                    % Amplitude do sinal
y=A*cos(2*pi*fc*t);
y1=A*cos(2*(9/8)*pi*fc*t);
y2=A*cos(2*(5/4)*pi*fc*t);
y3=A*cos(2*(4/3)*pi*fc*t);
y4=A*cos(2*(3/2)*pi*fc*t);
y5=A*cos(2*(5/3)*pi*fc*t);
y6=A*cos(2*(15/8)*pi*fc*t);
y7=A*cos(2*(2)*pi*fc*t);


p = audioplayer(y, fs);   % Reproduzir o sinal gerado
play(p);                  % Reproduzir o sinal gerado
pause(tf);                % Forçar uma pausa com a duração do som a ser escutado
plot(t,y,t,y1,t,y2,t,y3,t,y4,t,y5,t,y6,t,y7);                % Visualizar o sinal gerado  
axis([0 0.02 -2 2 ]);     % Zoom para melhor visualização
legend('Dó','Ré','Mi','Fá','Sol','La','Si','Dó');

