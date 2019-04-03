#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Apr  3 10:51:00 2019
%Analise de Espectro de arquivos de audio
@author: fellipe
"""
#-----------------------IMPORTACOES E DEFINICOES GLOBAIS----------------------------
soundFile = '../../DCO2004_2019/MATERIAL/HD_03_MATLAB/Flauta.wav'               # Especifica do local e nome do arquivo de áudio
soundFile1 = '../../DCO2004_2019/MATERIAL/HD_03_MATLAB/Violino.wav'

import numpy as np
import scipy.io.wavfile as wv 
import matplotlib.pyplot as plt
import os

#----------------------------//-----------------------------------------------
dFa,vtSom = wv.read(soundFile) 
dta = 1/dFa                                                      # Tempo entre amostras
dTFinal = (len(vtSom)-1)*dta                                     # Tempo da última amostra do sinal de áudio
vtTSom = np.arange(0,dTFinal+dta,dta)                            # Eixo temporal do arquivo de áudio
plt.figure(1,[10,7])
plt.plot(vtTSom,vtSom)                                           # Plota gráfico do áudio
plt.grid(True)

dFa1,vtSom1= wv.read(soundFile1)
dta1=1/dFa1
dTFinal1 = (len(vtSom1)-1)*dta1
vtTSom1 = np.arange(0,dTFinal1+dta1,dta1)
plt.figure(2,[10,7])
plt.plot(vtTSom1,vtSom1)
plt.grid(True)
           
#Analise frequencial
lfft = 1000
yfft = np.fft.fft(vtSom,lfft)/lfft  
yfft1 = np.fft.fft(vtSom1,lfft)/lfft                           
freq1 = np.arange(0,dFa/2,dFa/lfft)                             # Definição do eixo das frequências unilateral
yfftuni = np.abs(yfft[0:lfft//2])  
yfftuni1 = np.abs(yfft1[0:lfft//2])                                  # Coleta da FFT unilateral
plt.figure(3,[10,7])
#plt.stem(freq1,(yfftuni)/max(yfftuni),'r',markerfmt='ro')                              # Plotagem do espectro unilateral M(f)
plt.stem(freq1,yfftuni1/max(yfftuni1),'b',markerfmt='bo')
plt.title('Espectro')                             # Configuração do título do gráfico 
plt.xlabel('Frequencia')                               # Configuração do eixo x do gráfico 
plt.ylabel('Amplitude Nomalizada')                                         # Configuração do eixo y do gráfico  
plt.grid()                                                   # Adiona o grid  
plt.axis([0,5000,0,1.1])                                      # Zoom do gráfico
plt.legend(['Flauta','Violino'])
plt.show()

