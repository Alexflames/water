import csv
import math
import networkx as nx
import network_read as nread
import numpy as np
import powerlaw as pwl
from plfit import plfit
import os
from sklearn.linear_model import LinearRegression

# GLOBAL CONSTANTS BLOCK
DEBUG_INFO_PRINT = True
FILENAME = None
ADD_PRINT = ""
########################

def set_filename(filename):
    FILENAME = filename

def set_addprint(string):
    global ADD_PRINT
    ADD_PRINT = string

def write_file(data, output_name = None, is_array = False):
    file = FILENAME
    if output_name != None:
        file = output_name
    if file == None:
        return

    f = open(file, 'a')
    if is_array:
        for info in data:
            f.write(ADD_PRINT + str(info) + ';')
        f.write('\n')
    else:
        f.write(ADD_PRINT + str(data) + '\n')
    f.close()

# O(N) N-vertex count
def min_max(network_input, output_name = None):
    network = network_input.network
    kmin = len(network)
    kmax = 0
    for vertex in network:
        if len(vertex) > kmax:
            kmax = len(vertex)
        elif len(vertex) < kmin:
            kmin = len(vertex)
    write_file([kmin, kmax], output_name = output_name)
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

def network_log_distribution(network_input):
    distribution = network_distribution(network_input)
    new_d = []
    for degree in distribution:
        if degree == 0:
            new_d.append(0)
        else:
            new_d.append(math.log(degree, 10))
    return new_d

def log_range(rng):
    log_array = []
    for prob in rng:
        print(prob)
        if prob == 0:
            log_array.append(0)
        else:
            log_array.append(math.log(prob, 10))
    return log_array

def distribution_labels(network_input):
    network = network_input.network
    pk = dict()
    kmin, kmax = min_max(network_input)
    
    for vertex in network:
        if len(vertex) == 0:
            continue
        pk[len(vertex)] += 1/len(network)
    return pk

def lengths_ecc_diameter(network_input, output_name = None):
    try:
        lengths = dict(nx.all_pairs_shortest_path_length(network_input.networkx))
        eccentricity = nx.eccentricity(network_input.networkx, sp = lengths)
        diameter = nx.diameter(network_input.networkx, e = eccentricity)
    except:
        lengths = dict()
        eccentricity = dict()
        diameter = "INF"
    write_file(diameter, output_name = output_name)
    return (lengths, eccentricity, diameter)

def clique_number(network_input, output_name = None):
    answer = nx.graph_clique_number(network_input.networkx)
    write_file(answer, output_name = output_name)
    return answer 

def average_clustering(network_input, output_name = None):
    network = network_input.networkx
    answer = nx.average_clustering(network)
    write_file(answer, output_name = output_name)
    return answer

def betweenness_centrality(network_input, output_name = None):
    answer = nx.betweenness_centrality(network_input.networkx)
    write_file(answer, output_name = output_name)
    return answer

def get_binned_data(labels, values, num):
    min_label, max_label = min(labels), max(labels)
    base = (max_label / min_label) ** (1 / num)
    bins = [base**i for i in range(int(np.log(max_label) / np.log(base)) + 1)]
    binned_values, binned_labels = [], []
    counter = 0
    for b in bins:
        bin_size = 0
        bin_sum = 0
        while counter < len(labels) and labels[counter] <= b:
            bin_size += values[counter]
            bin_sum += values[counter] * labels[counter]
            counter += 1
        if(bin_size):
            binned_values.append(bin_size)
            binned_labels.append(bin_sum / bin_size)
    return binned_labels, binned_values  
    
USE_LOG_BINNING = False
# found using linear regression
def gamma(network_input, output_name = None):
#######################
##### Variant 1   #####
#######################
    distribution = network_distribution(network_input)
##    if USE_LOG_BINNING:
##        # log-binning
##        log_distribution = []
##        log_rng = []
##        power2 = 1
##        # <= или < ???
##        while power2 <= len(distribution):
##            log_rng.append((power2 + (power2 * 100)) / 2)
##            log_distribution.append(0)
##            power2 *= 2
##        for i in range(len(distribution)):
##            # ceil и minus-1
##            if i == 0 or distribution[i] == 0:
##                continue
##            group = math.ceil(math.log(i, 2) - 0.99)
##            log_distribution[group] += distribution[i]
##        while log_distribution[-1] == 0:
##            log_distribution = log_distribution[:-1]
    result = plfit(distribution, discrete=True)
    answer = result._alpha
    write_file(answer, output_name = output_name)
    return(answer)
