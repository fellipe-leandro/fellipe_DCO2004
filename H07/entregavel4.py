#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon May 20 10:43:56 2019

@author: fellipe
"""
# Geração de Variável aleatória
import numpy as np
from scipy.stats import randint
import matplotlib.pyplot as plt
#
# Parâmetros da distribuição discreta uniforme
low = 1                                            # Média
high = 7                                          # Desvio padrâo
vtnSamples = [1e2, 1e3, 1e5]                       # Número de amostras
vtSamples = np.random.randint(low,high,int(np.max(vtnSamples))) #Return random integers from low (inclusive) to high (exclusive).
for ik in range(0,len(vtnSamples)):
    nSamples = int(vtnSamples[ik])
    plt.figure(1,[15,5])
    plt.subplot('{}1{}'.format(len(vtnSamples),ik+1))
    # PDF estimada
    binWidth = 1
    vtCurrentS = vtSamples[:nSamples]
    vtBins = np.arange(np.min(vtCurrentS),np.max(vtCurrentS),binWidth)     
    y, x = np.histogram(vtCurrentS,vtBins)                        
    plt.plot(x[1:len(x)],y/(binWidth*nSamples),'ko', ms=8, label='PDF Estimada para N = {}'.format(nSamples))
    plt.vlines(x[1:len(x)], 0, y/(binWidth*nSamples), colors='k', lw=1, alpha=0.5)
    # PDF real
    plt.plot(x[1:len(x)], randint.pmf(x[1:len(x)],low,high),'bo', ms=8,label='PDF Real')
    plt.vlines(x[1:len(x)], 0, randint.pmf(x[1:len(x)], low, high), colors='k', lw=1, alpha=0.5)
    
    plt.legend()
plt.show()

