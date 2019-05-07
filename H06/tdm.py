#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon May  6 21:47:50 2019

@author: fellipe
"""

from scipy.io import loadmat
import numpy as np
import matplotlib.pyplot as plt
from scipy.fftpack import fft,fftshift,ifft

# Como visto anteriormente, para economizar linhas de código, uma boa prática é resumir a conversão 
# binário/decimal em duas funções:
def de2bi(sinal):
    from numpy import fromiter,binary_repr,round 
    sinal_bin = round(sinal).astype(int)
    return fromiter(map(binary_repr,sinal_bin),dtype=int)
#
def bi2de(sinal):
    from numpy import ndarray
    sinal_dec = ndarray(len(sinal),dtype=int)
    for i in range(len(sinal_dec)):
        sinal_dec[i] = int(str(sinal[i]),2)  
    return sinal_dec
# Criação das funções, por questão de organização
def downsample(array,rate):
    return array[::rate]

def upsample(array,rate):
    from numpy import zeros
    ret =  zeros(rate*len(array))
    ret[::rate] = array 
    return ret
#


variaveis = loadmat('./Pacientes.mat')
Fs=float(variaveis['Fs'])
sinal_1 = variaveis['sinal_1'].flatten()
sinal_2 = variaveis['sinal_2'].flatten()
sinal_3 = variaveis['sinal_3'].flatten()
sinal_4 = variaveis['sinal_4'].flatten()
sinal_5 = variaveis['sinal_5'].flatten()
sinal=np.column_stack((sinal_1,sinal_2,sinal_3,sinal_4,sinal_5))
N_sinal=(len(sinal_1)) #tamanho de cada sinal
n_col=5
t=np.arange(0,N_sinal/Fs,1/Fs) #eixo temporal
N_samp=10
s_out=np.zeros((N_sinal,n_col))
s_out_aux=np.zeros(N_sinal)
for i in range(0,n_col):
    s_out_aux=downsample(sinal[:,i],N_samp)
    s_out[:,i]=upsample(s_out_aux,N_samp)

#Etapa de amostragem:
s1_out=downsample(sinal_1,N_samp)                           # Coleta 1 amostra a cada N_samp=10 amostras do sinal  
s1_out=upsample(s1_out,N_samp)                              # Retorna vetor amostrado com o número inicial de elementos
s2_out=downsample(sinal_2,N_samp)                           # Coleta 2 amostra a cada N_samp=10 amostras do sinal  
s2_out=upsample(s2_out,N_samp)                              # Retorna vetor amostrado com o número inicial de elemento
s3_out=downsample(sinal_3,N_samp)                           # Coleta 2 amostra a cada N_samp=10 amostras do sinal  
s3_out=upsample(s3_out,N_samp)                              # Retorna vetor amostrado com o número inicial de elemento
s4_out=downsample(sinal_4,N_samp)                           # Coleta 2 amostra a cada N_samp=10 amostras do sinal  
s4_out=upsample(s4_out,N_samp)                              # Retorna vetor amostrado com o número inicial de elemento
s5_out=downsample(sinal_5,N_samp)                           # Coleta 2 amostra a cada N_samp=10 amostras do sinal  
s5_out=upsample(s5_out,N_samp)                              # Retorna vetor amostrado com o número inicial de elemento
#Plotagem do sinal amostrado
#plt.figure(1)
#plt.plot(t,s_out[:,0],t,s1_out)
#plt.xlim([0,0.3])
#plt.show()
#Reconstução do sinal original:
lfft=len(s1_out)
BW=550#banda da rect (em pontos da fft)
freq = np.arange(-Fs/2,Fs/2,Fs/lfft)
S1_out=fftshift(fft(s1_out,lfft)/lfft)
S1=fftshift(fft(sinal_1,lfft)/lfft)
#plt.figure(2)
#plt.plot(freq,np.abs(S1_out))
#plt.show()
H_lpf=np.zeros(lfft)                                         # Zera vetor filtro
H_lpf[lfft//2-BW:lfft//2+BW-1]=1                             # Define 1 na frequência desejada
Q1_recv=N_samp*S1_out*H_lpf                                    # Filtragem ideal
q1_recv=np.real(ifft(fftshift(Q1_recv)))                       # Reconstroi o sinal no tempo
q1_recv=q1_recv*np.max(sinal_1)/np.max(q1_recv)                     # Dá ganho pro sinal reconstruído
plt.figure(3)
plt.subplot(311)
plt.plot(freq,abs(S1))
plt.xlim([-50,50])
plt.subplot(312)
plt.plot(freq,abs(Q1_recv))
plt.xlim([-50,50])
plt.subplot(313)
plt.plot(freq,H_lpf)
plt.xlim([-50,50])
#plt.legend(["Sinal Original","Sinal Reconstruido"])

#QUANTIZACAO

L=8 # níveis de quantização
q_out=np.zeros((N_sinal,n_col))
for i in range(0,n_col):
    sig_max=max(s_out[:,i])
    sig_min=min(s_out[:,i])
    Delta=(sig_max-sig_min)/L                       # Intervalo de quantização (distância entre um nível e outro)
    q_level=np.arange(sig_min+Delta/2,sig_max,Delta) # Vetor com as amplitudes dos Q níveis (Ex: nível 4 -- q_level(4)= -0.05V)
    sigp=s_out[:,i]-sig_min                                 # Deixa o sinal somente com amplitudes positivas (shift para cima)
    # Calcula a quantidade de nívels (não inteiro ainda) de cada amostra (elementos >= 0)
    sigp=sigp*(1/Delta)                                
    sigp=sigp + 1/2 +0.0001                          # Tira elementos do zero 
    # Agora que nenhum valor do sinal  é zero nem negativo:
    qindex=np.round(sigp)                            # Encontra inteiro mais proximo para cada elemento
    qindex[qindex>L] = L                           # Trunca o excedente de qindex 
    qindex = qindex.astype(int)                      # Casting para inteiro (garantindo que é do tipo inteiro)
    q_out[:,i]=q_level[abs(qindex-1)]                     # Distribui nos níveis cada elemento 

plt.figure(4)
plt.plot(t,s_out[:,0],t,q_out[:,0])
plt.xlim([0,0.5])
plt.show()





