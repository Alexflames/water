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

label_info = dict()
if __name__ == "__main__":
    csv_path = "companies-v2.csv"
    with open(csv_path, "r") as f_obj:
        reader = csv.reader(f_obj)
        for row in reader:
            label_info[row[0]] = [-1, row[1], row[3]]

if __name__ == "__main__":
    csv_path = "dist.csv"
    with open(csv_path, "r") as f_obj:
        reader = csv.reader(f_obj)
        for row in reader:
            split_row = row[0].split(';')
            label_info[split_row[0]][0] = split_row[1]

for item in label_info.keys():
    if label_info[item][0] != -1:
        print(label_info[item])


##
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
##linked = linkage(X, 'single')
##
##labelList = range(1, 11)
##
##plt.figure(figsize=(10, 7))  
##dendrogram(linked,  
##            orientation='top',
##            labels=labelList,
##            distance_sort='descending',
##            show_leaf_counts=True)
##plt.show()
##
