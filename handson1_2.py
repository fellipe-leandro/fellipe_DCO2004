#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Mar 13 11:53:10 2019

@author: fellipe
"""

import numpy as np                        # Importa biblioteca para cálculos numéricos 
inicio = 0                                # Início da escala de tempo
PI = np.pi                                # 3.141592653...
N_termos = 100                            # Número de pontos
t = np.arange(inicio,2*PI,2*PI/N_termos)  # Eixo temporal 
cos_t = np.cos(t)                         # Cosseno      
sin_t = np.sin(t)                         # Seno   

import matplotlib.pyplot as plt           # Importa biblioteca gráfica

plt.plot(t,cos_t)                         # Plota cosseno
plt.show()                                # Mostra plot do cosseno
plt.plot(t,sin_t)                         # Plota seno
plt.show()                                # Plota seno