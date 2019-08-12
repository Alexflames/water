import csv
import math
import networkx as nx
import network_read as nread

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
def read_undirected(filename, size):
    network = []
    networkx = []

    csv_path = filename
    with open(csv_path, "r") as f_obj:
        reader = csv.reader(f_obj, delimiter='\t')
    
        for i in range(size):
            network.append([])

        f_obj.seek(0)

        for row in reader:
            network[int(row[0]) - 1].append(int(row[1]) - 1)
            network[int(row[1]) - 1].append(int(row[0]) - 1)
            networkx.append((row[0], row[1]))

        networkx = convert_networkx(networkx)
    return (network, networkx)

# O(N) N-vertex count
def min_max(network_input):
    network = network_input[0]
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
    network = network_input[0]
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
    return nx.graph_clique_number(network_input[1])

def average_clustering(network_input):
    network = network_input[1]
    return nx.average_clustering(network)

def betweenness_centrality(network_input):
    return nx.betweenness_centrality(network_input[1])

# found using linear regression
def gamma(network_input):
    network = network_input[0]
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




    











