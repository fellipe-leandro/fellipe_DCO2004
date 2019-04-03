#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Apr  3 10:25:00 2019

@author: fellipe
"""

import warnings                                      # Método para suprimir os avisos de exceções 
warnings.filterwarnings('ignore')                    # Método para suprimir os avisos de exceções

import numpy as np
import matplotlib.pyplot as plt
import time
## Geração do sinal cosenoidal
fsampling = 10                                       # Taxa de amostragem
T =1/fsampling                                       # Tempo entre amostras
L = 2000                                             # Número de amostras
t = np.arange(0,(L-1)*T+1/fsampling,1/fsampling)     # Eixo do tempo
fm = 0.04                                            # Frequência da senoide
Am = 2                                               # Amplitude da senoide
m = Am*np.cos(2*np.pi*fm*t)                          # Sinal senoidal
t1=time.clock()                                      # Contador de tempo

## Montando a DFT
N=len(m)                                             # Comprimento do sinal m(t)
n=np.arange(0,N)                                     # Vetor n
k=np.arange(0,N)                                     # Vetor k
WN=np.exp(-1j*2*np.pi/N)                             # Cálculo de Wn = e^{-j2pi/N}
nn=np.outer(n,k)                                     # Monta a Matriz DFT
WNnk=WN**nn                                          # Monta a Matriz DFT
X=np.inner(m,WNnk.T/L)                               # Implementa o somatório da DFT via operação matricial    
f = fsampling/2*np.linspace(0,1,(L/2)+1)             # Monta o eixo das frequências
tempo_DFT=time.clock() - t1                          # Conta tempo de execução até esse ponto do código
print('Tempo da DFT = ',tempo_DFT,'s')               # Mostra tempo de execução
plt.stem(f,2*np.abs(X[0:L//2+1]))                     # Mostra gráfico do espectro 
plt.axis([0,0.1,0,2.2])                              # Zoom para melhor visualização 
plt.show()                      # Zoom em dois períodos da onda


# A função 'whos' é responsável por mostrar todas as variáveis que foram criadas no workspace,
# identificando suas principais caracteristicas.