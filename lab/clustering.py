import numpy as np
import matplotlib.pyplot as plt
from scipy.cluster.hierarchy import dendrogram, linkage

import csv
        
# mapping: ticket -> (sector, name)

label_info = dict()
if __name__ == "__main__":
    csv_path = "company-2012.csv"
    with open(csv_path, "r") as f_obj:
        reader = csv.reader(f_obj)
        for row in reader:
            label_info[row[0]] = [row[1], row[3]]

# mapping: index -> ticket
index_label = dict()

d = []
    
if __name__ == "__main__":
    csv_path = "dist_new.csv"
    with open(csv_path, "r") as f_obj:
        reader = csv.reader(f_obj)
        i = 0
        for row in reader:
            # index - ticket connection
            if i == 0:
                split_row = row[0].split(';')
                for j in range(len(split_row)):
                    if j != 0: # index 0 contains company ticket
                        index_label[j] = split_row[j]
            else:
                d.append([])
                split_row = row[0].split(';')
                for j in range(len(split_row)):
                    if j != 0:
                        #normalization
                        if i != j:
                            new_num = float(split_row[j])
                        else:
                            new_num = 0
                        d[i-1].append(new_num)
                    
            i = i + 1

import scipy.spatial.distance as ssd
from scipy.sparse import csr_matrix
from scipy.sparse.csgraph import minimum_spanning_tree
import networkx as nx

sector_color = {'Utilities': '#FF7400', #orange
                'Energy': '#FFF100', #yellow
                'Consumer Non-Cyclicals':'#CD0074', #dark pink
                'Telecommunications Services':'#33CCCC', #light green
                'Basic Materials':'#3E97D1', #dark blue
                'Consumer Cyclicals':'#819F00', #light green
                'Healthcare':'#E668AF', #light pink
                'Financials':'#A67777', #light brown-red
                'Industrials':'#CCCCCC', #light gray
                'Technology':'#B4ACE3' #dark blue-pink
                }

##X = csr_matrix(d)
##Tcsr = minimum_spanning_tree(X).toarray()
##plt.figure(figsize=(10, 10))
##T = nx.Graph()
##T.add_nodes_from(range(1, len(d) + 1))
##for i in range(len(Tcsr)):
##    for j in range(len(Tcsr[i])):
##        if Tcsr[i][j] != 0:
##            T.add_edge(i + 1, j + 1, weight=Tcsr[i][j])
##
##
##nc = [sector_color.get(label_info[index_label[i]][0], '#24AF24')
##      for i in range(1, len(T.nodes()) + 1)]
##nx.draw_networkx(T, node_color = nc, labels=index_label, width=0.4,
##                 font_family='sans-serif', font_weight='light',
##                 font_size=7, node_size=100)
##plt.show()


# convert the redundant n*n square matrix form into a condensed nC2 array
# distArray[{n choose 2}-{n-i choose 2} + (j-i-1)] is the distance between
#   points i and j
distArray = ssd.squareform(d) 

#single : minimum, complete : maximum, average, centroid
distance_definition = 'complete'
linked = linkage(distArray, distance_definition)
labelList = [index_label[i] for i in range(1, len(d) + 1)]

def color_fun(link):
    print(link)
    return sector_color['Energy']

plt.figure(figsize=(9, 8))  
dendrogram(linked,  
            orientation='top',
           no_labels=True,
            #labels=labelList,
            distance_sort='ascending',
            show_leaf_counts=True,
            color_threshold=1.3,
           #link_color_func=lambda k: color_fun(k),
           above_threshold_color='#222222'
           )
plt.ylabel('distance')
#plt.title('Hierarchical Clustering Dendrogram')
ax = plt.gca()
ax.set_facecolor((0.85, 0.85, 0.85))
plt.show()



