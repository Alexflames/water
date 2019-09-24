import csv
import math
import networkg as ng
import networkx as nx

# GLOBAL CONSTANTS BLOCK
DEBUG_INFO_PRINT = True
########################

# Converts graph to networkx package graph
def convert_networkx(network):
    new_network = nx.Graph(network)
    return new_network

# function returns two network representation
# filename - input .csv file, size - number of nodes
# 1 - Adjacency List
# 2 - Networkx graph
# 3 - Result includes networkx graph
def read_undirected(filename, size, include_networkx = False):
    result = ng.Networkg()
    network = []

    with open(filename, "r") as f_obj:
        reader = csv.reader(f_obj, delimiter='\t')
    
        for i in range(size):
            network.append([])

        f_obj.seek(0)

        if include_networkx:    
            networkx = []
            for row in reader:
                network[int(row[0]) - 1].append(int(row[1]) - 1)
                network[int(row[1]) - 1].append(int(row[0]) - 1)
                networkx.append((row[0], row[1]))
            networkx = convert_networkx(networkx)
            result.networkx = networkx
            
        else:
            for row in reader:
                network[int(row[0]) - 1].append(int(row[1]) - 1)
                network[int(row[1]) - 1].append(int(row[0]) - 1)

        result.network = network
        return result


def read_undirected_matrix(filename, size = None,
                           include_networkx = False, labels = True):
    if labels == True and size == None:
        labels = dict()
        to_labels = dict()
        net = []
        netx = []
        with open(filename, "r") as f_obj:
            reader = csv.reader(f_obj, delimiter=',')
            i = 0
            for row in reader:
                if i != 0:
                    labels[row[0]] = i
                    to_labels[i] = row[0]
                    net.append([])
                i += 1
            data_size = i    
            f_obj.seek(0)

            i = -1
            for row in reader:
                i += 1
                if i == 0:             # первая строка - лейблы 
                    continue
                
                for j in range(len(row)):
                    if j == 0 or j == i:  # первая строка - лейблы, диагональ не считаем
                        continue
                    if row[j] == '0':
                        continue
                    if j >= data_size: # временная мера, удалить
                                       # когда данные станут нормальными
                        break
                    if include_networkx:
                        netx.append((labels[row[0]], j))
                    net[labels[row[0]] - 1].append(j - 1)
##                    net[j - 1].append(labels[row[0]] - 1)
                    # TODO: сделать считывание только верхнего треугольника
            if include_networkx:
                real_netx = convert_networkx(netx)
        return ng.Networkg(network = net, networkx = real_netx,
                            labels_nodes = labels, nodes_labels = to_labels)
        
##net = read_undirected_matrix("data/project1.csv", include_networkx = True)  
##print(net.network)        
##print(net.networkx)
##print(net.labels_nodes)
##print(net.nodes_labels)
    



    











