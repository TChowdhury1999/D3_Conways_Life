""" 
Made by Tanjim Chowdhury
29/10/2020

Used to analyse line seed data from Conway's Life
"""

import numpy as np
import scipy as sp
import matplotlib.pyplot as plt
import pandas as pd

datas_arr = []                                                                  # list containing lists that have numpy arrays at index 1

for x in [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,30,40,50]:         # these numbers are the files ur reading in
    data = pd.read_csv(f"length {str(x)}.txt", header = None)                   # change the string so it looks like ur file names
    datas_arr.append([x, np.array(data)])                                       # eg for x = 7 --> [7, array containing data] is put into datas_arr


plt.figure("Graph")

for data_set in datas_arr:
    x = data_set[0]
    y = np.max(data_set[1],axis = 0)[2]
    plt.scatter(x, y, marker = '+')