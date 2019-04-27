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
                        #временная мера
                        if i != j:
                            new_num = float(split_row[j])*100 - 80
                        else:
                            new_num = 0
                        d[i-1].append(new_num)
                    
            i = i + 1

import scipy.spatial.distance as ssd
from scipy.sparse import csr_matrix
from scipy.sparse.csgraph import minimum_spanning_tree
import networkx as nx

sector_color = {'Utilities': '#FF7400', 'Energy': '#FFF100',
                'Consumer Non-Cyclicals':'#CD0074',
                'Telecommunications Services':'#009A9A',
                'Basic Materials':'#0D58A7',
                'Consumer Cyclicals':'#819F00',
                'Healthcare':'#E668AF',
                'Financials':'#A67777',
                'Industrials':'#CCCCCC',
                'Technology':'#35D5A4'}

X = csr_matrix(d)
Tcsr = minimum_spanning_tree(X).toarray()
plt.figure(figsize=(15, 9))
T = nx.Graph()
T.add_nodes_from(range(1, 122))
##for i in range(len(Tcsr)):
##    T.add_node(i + 1)
for i in range(len(Tcsr)):
    for j in range(len(Tcsr[i])):
        if Tcsr[i][j] != 0:
            #print(i, j, Tcsr[i][j])
            T.add_edge(i + 1, j + 1, weight=Tcsr[i][j])
nc = [sector_color.get(label_info[index_label[i]][0], '#24AF24')
      for i in range(len(T.nodes()))]
nx.draw_networkx(T, node_color = nc)
plt.show()


# convert the redundant n*n square matrix form into a condensed nC2 array
# distArray[{n choose 2}-{n-i choose 2} + (j-i-1)] is the distance between
#   points i and j
##distArray = ssd.squareform(d) 

##single : mimimum, complete : maximum, average, centroid
##linked = linkage(distArray, 'complete')
##
##labelList = range(1, 122)
##
##plt.figure(figsize=(15, 9))  
##dendrogram(linked,  
##            orientation='top',
##            labels=labelList,
##            distance_sort='ascending',
##            show_leaf_counts=True,
##           above_threshold_color='#666666')
##plt.ylabel('distance(norm)')
##plt.title('Hierarchical Clustering Dendrogram')
##plt.show()



