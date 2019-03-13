#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Mar 13 12:19:38 2019

@author: fellipe
"""

import warnings                        # Método para suprimir os avisos de exceções 
warnings.filterwarnings('ignore')      # Método para suprimir os avisos de exceções 
# Ex.: divisões por zero, que neste exemplo, não é um problema.

import time                            # Importa a biblioteca para as funções relacionadas a contagem de tempo
start_time_mat = time.clock()          # Primeira medição de tempo: inicia a contagem
dPasso = 5                             # Resolução do grid: distância entre um passo e outro
dDim = 5000                             # Dimensão do grid
nl = (dDim-2*dPasso)/dPasso + 1        # Número de pontos na medição
import numpy as np                     # Importa biblioteca para cálculos numéricos 

x= np.arange(dPasso,dDim-dPasso,dPasso)
y=np.arange(dPasso,dDim-dPasso,dPasso)
X,Y = np.meshgrid(x,y)

# Matrizes com posição de cada ponto do grid relativa a cada roteador
pbs0 = X + 1j*Y - (dDim/2 + 0.8*dDim*1j)
pbs1 = X + 1j*Y - (dDim/2 + 0.2*dDim*1j)
# Cálculo da potência recebida em cada ponto do grid recebida de cada roteador
pl0 = 10*np.log10(1/(np.absolute(pbs0)**4)/0.001)
pl1 = 10*np.log10(1/(np.absolute(pbs1)**4)/0.001)
plf = np.maximum(pl0,pl1)
# Medição de tempo de execução sem laço FOR
stop_time_mat = time.clock()
tempo_de_execucao_mat = stop_time_mat - start_time_mat

# Abertura de timer para o laço FOR
start_time_for = time.clock()

nl = (dDim-2*dPasso)/dPasso + 1        # Número de pontos na medição
import numpy as np                     # Importa biblioteca para cálculos numéricos 
# nl não é do tipo inteiro, e precisa ser na definição de px e py a seguir.
# Sugestão: comente a linha abaixo e observe a exceção que o interpretador/Python irá levantar
NL = int(nl)                       
px = np.ndarray([NL,NL],dtype=complex) # Criação de matriz de complexos (não inicializada)
py = np.ndarray([NL,NL],dtype=complex) # Criação de matriz de complexos (não inicializada)
# Montagem da Matriz com posição de cada ponto do grid (posição relativa ao canto inferior direito)
for i in range(NL):                    # Laço de 0 até NL-1
    for j in range(NL):                # Laço de 0 até NL-1
        px[i,j] = dPasso + j*dPasso    # j é a variável do iterador, sem relação com o complexo
        py[j,i] = px[i,j]

# Criação de matrizes de posição e potência recebida (não inicializadas)
pbs0 = np.ndarray([NL,NL], dtype=complex)
pbs1 = np.ndarray([NL,NL], dtype=complex)
pl0  = np.ndarray([NL,NL])
pl1  = np.ndarray([NL,NL])
plf  = np.ndarray([NL,NL])

for i in range(NL):
    for j in range(NL):
# Matrizes com posição de cada ponto do grid relativa a cada roteador
        pbs0[i,j] = px[i,j]+ 1j*py[i,j] - ( dDim/2 + 0.8*dDim*1j)
        pbs1[i,j] = px[i,j]+ 1j*py[i,j] - ( dDim/2 + 0.2*dDim*1j)
# Cálculo da potência recebida em cada ponto do grid recebida de cada roteador
        pl0[i,j]=  10*np.log10(1/(np.absolute(pbs0[i,j])**4)/0.001)
        pl1[i,j]=  10*np.log10(1/(np.absolute(pbs1[i,j])**4)/0.001)
# Cálculo da melhor potência em cada ponto do grid
        plf[i,j] = max(pl0[i,j],pl1[i,j])               
# Fim dos laços

# Medição de tempo de execução com laço FOR
stop_time_for = time.clock()
tempo_de_execucao_for = stop_time_for - start_time_for
# Imprimir mensagens na tela
print("Tempo de execução sem laço FOR: "+str(tempo_de_execucao_mat))
print("Tempo de execução com laço FOR: "+str(tempo_de_execucao_for))
dif = 100*(tempo_de_execucao_mat-tempo_de_execucao_for)/tempo_de_execucao_mat
print("Diferença percentual de tempo: "+str(dif)+"%")