#######################
##### Variant 2   #####
#######################
##    network = network_input.network
##    distribution = network_distribution(network_input)
####    print(distribution)
##    fit = pwl.Fit(distribution, verbose = False)
##    answer = fit.power_law.alpha
##    write_file(answer, output_name = output_name)
##    return answer
#######################
##### Variant 3   #####
#######################
##    if USE_LOG_BINNING:
##        # log-binning
##        log_distribution = []
##        log_rng = []
##        power2 = 1
##        # <= или < ???
##        while power2 <= len(distribution):
##            log_rng.append((power2 + (power2 * 100)) / 2)
##            log_distribution.append(0)
##            power2 *= 2
##        for i in range(len(distribution)):
##            # ceil и minus-1
##            if i == 0 or distribution[i] == 0:
##                continue
##            group = math.ceil(math.log(i, 2) - 0.99)
##            log_distribution[group] += distribution[i]
##        x = np.array(log_range(log_rng)).reshape(-1, 1)
##        y = np.array(log_distribution)
##        print(x)
##        print(y)
##        model = LinearRegression().fit(x, y)
##        return(model.coef_)
##    else:
##        x = np.array(log_range(distribution)).reshape(-1, 1)
##        y = np.array(distribution)
##        print(x)
##        print(y)
##        model = LinearRegression().fit(x, y)
##        return(model.coef_)

def graph_density(network_input, output_name = None):
    network = network_input.network
    edges = 0
    max_edges = len(network) * (len(network) - 1)
    for i in range(len(network)):
        edges += len(network[i])
    answer = edges / max_edges
    write_file(answer, output_name = output_name)
    return answer
    
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
    print(gamma(net))
##    betweenness_centrality(net)

def test_example_print(filename, size, matrix = False):
    os.makedirs("output")
    if matrix == False:
        net = nread.read_undirected(filename, size, True)
    else:
        net = nread.read_undirected_matrix(filename, include_networkx = True)
    print("Min-Max degrees:", min_max(net))
##    print("Degree distribution:", network_distribution(net))
##    print("Network diameter:", lengths_ecc_diameter(net)[2])
    print("Clique number:", clique_number(net, "output/graph_clique_number.txt"))
    print("Average Clustering Coefficient:",
          average_clustering(net, "output/graph_acc.txt"))
    print("Graph Density:", graph_density(net, "output/graph_density.txt"))
    print(gamma(net, "output/graph_gamma.txt"))
##    betweenness_centrality(net)

def get_property(property_name, net):
    if property_name.lower() == "clique" or property_name.lower() == "clique_number":
        clique_number(net, "output/graph_clique_number.txt")
    elif property_name.lower() == "density":
        graph_density(net, "output/graph_density.txt")
    elif property_name.lower() == "gamma":
        gamma(net, "output/graph_gamma.txt")
    elif property_name.lower() == "acc":
        average_clustering(net, "output/graph_acc.txt")
    elif property_name.lower() == "diameter":
        lengths_ecc_diameter(net, "output/graph_diameter.txt")
    elif property_name.lower() == "betweenness":
        betweenness_centrality(net, "output/graph_betweenness.txt")
    else:
        print('\033[91m' + "ERROR, PROPERTY NAMED:", property_name, "NOT FOUND!")
        print('\033[91m' + "Check for grammar typos")
        
# writes to files in output/
# csv only right now
# [files_count_from -> files_count_to]: inclusive !!
def get_properties_files(filename_base,
                         files_count_from, files_count_to,
                         size, properties, matrix = False, add_print = False):
    try:
        os.makedirs("output")
    except:
        pass

    
    for i in range(int(files_count_from), int(files_count_to + 1)):
        if matrix == False:
            net = nread.read_undirected(filename_base + str(i) + ".csv",
                                        size, True)
        else:
            net = nread.read_undirected_matrix(filename_base + str(i) + ".csv",
                                               include_networkx = True)
        if add_print:
            set_addprint(filename_base + str(i) + ": ")

        for prop in properties:
            get_property(prop, net)
    
