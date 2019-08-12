import csv
import math
import networkx as nx
import network_read as nread

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
    lengths = dict(nx.all_pairs_shortest_path_length(network_input[1]))
    eccentricity = nx.eccentricity(network_input[1], sp = lengths)
    diameter = nx.diameter(network_input[1], e = eccentricity)
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
    distribution = network_distribution(net)
    

def test_example(filename, size):    
    print("Warning: Networkx version should be 2.3, current version:")
    print(nx.__version__)
    net = nread.read_undirected(filename, size, True)
    print("Min-Max degrees:", min_max(net))
##    print("Degree distribution:", network_distribution(net))
##    print("Network diameter:", lengths_ecc_diameter(net)[2])
    print("Clique number:", clique_number(net))
    print("Average Clustering Coefficient:", average_clustering(net))
##    betweenness_centrality(net)




    











