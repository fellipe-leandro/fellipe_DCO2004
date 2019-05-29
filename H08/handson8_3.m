% Sinal M-PSK gerado pela função pskmod
M = 2;                                                 % Número de símbolo da modulação
Ns = 10e3;                                           % Número de símbolos simulados
bits2 = randi([0 M-1],Ns,1);

txSig = pskmod(bits2,M);
EbN0_dB = [0,5,20];
figure(1)
for m=1:length(EbN0_dB)
    rxSig = awgn(txSig,EbN0_dB(m));
    if(m==2)
        buffer_bpsk=rxSig;
    end
    subplot(1,3,m);
    plot(rxSig(find(real(rxSig)>0)),'ro');
    hold on;
    plot(rxSig(find(real(rxSig)<=0)),'bs');
    title(['Diagrama de constelaçao: Eb/N0 = ' num2str(EbN0_dB(m)) 'dB']);
    legend('Bit 1 transmitido','Bit 0 transmitido');
    minAx = min([real(rxSig)' imag(rxSig)']);
    maxAx = max([real(rxSig)' imag(rxSig)']);
    axis([minAx maxAx minAx maxAx]);
    fig.PaperUnits = 'inches';
    fig.PaperPosition = [0 0 12 6];

    
end
%%
%Modulação 8-PSK
M = 8;                                                 % Número de símbolo da modulação
Ns = 10e3;                                           % Número de símbolos simulados
bits8 = randi([0 M-1],Ns,1);
txSig = pskmod(bits8,M);
figure(2)
EbN0_dB = [0,5,20];
for m=1:length(EbN0_dB)
    rxSig = awgn(txSig,EbN0_dB(m));
    if(m==2)
        buffer_8psk=rxSig;
     end
    subplot(1,3,m);
    plot(rxSig(find(angle(rxSig)*180/pi>=0 & angle(rxSig)*180/pi<=45)),'ro');
    hold on;
    plot(rxSig(find(angle(rxSig)*180/pi>45 & angle(rxSig)*180/pi<=90)),'bo');
    plot(rxSig(find(angle(rxSig)*180/pi>90 & angle(rxSig)*180/pi<=135)),'ko');
    plot(rxSig(find(angle(rxSig)*180/pi>135 & angle(rxSig)*180/pi<=180)),'mo');
    plot(rxSig(find(angle(rxSig)*180/pi<0 & angle(rxSig)*180/pi>=-45)),'yo');
    plot(rxSig(find(angle(rxSig)*180/pi<-45 & angle(rxSig)*180/pi>=-90)),'go');
    plot(rxSig(find(angle(rxSig)*180/pi<-90 & angle(rxSig)*180/pi>=-135)),'Marker','*','color',[ 0.5    0.5    0.5]);
    plot(rxSig(find(angle(rxSig)*180/pi<-90 & angle(rxSig)*180/pi>=-180)),'co');
    title(['Diagrama de constelaçao: Eb/N0 = ' num2str(EbN0_dB(m)) 'dB']);
    legend('000','001','011','010','100','101','111','110');
    minAx = min([real(rxSig)' imag(rxSig)']);
    maxAx = max([real(rxSig)' imag(rxSig)']);
    axis([minAx maxAx minAx maxAx]);
    fig.PaperUnits = 'inches';
    fig.PaperPosition = [0 0 12 6];

    
end

