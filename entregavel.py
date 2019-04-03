#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Apr  3 10:51:00 2019
%Analise de Espectro de arquivos de audio
@author: fellipe
"""
#-----------------------IMPORTACOES E DEFINICOES GLOBAIS----------------------------
soundFile = '../../DCO2004_2019/MATERIAL/HD_03_MATLAB/Flauta.wav'               # Especifica do local e nome do arquivo de áudio

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
plt.show()
