clear all;clc;close all;
dPasso = 5;
dDim = 5000;
nl = (dDim-2*dPasso)/dPasso + 1;
%% Código com laço FOR
% Abre contador de tempo
t1 = tic;
% Matriz com posição de cada ponto do grid (posição relativa ao canto inferior direito)
for il = 1:nl 
    for ic = 1:nl
        px(il,ic) = dPasso + (ic-1)*dPasso;
        py(ic,il) = px(il,ic);
    end
end
% Matrizes de posição e potência recebida
for il = 1:nl
    for ic = 1:nl
        % Matrizes com posição de cada ponto do grid relativa a cada
        % roteador
        pbs0(il,ic) = px(il,ic) + j*py(il,ic) - ( dDim/2 + 0.8*dDim*j);
        pbs1(il,ic) = px(il,ic) + j*py(il,ic) - ( dDim/2 + 0.2*dDim*j);
        % Cálculo da potência recebida em cada ponto do grid, recebida de cada roteador
        pl0(il,ic) = 10*log10(1/abs(pbs0(il,ic))^4/1e-3);
        pl1(il,ic) = 10*log10(1/abs(pbs1(il,ic))^4/1e-3);
        % cálculo da melhor potência em cada ponto do grid
        plf(il,ic) = max(pl0(il,ic), pl1(il,ic));
    end
end
% fecha contador de tempo.
tempoComFor = toc(t1);
disp(['Tempo com Laço FOR = ' num2str(tempoComFor)]);
%% Código sem Laço
% Abre contador de tempo
t2 = tic;
% Matriz com posição de cada ponto do grid (posição relativa ao canto inferior direito)
[px,py] = meshgrid(dPasso:dPasso:dDim-dPasso, dPasso:dPasso:dDim-dPasso);
% Matrizes com posição de cada ponto do grid relativa a cada BS
pbs0SF = px + j*py - ( dDim/2 + 0.8*dDim*j);
pbs1SF = px + j*py - ( dDim/2 + 0.2*dDim*j);
% Cálculo da potência recebida em cada roteador
pl0SF = 10*log10(1./(abs(pbs0SF).^4)/1e-3);
pl1SF = 10*log10(1./(abs(pbs1SF).^4)/1e-3);
% Cálculo da melhor potência e cada ponto do grid
plfSF = max(pl0SF,pl1SF);
% fecha contador de tempo 2.
tempoSemFor = toc(t2);
disp(['Tempo sem Laço FOR = ' num2str(tempoSemFor)]);
disp(['Diferença percentual de tempo = ' num2str(( tempoSemFor - tempoComFor )/tempoSemFor*100) ' %']);