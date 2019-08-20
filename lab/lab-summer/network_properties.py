import csv
import math
import networkx as nx
import network_read as nread
import numpy as np
from sklearn.linear_model import LinearRegression

# GLOBAL CONSTANTS BLOCK
DEBUG_INFO_PRINT = True
########################

# O(N) N-vertex count
def min_max(network_input):
    network = network_input.network
    kmin = len(network)
    kmax = 0
    for vertex in network:
        if len(vertex) > kmax:
            kmax = len(vertex)
        elif len(vertex) < kmin:
            kmin = len(vertex)
            
    return (kmin, kmax)

# O(2N) N-vertex count
def network_distribution(network_input):
    network = network_input.network
    pk = []
    kmin, kmax = min_max(network_input)
    for vertex in range(0, kmax + 1):
        pk.append(0)
    for vertex in network:
        pk[len(vertex)] += 1/len(network)
    return pk

def lengths_ecc_diameter(network_input):
    lengths = dict(nx.all_pairs_shortest_path_length(network_input.networkx))
    eccentricity = nx.eccentricity(network_input.networkx, sp = lengths)
    diameter = nx.diameter(network_input.networkx, e = eccentricity)
    return (lengths, eccentricity, diameter)

def clique_number(network_input):
    return nx.graph_clique_number(network_input.networkx)

def average_clustering(network_input):
    network = network_input.networkx
    return nx.average_clustering(network)

def betweenness_centrality(network_input):
    return nx.betweenness_centrality(network_input.networkx)

# found using linear regression
def gamma(network_input):
    network = network_input.network
    distribution = network_distribution(network_input)
    # log-binning
    log_distribution = []
    power2 = 1
    # <= или < ???
    while power2 <= len(distribution):
        log_distribution.append(0)
        power2 *= 2
    for i in range(len(distribution)):
        print(distribution[i])
        # ceil и minus-1
        if i == 0:
            continue
        group = math.ceil(math.log(i, 2) - 0.99)
        log_distribution[group] += distribution[i]

    x = np.array(range(len(log_distribution))).reshape((-1, 1))
    y = np.array(log_distribution)
    model = LinearRegression().fit(x, y)
    print(log_distribution)
    print(model.coef_)

def graph_density(network_input):
    network = network_input.network
    edges = 0
    max_edges = len(network) * (len(network) - 1)
    for i in range(len(network)):
        edges += len(network[i])
    return edges / max_edges
    

def test_example(filename, size, matrix = False):    
    print("Warning: Networkx version should be 2.3, current version:")
    print(nx.__version__)
    if matrix == False:
        net = nread.read_undirected(filename, size, True)
    else:
        net = nread.read_undirected_matrix(filename, include_networkx = True)
    print("Min-Max degrees:", min_max(net))
##    print("Degree distribution:", network_distribution(net))
##    print("Network diameter:", lengths_ecc_diameter(net)[2])
    print("Clique number:", clique_number(net))
    print("Average Clustering Coefficient:", average_clustering(net))
    print("Graph Density:", graph_density(net))
    gamma(net)
##    betweenness_centrality(net)




    











