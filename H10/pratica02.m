%Prática 2: Geração de canal plano com desvanecimento Rice
clc;clear all;close all;
N = 1e6;                                        % Número de amostras a gerar
vtK = [0,5,10];                                   % Fatores K Ricianos a simular
totPower=1;                                          % Total power of LOS path & scattered paths
%
% Loop nos valores de K
for  ik=1:length(vtK)
    K = vtK(ik);
    s=sqrt(K/(K+1)*totPower);                     % Parâmetro de não centralidade
    sigma=totPower/sqrt(2*(K+1));
    % Amostras do Canal Rice
    X = s + sigma*randn(1,N);           % LOS: VA Gaussina com média=s e sigma definido
    Y = 0 + sigma*randn(1,N);                % NLOS: VA Gaussina com média=0 e sigma definido
    Z = X + 1j*Y;
    subplot(length(vtK),1,ik);
    h=histogram(abs(Z),100,'Normalization','pdf');                         % Histograma de Z
    hold on;
    %PDF Rice Teórica
    binWidth=h.BinWidth;
    r = 0:binWidth:h.BinLimits(2);
    % PDF teórica Rayleigh (para comparação)    
    if (K == 0)
        rayleigh_pdf = r./(sigma^2).*exp(-r.^2./(2*sigma^2));
        p1=plot(r,rayleigh_pdf,'g*');
        %legend
        %legend('Rayleigh');
    end
    fRice = 2*r*(K+1)/totPower.*exp(-r.^2*(K+1)/totPower-K).*besseli(0,2*r*sqrt(K*(K+1)/totPower));
    p2=plot(r,fRice,'r','DisplayName',['Rice K= ',num2str(K),'Teórico']);
    if(K==0)
        legend([h,p1,p2],['Rice K= ',num2str(K),' histograma'],'Rayleigh','Rice Teorico');
    else
    legend(['Rice K= ',num2str(K),' histograma'],'Rice Teorico')
    end
    
    
end
