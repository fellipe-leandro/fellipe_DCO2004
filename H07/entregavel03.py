#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat May 18 19:36:19 2019

@author: fellipe
"""

import numpy as np
from scipy import stats
import matplotlib.pyplot as plt 
# Distribuição
T=0.00001                                      # Taxa de amostragem
my_lambda1=2
my_lambda2=5
Tf=4
x=np.arange(0,Tf+T,T)                        # Eixo x       
ExpNorm1=stats.expon.pdf(x,scale=1/my_lambda1)
ExpNorm2=stats.expon.pdf(x,scale=1/my_lambda2)
# Cálculo da probabilidade
limite_esquerdo = np.round(3/T)
limite_direito = np.round(Tf/T)
indices = np.arange(limite_esquerdo+1,limite_direito,dtype=np.int64)
prob1=np.sum(ExpNorm1[indices])*T*100        # Probabilidade de um evento ocorrer no intervalo
prob1_1=np.sum(ExpNorm2[indices])*T*100        # Probabilidade de um evento ocorrer no intervalo
plt.figure(1,[8,6])
plt.plot(x,ExpNorm1,'k')                                       
plt.title('OP.1: Probabilidade de = ' + str(prob1))      # Mostra valor verdadeiro de prob1
plt.fill_between(x[indices],ExpNorm1[indices],facecolor='midnightblue')
plt.figure(2,[8,6])
plt.plot(x,ExpNorm2,'k')                                       
plt.title('OP.2: Probabilidade de = ' + str(prob1_1))      # Mostra valor verdadeiro de prob1
plt.fill_between(x[indices],ExpNorm2[indices],facecolor='midnightblue')
#plt.show()
# calculando diretamente da integral
from sympy import *
init_printing(use_unicode=False, wrap_line=False, no_global=True)
x, f1,f2 = symbols('x f1 f2')
expoente1=-my_lambda1*x
expoente2=-my_lambda2*x
f1 = my_lambda1*exp(-my_lambda1*x)
f2 = my_lambda2*exp(-my_lambda2*x)
prob2 = N(integrate(f1, (x,3,np.Inf)))
prob2_1 = N(integrate(f2, (x,3,np.Inf)))
print("OP.1::::")
print("Probabilidade pela área da PDF = "+str(prob1)+" %")
print("Probabilidade pela formula da PDF =  {:02.4f} %" .format(prob2*100))
print("OP.2:::::")
print("Probabilidade pela área da PDF = "+str(prob1_1)+" %")
print("Probabilidade pela formula da PDF =  {:02.8e} %" .format(prob2_1*100))