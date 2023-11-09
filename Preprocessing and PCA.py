#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jun 22 11:35:05 2023

@author: vittoriograsso
"""

import pandas as pd
import seaborn as sns
import scipy.stats as sp


df = pd.read_csv("/Users/vittoriograsso/Desktop/Slides Data Science/CSV_Utilizzati/Spotify.csv")
pd.to_datetime(df["release_date"])

#------------- PREPROCESSING - SCALING
df = df[(df["release_date"] > "2020-1-1")]
df = df[["acousticness","danceability","energy","instrumentalness","liveness","loudness","popularity","speechiness"]]

# -------------- ANALISI DI DISTRIBUZIONE E CORRELAZIONE 
description = df.describe()
description.loc[9]=sp.variation(df)
description.loc[10]=sp.median(df)

sns.displot(data=df["loudness"])

correlations = df.corr()
sns.heatmap(data=correlations,vmin=-1, vmax=1, annot=True, cmap='BrBG')

#-------- STANDARDIZZAZIONE DELLE VARIABILI
from sklearn.preprocessing import StandardScaler
df_scaled = StandardScaler().fit_transform(df, 8) 
#Standardizza le variabili in modo che abbiamo media 0 e varianza 1

#------- PCA
from sklearn.decomposition import PCA
pca = PCA(n_components=8)
pca_feature = pca.fit_transform(df_scaled)

pca_df = pd.DataFrame(
    data=pca_feature, 
    columns=['PC1', 'PC2', 'PC3',"PC4","PC5","PC6","PC7","PC8"])

sns.barplot(data=pca_df)
pca.explained_variance_ #PER CAPIRE I LIVELLI DI VARIANZA E QUINDI QUALI TENERE (VAR > 1) CHIAMATA ANCHE STANDARD DEVIATION
pca.explained_variance_ratio_ # E' LA "PROPORTION OF VARIANCE" CHE SE SOMMATA FRA I MEMBRI DA LA CUMULATA

#Questo da un df con i nuovi coefficienti in base ai nuovi assi 
#(di cui abbiamo visto dovremmo prendere solo i primi 4 o 5)
#pca_components = pca.components_
#pca_components = pd.DataFrame(
#    data=pca_components, 
#    columns=['PC1', 'PC2', 'PC3',"PC4","PC5","PC6","PC7","PC8"])

#-------- PCA:SCREE PLOT 

import matplotlib.pyplot as plt
import numpy as np

PC_values = np.arange(pca.n_components_) + 1
plt.plot(PC_values, pca.explained_variance_ratio_, 'o-', linewidth=2, color='blue')
plt.title('Scree Plot')
plt.xlabel('Principal Component')
plt.ylabel('Variance Explained')
plt.show() #SI DEVONO PRENDERE TUTTI I PC(principal componet) FINO A DOVE DOVE LA LINA FA UN "GOMITO"




# ------------ ADESSO CHE ABBIAMO CAPITO CHE DOBBIAMO PRENDERE FINO ALLA 5 COMPONENTE 
#SI RIPETE LO STESSO PROCESSO SOPRA

pca_loadings = pd.DataFrame(
    data=pca.components_, 
    columns=['DIM1', 'DIM2', 'DIM3',"DIM4","DIM5","DIM6","DIM7","DIM8"],
    index=["acousticness","danceability","energy","instrumentalness","liveness","loudness","popularity","speechiness"])

pca_loadings = pca_loadings[['DIM1', 'DIM2', 'DIM3',"DIM4","DIM5"]]

sns.heatmap(data=pca_loadings,vmin=-1, vmax=1, annot=True, cmap='BrBG')
#Si prendono i valori columwise in azzurro


























