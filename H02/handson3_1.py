#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Mar 25 10:58:11 2019

@author: fellipe
"""

soundFile = '../../DCO2004_2019/MATERIAL/HD_02_MATLAB/sound_01.wav'               # Especifica do local e nome do arquivo de áudio

import numpy as np
import scipy.io.wavfile as wv 
import os
import matplotlib.pyplot as plt


dFa,vtSom = wv.read('/home/fellipe/DCO2004_2019/MATERIAL/HD_02_MATLAB/sound_01.wav')                                   # Abre arquivo de áudio de um arquivo
#vtSom = 4.0*vtSom
vtSomint16 = vtSom.astype('int16')                               #converte de float64 para int16 para reduzir ruído
# vtSom: amplitude das amostras de som
# dFa: frequência de amostrasgem do som (amostragem no tempo)

dta = 1/dFa                                                      # Tempo entre amostras
dTFinal = (len(vtSom)-1)*dta                                     # Tempo da última amostra do sinal de áudio
vtTSom = np.arange(0,dTFinal+dta,dta)                            # Eixo temporal do arquivo de áudio
plt.figure(1,[10,7])
plt.plot(vtTSom,vtSom)                                           # Plota gráfico do áudio

font = {'family' : 'DejaVu Sans','weight' : 'bold','size': 12}   #Configura a fonte do título
plt.rc('font', **font)
plt.title('Sinal de Áudio')                                      # Configura título do gráfico
plt.ylabel('Amplitude')                                          # Configura eixo X do gráfico
plt.xlabel('Tempo (s)')                                          # Configura eixo Y do gráfico
plt.ylim([-32000*4,25000*4])
plt.show()
wv.write('./tom_corda.wav',22050,vtSom)

# Reproduz arquivo de áudio
os.system('cvlc --play-and-exit ../../DCO2004_2019//MATERIAL/HD_02_MATLAB/sound_01.wav')           
# Mostra informações gerais sobre o arquivo
print('Amostragem:')
print(' Taxa de amostragem = ',dFa,' Hz')
print(' Tempo entre amostras = ',dta,' Segundos')
print(' ')
print('Quantização e Codificação:')
print(' ')
print('Informações gerais do arquivo de áudio:')
print(' Número de canais = ',vtSom.shape)  
print(' Número de amostras = ',len(vtSom),' amostras')
print(' Duração = ',len(vtSom)*dta,' segundos')