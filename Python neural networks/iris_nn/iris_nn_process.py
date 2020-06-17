# -*- coding: utf-8 -*-
"""
Created on Tue May 26 12:12:15 2020

@author: Test

"""
a = 1;
c = 0.3;
import pickle
import numpy as np
import csv
clipping_value = 5;

def sigmoid(t):
    return a*np.tanh(c*t)

def roundPartial (value, resolution):
    return round (value / resolution) * resolution


with open('iris_train.pickle', 'rb') as f:
    X, weights_layer_1, weights_layer_2,b1,b2 = pickle.load(f)
X = X.T
weights_layer_1 = weights_layer_1.T
weights_layer_2 = weights_layer_2.T
b1 = b1.T;
b2 = b2.T;
#X = X[3,:];
    
net_layer_1 = np.dot(X, weights_layer_1) + b1;

out_layer_1 = np.tanh(net_layer_1);

net_layer_2 = np.dot(out_layer_1, weights_layer_2) + b2;

out_layer_2 = sigmoid(net_layer_2);

weights1_clipped = weights_layer_1.copy();
weights2_clipped = weights_layer_2.copy();

for i in np.nditer(weights1_clipped, op_flags = ['readwrite']):
    i[...] = roundPartial (i[...], 0.0625);
    if i[...] < -1*clipping_value:
        i[...] = -1*clipping_value
    elif i[...] > 1*clipping_value:
        i[...] = 1*clipping_value
        
for i in np.nditer(weights2_clipped, op_flags = ['readwrite']):
    i[...] = roundPartial (i[...], 0.0625);
    if i[...] < -1*clipping_value:
        i[...] = -1*clipping_value
    elif i[...] > 1*clipping_value:
        i[...] = 1*clipping_value
        
        
net_layer_1_clipped = np.dot(X, weights1_clipped) + b1;

out_layer_1_clipped = np.tanh(net_layer_1_clipped);

net_layer_2_clipped = np.dot(out_layer_1_clipped, weights2_clipped) + b2;

out_layer_2_clipped = sigmoid(net_layer_2_clipped);

#need to save everything in csvs.

layer_1_W0 = weights1_clipped[:,0]; #1st column
layer_1_W1 = weights1_clipped[:,1]; #1st column
layer_1_W2 = weights1_clipped[:,2]; #1st column
layer_1_W3 = weights1_clipped[:,3]; #1st column
with open('layer_1_W0.csv', mode='w') as file:
    writer = csv.writer(file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
    writer.writerow(layer_1_W0)
    
with open('layer_1_W1.csv', mode='w') as file:
    writer = csv.writer(file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
    writer.writerow(layer_1_W1)
    
with open('layer_1_W2.csv', mode='w') as file:
    writer = csv.writer(file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
    writer.writerow(layer_1_W2)
    
with open('layer_1_W3.csv', mode='w') as file:
    writer = csv.writer(file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
    writer.writerow(layer_1_W2)
    
#second layer
layer_2_W0 = weights2_clipped[:,0]; #1st column
layer_2_W1 = weights2_clipped[:,1]; #1st column
with open('layer_2_W0.csv', mode='w') as file:
    writer = csv.writer(file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
    writer.writerow(layer_2_W0)
    
with open('layer_2_W1.csv', mode='w') as file:
    writer = csv.writer(file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
    writer.writerow(layer_2_W1)
    


    
    