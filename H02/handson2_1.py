#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Mar 21 01:08:47 2019

@author: labsim
"""

# Geração, reprodução e plotagem de um tom de áudio
import numpy as np           #importando as bibliotecas necessárias:
import matplotlib.pyplot as plt 
import scipy.io.wavfile as wv 
import os

                             # Parâmetros da onda:
tf = 1                       # Tempo de duração da nota
fc = 512                     # Frequência da nota Dó
fs = 100*fc                  # Frequencia de amostragem da nota. 
t =np.arange(0,tf+1/fs,1/fs) # Vetor tempo. Para cada elemento do vetor t, haverá um elemento em y correspondente.
A = 1                        # Amplitude do sinal
y=A*np.cos(2*np.pi*fc*t)            # Sinal senoidal
y1=A*np.cos(2*np.pi*fc*(9/8)*t)     # Sinal senoidal
y2=A*np.cos(2*np.pi*fc*(5/4)*t)     # Sinal senoidal
y3=A*np.cos(2*np.pi*fc*(4/3)*t)     # Sinal senoidal
y4=A*np.cos(2*np.pi*fc*(3/2)*t)     # Sinal senoidal
y5=A*np.cos(2*np.pi*fc*(5/3)*t)     # Sinal senoidal
y6=A*np.cos(2*np.pi*fc*(15/8)*t)     # Sinal senoidal
y7=A*np.cos(2*np.pi*fc*(2)*t)     # Sinal senoidal

plt.figure(1,figsize=[10,7])                                # cria instância da figura para poder alterar seu tamanho
plt.plot(t,y,t,y1,t,y2,t,y3,t,y4,t,y5,t,y6,t,y7)                # Visualizar o sinal gerado  
plt.axis([0,0.02,-2,2])                             # Zoom para melhor visualização  
plt.legend(['Do','Re','Mi', 'Fa', 'Sol', 'La','Si', 'Do'])
plt.show() 


#importando e armazenando o arquivo de áudio numa variável
som = wv.read('../../DCO2004_2019/MATERIAL/HD_02_MATLAB/sound_01.wav')

#salvando o tom gerado em um arquivo de extensão .wav :
wv.write('./tom_gerado.wav',fs,y)
#reproduzindo o arquivo

os.system('cvlc --play-and-exit ./tom_gerado.wav') 
#vlc chama o programa VLC Audio Player
#'c' serve para que nenhuma interface seja aberta