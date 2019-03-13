#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Mar 13 11:48:11 2019

@author: fellipe
"""

import numpy as np                       # Carrega biblioteca de cálculo numérico
from matplotlib import pyplot as plt     # Carrega biblioteca gráfica
Am = 1.0                                 # Amplitude da onda modulante
fm = 60                                  # Amplitude da onda modulante
ka = 1.0                                 # Índice de modulação
Ac = 2.0                                 # Amplitude da portadora
t = np.linspace(0,1000,1000)             # Eixo do tempo 
fc = 70                                  # Frequência da portadora
mt = Am*np.cos(2*np.pi*fm*t)             # Onda modulante 
st = (Ac + ka*mt)*np.cos(2*np.pi*t*fc)   # Onda modulada
plt.plot(t,st)                           # Monta o gráfico
plt.show()                               # Mostra o gráfico na tela