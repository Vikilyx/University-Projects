#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Sep  5 15:12:15 2023

@author: vittoriograsso
"""

import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

df = pd.read_excel("italy_balances.xlsx")
df2 = df[['R.O.E. (Return on Equity)',
'R.O.I. Cerved (Return on Investment)', 'R.O.S. (Return on Sales)',
'ROT (Return On Turnover) FATTURATO / ATTIVO SP',
'R.O.A. Cerved (Return on Assets) UTILE NETTO / ATTIVO SP']]

import tensorflow as tf
from tensorflow import keras

from tensorflow.keras import Sequential
from tensorflow.keras.layers import Flatten, Dense, Dropout, BatchNormalization
from tensorflow.keras.layers import Conv1D, MaxPool1D
from tensorflow.keras.optimizers import Adam

from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler 


Y = df2.copy().pop("R.O.I. Cerved (Return on Investment)")
X = df2.copy().drop(columns="R.O.I. Cerved (Return on Investment)")

X.describe()
sns.boxplot(data=X)
plt.figure(figsize=(10, 6))
sns.heatmap(data=X.corr(),annot=True)



x_train, x_test, y_train, y_test = train_test_split(X,Y, test_size=0.2,  random_state=12)


# cerare la NN
model = Sequential()
model.add(Dense(32, activation="relu",input_shape=[4]))
model.add(BatchNormalization())


model.add(Dense(64, activation='relu'))
model.add(BatchNormalization())


model.add(Dense(1, activation="linear"))


# calcolo dell R^2 come metrica di Tens
from tensorflow.keras import backend as K

def r_squared(y_true, y_pred):
    SS_res = K.sum(K.square(y_true - y_pred))
    SS_tot = K.sum(K.square(y_true - K.mean(y_true)))
    return 1 - (SS_res / (SS_tot + K.epsilon()))


#complare la NN
model.compile(optimizer=Adam(learning_rate = .001),
              loss ='mean_squared_error',  #Minimizzare l'MSE durante l'addestramento significa ridurre l'errore quadratico medio.
              metrics=[r_squared]) 
model.summary()



# Addestra il modello
epochs = 200
model.fit(x_train, y_train, epochs=epochs, batch_size=32, validation_data=(x_test,y_test))

sns.set_theme(style="darkgrid")
plt.grid(axis='x', linestyle='--', alpha=0.7)  
plt.figure(figsize=(10, 6))
sns.lineplot(data=model, x=range(epochs), y=model.history.history['loss'], label='Train MSE')
sns.lineplot(data=model, x=range(epochs), y=model.history.history['val_loss'], label='Validation MSE')
sns.lineplot(data=model, x=range(epochs), y=model.history.history['r_squared'], label='Train R_Squared')
sns.lineplot(data=model, x=range(epochs), y=model.history.history['val_r_squared'], label='Validation R_Squared')
plt.legend()



#predizioni
test_target = pd.DataFrame(y_test).reset_index(drop=True)
y_pred = pd.DataFrame(model.predict(x_test))
pair_pred2 = pd.concat([y_pred, test_target],axis=1) 
pair_pred2["Residual"] = (pair_pred2["R.O.I. Cerved (Return on Investment)"] - pair_pred2[0]).abs()



#feature importance
import numpy as np

def get_feature_importance(model, x_data):
    with tf.GradientTape() as tape:
        input_data = tf.convert_to_tensor(x_data, dtype=tf.float32)
        tape.watch(input_data)
        predictions = model(input_data)
    
    grads = tape.gradient(predictions, input_data)
    feature_importance = np.abs(grads.numpy()).mean(axis=0) * 100
    feature_importance = pd.DataFrame(feature_importance)
    return feature_importance 


feature_importance = get_feature_importance(model, x_test)
feature_importance["feature_names"] = ['ROE', 'ROS', 'ROT', 'ROA']
feature_importance = feature_importance.sort_values(by=0,ascending=True)


plt.figure(figsize=(10, 6))
bars = plt.barh(feature_importance["feature_names"], feature_importance[0], color='skyblue')
plt.xlabel('Importance')
plt.ylabel('Features')
plt.title('Feature Importance')
plt.grid(axis='x', linestyle='--', alpha=0.7)  
plt.tight_layout()  # Migliora l'allineamento dei componenti
plt.show()



