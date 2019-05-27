#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon May 27 10:39:41 2019

@author: fellipe
"""

#from scipy.io import loadmat
#import numpy as np
#import matplotlib.pyplot as plt
##Carregando parametros
#variaveis = loadmat('./Pratica_08_sinal_real.mat')
#Am=int(variaveis['Am'])
#fm=int(variaveis['fm'])
#fs=int(variaveis['fs'])
#y=variaveis['y'].flatten()
#N=len(y)
#t=np.arange(0,N/fs,1/fs)
##Construindo Sinal Original
#x_orig=Am*np.cos(2*np.pi*fm*t)
##Calculando Potencia do sinal original
#P_x=(np.linalg.norm(x_orig)**2)/N
##Como y=x+n => n=y-x
#n=y-x_orig
#P_n=(np.linalg.norm(n)**2)/N
#SNR=P_x/P_n
#SNR_dB=10*np.log10(SNR)
##Plotagens
#plt.figure(1,[20,20])
#plt.subplot(3,1,1)
#plt.plot(t,x_orig)
#plt.title('Sinal Original')
#plt.xlabel('t[s]')
#plt.subplot(3,1,2)
#plt.plot(t,y)
#plt.title('Sinal Recebido: SNR = ' + str(SNR_dB) + 'dB')
#plt.xlabel('t[s]')
#plt.subplot(3,1,3)
#plt.plot(t,n)
#plt.title('Ruído AWGN')
#plt.xlabel('t[s]')
#plt.show()
from scipy.io import loadmat
import numpy as np
import matplotlib.pyplot as plt
#Carregando parametros
variaveis = loadmat('./Pratica_08_sinal_complexo.mat')
Ar=int(variaveis['Ar'])
Ai=int(variaveis['Ai'])
fm=int(variaveis['fm'])
fs=int(variaveis['fs'])
y=variaveis['y'].flatten()
N=len(y)
t=np.arange(0,N/fs,1/fs)
#Construindo Sinal Original
x_orig=Ar*np.cos(2*np.pi*fm*t)+1j*Ai*np.cos(2*np.pi*fm*t)
#Calculando Potencia do sinal original
P_x=(np.linalg.norm(x_orig)**2)/N
#Como y=x+n => n=y-x
n=y-x_orig
P_n=(np.linalg.norm(n)**2)/N
SNR=P_x/P_n
SNR_dB=10*np.log10(SNR)
#Plotagens
plt.figure(1,[20,20])
plt.subplot(3,1,1)
plt.plot(t,np.abs(x_orig))
plt.title('Sinal Original')
plt.xlabel('t[s]')
plt.subplot(3,1,2)
plt.plot(t,np.abs(y))
plt.title('Sinal Recebido: SNR = ' + str(SNR_dB) + 'dB')
plt.xlabel('t[s]')
plt.subplot(3,1,3)
plt.plot(t,np.abs(n))
plt.title('Ruído AWGN')
plt.xlabel('t[s]')
plt.show()




