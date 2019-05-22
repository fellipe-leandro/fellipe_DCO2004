#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed May 15 11:05:01 2019

@author: fellipe
"""
LOGNORM
import numpy as np
from scipy.stats import lognorm
import matplotlib.pyplot as plt
#
# Parâmetros da distribuição
vtMu = [0, 1, 2]                  # Valores de média da Gaussiana
vtVar = [1, 5, 13]                   # Valores de variância da Gaussiana
x = np.arange(-20,20,0.1)     
#
# Variando a média e plotando os gráficos
plt.figure(1,[15,5])
sigma = np.sqrt(vtVar[0]);
for il in range(0,len(vtMu)):
    mu = vtMu[il]
    plt.subplot(2,2,1)
    plt.plot(x, lognorm.pdf(x,s=sigma,scale=np.exp(mu)), label='Média = {}'.format(mu))
    plt.subplot(2,2,2)
    plt.plot(x, lognorm.cdf(x,s=sigma,scale=np.exp(mu)), label='Média = {}'.format(mu))
# Variando a variância e plotando os gráficos
mu = vtMu[0];
for il in range(0,len(vtVar)):
    sigma = np.sqrt(vtVar[il]);
    plt.subplot(2,2,3)
    plt.plot(x, lognorm.pdf(x,s=sigma,scale=np.exp(mu)), label='$\sigma$ = {:01.2f}'.format(sigma))
    plt.subplot(2,2,4)
    plt.plot(x, lognorm.cdf(x,s=sigma, scale=np.exp(mu)), label='$\sigma$ = {:01.2f}'.format(sigma))
        
plt.subplot(2,2,1)
plt.legend()
plt.subplot(2,2,2)
plt.legend()
plt.subplot(2,2,3)
plt.legend()
plt.subplot(2,2,4)
plt.legend()
plt.show()

import numpy as np
from scipy.stats import rayleigh
import matplotlib.pyplot as plt
#
# Parâmetros da distribuição
vtMu = [0, -10, 10]                  # Valores de média da Gaussiana
vtVar = [1, 5, 10]                   # Valores de variância da Gaussiana
x = np.arange(-20,20,0.1)     
#
# Variando a média e plotando os gráficos
#plt.figure(1,[15,5])
#sigma = np.sqrt(vtVar[0]);
#for il in range(0,len(vtMu)):
#    mu = vtMu[il]
#    plt.subplot(2,2,1)
#    plt.plot(x, norm.pdf(x,mu), label='Média = {}'.format(mu))
#    plt.subplot(2,2,2)
#    plt.plot(x, norm.cdf(x,mu), label='Média = {}'.format(mu))
# Variando a variância e plotando os gráficos
mu = vtMu[0];
for il in range(0,len(vtVar)):
    sigma = np.sqrt(vtVar[il]);
    plt.subplot(2,1,1)
    plt.plot(x, rayleigh.pdf(x,scale=sigma), label='$\sigma$ = {:01.2f}'.format(sigma))
    plt.subplot(2,1,2)
    plt.plot(x, rayleigh.cdf(x,scale=sigma), label='$\sigma$ = {:01.2f}'.format(sigma))
        
#plt.subplot(2,2,1)
#plt.legend()
#plt.subplot(2,2,2)
#plt.legend()
plt.subplot(2,1,1)
plt.legend()
plt.subplot(2,1,2)
plt.legend()
plt.show()

import numpy as np
from scipy.stats import expon
import matplotlib.pyplot as plt
#
# Parâmetros da distribuição
vtMu = [1.5,2,4]                  # Valores de média da Gaussiana
vtVar = [1.5,2,4]                   # Valores de variância da Gaussiana
x = np.arange(-20,20,0.1)     
#
# Variando a média e plotando os gráficos
#plt.figure(1,[15,5])
#sigma = np.sqrt(vtVar[0]);
#for il in range(0,len(vtMu)):
#    mu = vtMu[il]
#    plt.subplot(2,2,1)
#    plt.plot(x, norm.pdf(x,mu), label='Média = {}'.format(mu))
#    plt.subplot(2,2,2)
#    plt.plot(x, norm.cdf(x,mu), label='Média = {}'.format(mu))
# Variando a variância e plotando os gráficos
mu = vtMu[0];
for il in range(0,len(vtVar)):
    sigma = (vtVar[il]);
    plt.subplot(2,1,1)
    plt.plot(x, expon.pdf(x,scale=1/sigma), label='$\lambda$ = {:01.2f}'.format(sigma))
    plt.xlim([0,10])
    plt.subplot(2,1,2)
    plt.plot(x, expon.cdf(x,scale=1/sigma), label='$\lambda$ = {:01.2f}'.format(sigma))
    plt.xlim([0,10])
        
#plt.subplot(2,2,1)
#plt.legend()
#plt.subplot(2,2,2)
#plt.legend()
plt.subplot(2,1,1)
plt.legend()
plt.subplot(2,1,2)
plt.legend()

plt.show()
import numpy as np
from scipy.stats import nakagami
import matplotlib.pyplot as plt
#
# Parâmetros da distribuição
vtMu = [1.5,2,4]                  # Valores de média da Gaussiana
vtVar = [2, 5, 10]                   # Valores de variância da Gaussiana
x = np.arange(-20,20,0.1)     
#
# Variando a média e plotando os gráficos
#plt.figure(1,[15,5])
#sigma = np.sqrt(vtVar[0]);
#for il in range(0,len(vtMu)):
#    mu = vtMu[il]
#    plt.subplot(2,2,1)
#    plt.plot(x, norm.pdf(x,mu), label='Média = {}'.format(mu))
#    plt.subplot(2,2,2)
#    plt.plot(x, norm.cdf(x,mu), label='Média = {}'.format(mu))
# Variando a variância e plotando os gráficos
mu = vtMu[0];
for il in range(0,len(vtVar)):
    sigma = (vtVar[il]);
    plt.subplot(2,1,1)
    plt.plot(x, nakagami.pdf(x,nu=sigma), label='$\ni$ = {:01.2f}'.format(sigma))
   # plt.xlim([0,10])
    plt.subplot(2,1,2)
    plt.plot(x, nakagami.cdf(x,nu=sigma), label='$\ni$ = {:01.2f}'.format(sigma))
   # plt.xlim([0,10])
        
#plt.subplot(2,2,1)
#plt.legend()
#plt.subplot(2,2,2)
#plt.legend()
plt.subplot(2,1,1)
plt.legend()
plt.subplot(2,1,2)
plt.legend()

plt.show()

