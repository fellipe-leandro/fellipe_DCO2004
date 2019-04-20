

clc; clear all; close all;
%% Determinando os parâmetros da onda
tau = 1e-4;                                                     % Constante de tempo do detector de envelope
t = [0:999]*1e-6;                                               % Definição do vetor tempo
Ts = 1e-6;                                                      % Definição do período
fc = 10000;                                                     % Frequência da portadora
fm = 1500;                                                      % Frequência do sinal
Mu = 0.6;                                                       % Índice de modulação
x_AMo = (1+Mu*cos(2*pi*fm*t)).*cos(2*pi*fc*t);                  % Onda Modulada AM-DSB

%% Envelope ideal do AM-DSB
x_envIdeal = abs(1+Mu*cos(2*pi*fm*t));

% Detector de envelope.
x_AM = x_AMo.*(x_AMo>0);                                        % Parte positiva da onda AM
x_env = zeros(size(x_AM));                                      % Vetor de zeros vetor pra guardar o envelope
nSamp = length(x_AM);                                           % Número de amostras da onda AM
out = -1;                                                       % Saída inicial (temporária)
%% Cálculo da saida
for i=1:nSamp,
    inp = x_AM(i);
    if (inp>=out)                                               % Caso 1: x_am(t) > Vc(t) (carga do capacitor)
        out = inp;
    else                                                        % Caso 2: x_am(t) < Vc(t) (descarga do capacitor)
        out = out*(1-Ts/tau);
    end
    x_env(i) = out;
end

% Gráfico envoltória ideal
subplot(3,1,1);
plot(1000*t,x_envIdeal);
title('Envoltória ideal');
ylabel('Amplitude');
xlabel('t [ms]');
% Gráfico envoltória ideal
subplot(3,1,2);
plot(1000*t,x_AM,'r');
title('Onda AM retificada');
ylabel('Amplitude');
xlabel('t [ms]');
subplot(3,1,3);
plot(1000*t,x_env,'m');
title('Envoltória recuperada');
ylabel('Amplitude');
xlabel('t [ms]');

% Gráfico composto
figure;
plot(1000*t,x_envIdeal,1000*t,x_AM,1000*t,x_env);
ylabel('Amplitude');
xlabel('t (ms)');
legend('Envoltória ideal','Onda AM retificada','Envoltória recuperada','location','southeast');

