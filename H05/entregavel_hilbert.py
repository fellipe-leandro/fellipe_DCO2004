#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Apr 24 10:05:24 2019

@author: fellipe
"""

# Parâmetros da onda
import numpy as np
from scipy.signal import hilbert
from scipy import fftpack 
import matplotlib.pyplot as plt

# Sinal em banda-base
fs = 600                                                  # frequencia de amostragem
Ts = 1/fs
t = np.arange(600)*Ts
fm = 3
fc = 50
Mu=0.7                                                   #indice de modulacao
Ac=1                                                    #amplitude da portadora
x_AM = Ac*(1.0+Mu*np.cos(2*np.pi*fm*t))*np.cos(2*np.pi*fc*t);  # Onda Modulada AM-DSB
carrier_org=Ac*np.cos(2*np.pi*fc*t)


# Hilbert
z= hilbert(x_AM)                                             # Sinal analítico (real + imaginário)
x_env = np.abs(z)
inst_phase = np.unwrap(np.angle(z))#inst phase
carrier_reg=np.cos(inst_phase)

#Analise do espectro
lfft = len(x_AM)                                           # Comprimento do sinal DSB-SC
lfft = int(2**np.ceil(np.log2(lfft)))                      # Comprimento do sinal DSB-SC potência de dois
m=Mu*Ac*np.cos(2*np.pi*fm*t)                               #sinal modulante
freq=np.arange(-fs/2,fs/2,fs/lfft)
# Onda Modulada AM-DSB-SC na Frequência
X_m=np.abs(fftpack.fftshift(fftpack.fft(m,lfft)))/lfft 
X_AM = np.abs(fftpack.fftshift(fftpack.fft(x_AM,lfft)))/lfft 
X_demodulado = np.abs(fftpack.fftshift(fftpack.fft(x_env,lfft)))/lfft 
#Portadora

# Gráficos
plt.figure(1)
plt.title('Demodulação AM com transformada de Hilbert')
plt.xlabel('Tempo [s]')
plt.ylabel('Amplitude')
plt.plot(t,x_AM,t,x_env)
plt.ylim([-2,2])
plt.xlim([0,1])
plt.legend(['s(t)','envoltoria'])


plt.figure(2)
plt.title('Espectro Demodulação')
plt.xlabel('Frequência [Hz]')
plt.ylabel('Amplitude [abs]')
plt.plot(freq,X_m,freq,X_demodulado)
plt.xlim([-10,10])
plt.legend(['M(f)','M(f)_reg'])
#plt.show()

plt.figure(3)
plt.title('Espectro Modulação')
plt.xlabel('Frequência [Hz]')
plt.ylabel('Amplitude [abs]')
plt.plot(freq,X_AM)
plt.xlim([-80,80])
plt.legend(['S(f)'])

plt.figure(4)
plt.title('Portadora')
plt.xlabel('Frequência [Hz]')
plt.ylabel('Amplitude')
plt.plot(t,carrier_org,t,carrier_reg)
plt.legend(['c(t)','c(t)_reg'])
plt.show()

