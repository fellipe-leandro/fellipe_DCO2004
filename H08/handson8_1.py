#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon May 27 11:24:57 2019

@author: fellipe
"""

# AWGN_Real.m
## Parâmetros
import numpy as np
import statsmodels.api as sm
import matplotlib.pyplot as plt
from scipy import fftpack 
import scipy.io.wavfile as wv
#
SNR_dB = 10     
#Ts=0.0001                           # Determina o valor da SNR em dB
Fs=15*512
Ts=1/Fs
t = np.arange(0,5+Ts,0.0001)                      # Eixo do tempo
A = 15                                         # Amplitude do sinal de entrada x(t)
x=A*np.cos(2*np.pi*512*t)                       # Sinal qualquer x(t)
#
## Montagem do vetor ruído 
N = len(x)                                     # Calcula o comprimento de x
Ps = np.sum(np.abs(x)**2)/N                    # Calcula a potência do sinal
SNR = 10**(SNR_dB/10)                          # Calcula a SNR linear
Pn = Ps/SNR                                    # Calcula a potência do ruído
noiseSigma = np.sqrt(Pn)                       # Desvio padrão  para ruído AWGN (amostras reais)
# Geração manual das amostras de ruído 
media = 0.0
desvio_padrao=1.0
n = np.random.normal(media,noiseSigma,N)       # Amostras de ruído 
y = x + n                                      # Sinal Ruidoso
#
# Estimação da SNR pelas amostras do sinal recebido
pTx = (np.linalg.norm(x)**2)/N                 # Potência do sinal x(t)
pNe = (np.linalg.norm(n)**2)/N                 # Potência estimada do ruído
SNR1 = pTx/pNe;                                # Estimação da SNR linear
SNR1= 10*np.log10(SNR1)                        # SNR em dB
#
# Mostrar informações
print('Estimação de SNR: ')
print('   SNR de entrada: {} dB'.format(SNR_dB))
print('   SNR de entrada: {} dB'.format(SNR1))

#Analise Frequencial
lfft = len(y)                                           # Comprimento do sinal DSB
lfft = int(2**np.ceil(np.log2(lfft)))                      # Comprimento do sinal em potencia de 2
freq=np.arange(-Fs/2,Fs/2,Fs/lfft)                         # Eixo das frequências
espectro=np.abs(fftpack.fftshift(fftpack.fft(y,lfft)))/lfft     # FFT da onda modulante original
plt.figure(1)
#plt.stem(freq,espectro)
plt.xlabel('Frequência [Hz]')
plt.xlim([0,100])
#plt.stem(freq,espectro)

#Analise da autocovariancia normalizada:
a_cov=sm.tsa.stattools.acovf(n)
plt.figure(2)
nlags=np.arange(0,1000)
plt.plot(nlags,a_cov[0:1000]/np.max(a_cov))
plt.show()
#Ouvindo os sinais:
wv.write('./original.wav',int(Fs),x.astype('int16'))
wv.write('./com_ruido.wav',int(Fs),y.astype('int16'))
wv.write('./ruido.wav',int(Fs),n.astype('int16'))


### Gráficos
#plt.figure(1,[7,5])
##
#plt.subplot(311)
#plt.title("Sinal original")
#plt.plot(t,x)
#plt.xlim([0,1]) 
##
#plt.subplot(312)
#plt.title("Sinal com ruído AWGN")
#plt.plot(t,y)
#plt.xlim([0,1]) 
##
#plt.subplot(313)
#plt.title("Ruído AWGN")
#plt.plot(t,n)
#plt.xlim([0,1]) 
##
#plt.tight_layout()
#plt.show()