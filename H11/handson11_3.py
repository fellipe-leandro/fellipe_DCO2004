#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jun 17 11:07:54 2019

@author: fellipe
"""
import numpy as np
import matplotlib.pyplot as plt
from scipy.fftpack import fft,fftshift,ifft
from scipy.special import erfc



# Parâmetros
n_bits = 1000                # Número de bits
T = 500                      # Tempo de símbolo OFDM
Ts = 2                       # Tempo de símbolo em portadora única
K = int(T/Ts)                     # Número de subportadoras independentes
N = int(2*K)                      # DFT de N pontos
EbN0dB= np.arange(-5,14,1)
EsN0dB = EbN0dB + 10*np.log10(4); # 4 bits
EbN0=10**(EbN0dB/10)
EsN0=10**(EsN0dB/10)
#A potência do ruído é sua variância
sigmas=1/(2*EsN0)
#variances=1/(10**(EsN0dB/10))
#sigmas=(variances/2)
#sigmas=np.array([0.5, 0.1, 0])
#sigmas=np.array([0,0.1,1])
#
# Gerar bits aleatórios
dataIn=np.random.rand(n_bits)   # Sequência de números entre 0 e 1 uniformemente distribuídos
dataIn=np.sign(dataIn-.5)          # Sequência de -1 e 1
# Conversor serial paralelo
dataInMatrix = np.reshape(dataIn,(int(n_bits/4),4)) #Trocar Linha por coluna?
#
# Gerar constelaçao 16-QAM
seq16qam = 2*dataInMatrix[:,0]+dataInMatrix[:,1]+1j*(2*dataInMatrix[:,2]+dataInMatrix[:,3]) 
seq16=np.transpose(seq16qam)
# Garantir propriedadade da simetria
X = np.concatenate((seq16, np.conj(seq16[-1::-1])),axis=None)
#
# Construindo xn
xn = np.zeros(N,dtype=np.complex128)
xn=ifft(X)*N/np.sqrt(N)
#xn=np.fft.ifft(fftshift(X),axis=0)
#for n in range(N-1):
#    for k in range (N-1):
#        xn[n] = xn[n] + 1/np.sqrt(N)*X[k]*np.exp(1j*2*np.pi*n*k/N)
    
# 
ber=np.zeros(len(sigmas))
# Loop de variâncias
for ik in range(len(sigmas)):
    # Adição de ruído
    variance = sigmas[ik]
    noise = np.sqrt(variance)*(np.random.randn(N)+1j*np.sqrt(variance)*np.random.randn(N)) 
    # sinal recebido = xn + ruído 
    rn = xn+noise
    # DFT de rn
    Y = np.zeros(K,dtype=np.complex128)
    Y1 = np.zeros(K,dtype=np.complex128)
    Y2 = np.zeros(K,dtype=np.complex128)
    Z=np.zeros(K,dtype=np.complex128)
    for k in range(K):
        for n in range(N):
            Y[k] = Y[k] + 1/np.sqrt(N)*rn[n]*np.exp(-1j*2*np.pi*k*n/N);

    
    Y1=fft(rn)/np.sqrt(N)
    Y2=Y1[0:250]
    

    #
    # Plots
#    plt.figure(ik)
#    #plt.subplot(2,1,1)
#    plt.scatter(np.real(Y2),np.imag(Y2),marker='*')
#    plt.scatter(np.real(seq16),np.imag(seq16),marker='+')
#    plt.title('Constalação para $E_b$/$N_0$ = {} dB'.format(EbN0dB[ik]))
#    scatterplot(Y)
#    hold on
#    scatter(real(seq16),imag(seq16), 'r', '+')
#    hold off
#    title(['Sinal com ruído de variância ', num2str(variance)])
    # Demodulação  
    for k in range(len(Y)): # Para percorrer todo o vetor Yk 
        if np.real(Y[k]) > 0: # Para parte real de Yk positiva
            if np.real(Y2[k]) > 2:
                Z[k] = 3
            else:
                Z[k] = 1
#            end
        else: # Para parte real de Yk negativa ou igual a zero
            if np.real(Y2[k]) < -2:
                 Z[k] = -3
            else:
                 Z[k] = -1
#            end
#        end
#
        if np.imag(Y2[k]) > 0: # Para parte imaginaria de Yk positiva
            if np.imag(Y2[k]) > 2:
                Z[k] = Z[k] + 1j*3
            else:
                Z[k] = Z[k] + 1j
#            end
        else: # Para parte imaginaria de Yk negativa ou igual a zero
            if np.imag(Y2[k]) < -2:
                 Z[k] = Z[k] - 1j*3
            else:
                 Z[k] = Z[k] - 1j
#       
    comp=(Z[1:K]-X[1:K])
    
    erro=0
    for idx in range(len(comp)):
        if np.abs(comp[idx])!=0:
            erro=erro+1  
    
#    a = np.where((Z-X[0:K]) != 0)
#    h=X[0:K]
#    erro = len(np.where((Z[i] == h[i] for i in range(len(Z))) is False))
    ber[ik]=erro/K
    
    
    print('Para variância de {}, houve {} simbolos errados'.format(variance,erro))
#            end
#        end
#    end
#plt.figure(len(sigmas)+1)
plt.figure(2)
plt.semilogy(EbN0dB,ber,'r*',label='BER')
M=16 #16-QAM
k=4 # 16=4^2
Pe_teo=2*(1-1/np.sqrt(M))*erfc(np.sqrt(3/2*k*EbN0/(M-1)))
plt.semilogy(EbN0dB,Pe_teo,'k-',label='P_e')
plt.title("$E_b$/N_0 Vs BER para OFDM+AWGN")
plt.xlabel('Eb/N0(dB)')
plt.legend()
plt.grid()
plt.ylabel('Bit Error Rate or P_e')
# Contagem de erro
plt.show()
#error = Z[1:K]-X[1:K]

#    disp(['Para variância de ', num2str(variance), ' houve ', num2str(error), ' símbolos errados.'])