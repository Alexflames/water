import numpy as np
import matplotlib.pyplot as plt
from scipy.cluster.hierarchy import dendrogram, linkage

import csv
 
def csv_reader(file_obj):
    """
    Read a csv file
    """
    reader = csv.reader(file_obj)
    for row in reader:
        print(" ".join(row))
        
# отображение: код -> сектор, название

label_info = dict()
if __name__ == "__main__":
    csv_path = "companies-v2.csv"
    with open(csv_path, "r") as f_obj:
        reader = csv.reader(f_obj)
        for row in reader:
            label_info[row[0]] = [row[1], row[3]]

# отображение: индекс -> код
index_label = dict()

d = []
    
if __name__ == "__main__":
    csv_path = "dist.csv"
    with open(csv_path, "r") as f_obj:
        reader = csv.reader(f_obj)
        i = 0
        for row in reader:
            # Связь индексов с кодами в первой строке
            if i == 0:
                split_row = row[0].split(';')
                for j in range(len(split_row)):
                    if j != 0: # индекс 0 - пустая ячейка
                        index_label[j-1] = split_row[j]
            else:
                d.append([])
                split_row = row[0].split(';')
                for j in range(len(split_row)):
                    if j != 0:
                        d[i-1].append(float(split_row[j]))
                    
            i = i + 1

import scipy.spatial.distance as ssd
# convert the redundant n*n square matrix form into a condensed nC2 array
# distArray[{n choose 2}-{n-i choose 2} + (j-i-1)] is the distance between
#   points i and j
distArray = ssd.squareform(d) 

##X = np.array([[5,3],  
##    [10,15],
##    [15,12],
##    [24,10],
##    [30,30],
##    [85,70],
##    [71,80],
##    [60,78],
##    [70,55],
##    [80,91],])
##
linked = linkage(distArray, 'single')

labelList = range(1, 124)

plt.figure(figsize=(15, 9))  
dendrogram(linked,  
            orientation='top',
            labels=labelList,
            distance_sort='ascending',
            show_leaf_counts=True,
           above_threshold_color='#444444')
plt.show()

