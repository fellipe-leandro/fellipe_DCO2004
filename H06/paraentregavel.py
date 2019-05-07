#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon May  6 12:00:32 2019

@author: fellipe
"""


from scipy.io import loadmat
import numpy as np
import matplotlib.pyplot as plt
from scipy.fftpack import fft,fftshift,ifft

# Para diminuir o tamanho do código desse experimento, coletaremos todos os dados Passo 1 da Prática 1
# e trabalharemos com o sinal gerado lá. Todas as variáveis terão o mesmo nome.
# O arquivo .mat deve sempre está na pasta em que o script está. Se necessário, rode o Passo 1 da Prática 1!!!
variaveis = loadmat('./Amostragem.mat')
T = float(variaveis['T'])
lfft = int(variaveis['lfft'])
N_samp = int(variaveis['N_samp'])
S_out = variaveis['S_out'].flatten()
s_out = variaveis['s_out'].flatten()
m_t = variaveis['m_t'].flatten()
t = variaveis['t'].flatten()
freq = variaveis['freq'].flatten()
Bs = fm1 = float(variaveis['fm1'])
N=len(m_t)
L= [8, 32,128];                                 # Níveis de quantização
sig_max=max(m_t)                                     # Encontra pico máximo
sig_min=min(m_t)                                     # Encontra pico mínimo
Pm_t =(np.linalg.norm(m_t)**2)/N # Cálculo da potência no tempo
for il in range(0,len(L)):
    Li = L[il]
    Delta=(sig_max-sig_min)/Li                       # Intervalo de quantização (distância entre um nível e outro)
    q_level=np.arange(sig_min+Delta/2,sig_max,Delta) # Vetor com as amplitudes dos Q níveis (Ex: nível 4 -- q_level(4)= -0.05V)

    sigp=m_t-sig_min                                 # Deixa o sinal somente com amplitudes positivas (shift para cima)
    # Calcula a quantidade de nívels (não inteiro ainda) de cada amostra (elementos >= 0)
    sigp=sigp*(1/Delta)                                
    sigp=sigp + 1/2 +0.0001                          # Tira elementos do zero 
    # Agora que nenhum valor do sinal  é zero nem negativo:
    qindex=np.round(sigp)                            # Encontra inteiro mais proximo para cada elemento
    qindex[qindex>Li] = Li                           # Trunca o excedente de qindex 
    qindex = qindex.astype(int)                      # Casting para inteiro (garantindo que é do tipo inteiro)
    q_out=q_level[abs(qindex-1)]                     # Distribui nos níveis cada elemento 
    #reconstrução de Q_out no dominio da frequencia:
    #FFT do sinal quantizado:
    Q_out=fftshift(fft(q_out,lfft)/lfft)
    BW=10                                                       # Largura de banda de 10
    H_lpf=np.zeros(lfft)                                         # Zera vetor filtro
    H_lpf[lfft//2-BW:lfft//2+BW-1]=1                             # Define 1 na frequência desejada
    Q_recv=N_samp*Q_out*H_lpf                                    # Filtragem ideal
    q_recv=np.real(ifft(fftshift(Q_recv)))                       # Reconstroi o sinal no tempo
    q_recv=q_recv*np.max(m_t)/np.max(q_recv)                     # Dá ganho pro sinal reconstruído

    P_e =(np.linalg.norm(m_t-q_out)**2)/N # Cálculo da potência no tempo
    sqnr = Pm_t/P_e
    sqnr_db = 10*np.log10(sqnr)
    var=4
    plt.figure(1)
    plt.subplot('{}1{}'.format(len(L),il+1))
    plt.plot(t,m_t,t,q_out,t,(m_t-q_out))
    plt.title('Quantização L = {} níveis / SQNR = {:.2f}dB'.format(Li,sqnr_db))
    plt.legend(["Original", "Quantizado", "Erro de Quantização"])
    plt.figure(2)
    plt.subplot('{}1{}'.format(len(L),il+1))
    plt.title('Regeneração L={} níveis'.format(Li))
    plt.plot(t,q_recv,t,m_t,t,abs(m_t-q_recv))
    plt.legend(["Recuperado","Original","Erro"])
    plt.figure(3)
    plt.subplot('{}1{}'.format(len(L),il+1))
    plt.title('Espectro L={} níveis'.format(Li))
    plt.plot(freq,abs(Q_out))
    plt.xlabel("Frequência [Hz]")
    plt.xlim([-50,50])

plt.show()

