#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Apr 17 23:59:02 2019

@author: labsim/fellipe
Calculo da potencia de um sinal AM-DSB

"""
#Importando bibliotecas
import numpy as np
import matplotlib.pyplot as plt
from scipy import fftpack
import scipy.signal as sci


# Parâmetros do sinal
Ac = 2                                                         # Amplitude da portadora
Mu = 1                                                       # Índice de modulação
fc = 25000                                                     # Frequência da portadora Hz
fm = 2000
N = 1000
Ts = 1e-6                                                      # Tempo de amostragem pequeno (modelar sinal contínuo)
Fs=1/Ts
t = np.arange(N)*Ts
s = Ac*(1+Mu*np.cos(2*np.pi*fm*t))*np.cos(2*np.pi*fc*t)

#Calculando o valor teorico:
P_teorico=Ac**2/2+ (Ac**2*Mu**2)/8+ (Ac**2*Mu**2)/8
print('Potencia teorica = ',P_teorico)
from spectrum.window import Window
hamming = Window(len(s),name='hamming')
f,pxx = sci.periodogram(s,window=hamming.data,fs=Fs,nfft=len(s),scaling='spectrum')
#pwrest = pxx.max()
#idx = pxx.argmax()
plt.plot(f/1e3,pxx)
plt.title('Periodograma')
plt.xlabel('Frequencia [kHz]')
plt.ylabel('Potencia [W]')
plt.tight_layout()
plt.grid()
plt.axis([20,30,0,Ac**2])
plt.show()

#Calculando a potencia pelas amostras
Px_tempo =(np.linalg.norm(s)**2)/N   # Cálculo da potência no tempo
print('Potência via amostras no tempo = ',Px_tempo)
#Conferindo via correlaçao
Rxx=np.correlate(s,s,'full')/N  # Estima a autocorrelaçao de x(n)
Px_Rxx = Rxx[N-1]                    # Cálculo da potência duas bandas via autocorrelação
print('Potência via autocorrelação = ',Px_Rxx)