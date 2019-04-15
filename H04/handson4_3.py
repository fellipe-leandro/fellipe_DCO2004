#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Apr 15 11:48:51 2019

@author: fellipe
"""

import numpy as np
import time
## Parâmetros do sinal 
fc=0.04                              # Frequência do seno
Fs=1                                 # Frequência de amostragem
Ts = 1/Fs                            # Tempo entre amostras
A = 10                               # Amplitude do sinal
nC = 2000                            # Número de períodos da onda   
t=np.arange(0,nC/fc,Ts)              # Vetor tempo
x=A*np.cos(2*np.pi*fc*t)             # Gera o sinal x(n)
N = len(x)                           # Número de amostras do sinal
sT1 = time.clock() 
Px_tempo =(np.linalg.norm(x)**2)/N   # Cálculo da potência no tempo
print('Potência via amostras no tempo = ',Px_tempo,time.clock()-sT1,' segundos para calcular.')

sT2 =time.clock()
Nfft = 1000                          # Número de pontos da FFT
Xfft=np.fft.fft(x,Nfft)              # Encontra a FFT
Xfft = Xfft/Nfft                     # Encontra a FFT 
Px_fft = np.sum(Xfft*np.conj(Xfft))  # Cálculo da potência na frêquencia
print('Potência via FFT (Parseval) = ',abs(Px_fft),time.clock()-sT2,' segundos para calcular.' )

sT3 =time.clock()
Rxx=np.correlate(x,x,'full')/len(x)  # Estima a autocorrelaçao de x(n)
Px_Rxx = Rxx[N-1]                    # Cálculo da potência duas bandas via autocorrelação
print('Potência via autocorrelação = ',Px_Rxx,time.clock()-sT3, ' segundos para calcular.' )

sT4 =time.clock()
Pvar = np.var(x)                     # Cálculo da potência duas bandas via variancia
print('Potência via variância = ',Pvar,time.clock()-sT4,' segundos para calcular.' )