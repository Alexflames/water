import network_properties as npr
import network_read as nread

def test_example(filename, size, matrix = False):    
    print("Warning: Networkx version should be 2.3, current version:")
    print(nx.__version__)
    if matrix == False:
        net = nread.read_undirected(filename, size, True)
    else:
        net = nread.read_undirected_matrix(filename, include_networkx = True)
    print("Min-Max degrees:", npr.min_max(net))
##    print("Degree distribution:", network_distribution(net))
##    print("Network diameter:", lengths_ecc_diameter(net)[2])
    print("Clique number:", npr.clique_number(net))
    print("Average Clustering Coefficient:", npr.average_clustering(net))
    print("Graph Density:", npr.graph_density(net))
    print(npr.gamma(net))
##    betweenness_centrality(net)

##npr.test_example("powergrid.edgelist.csv", 4940)
##npr.test_example_print("collaboration.edgelist.csv", 93439)
##print("Тест на матрице")
##npr.test_example("data/graph1.csv", 191, matrix = True)
#1 to 75
##props = ["diameter", "acc", "betweenness", "gamma", "density", "clique"] 
##npr.get_properties_files(filename_base = "data/graph", files_count_from = 1,
##                         files_count_to = 75, size = None,
##                         properties = props, matrix = True)

##filename = "1.1graph"
##npr.set_output_info(filename + ": ")
####props = ["diameter", "acc", "density", "clique"]
##npr.get_properties_files(filename_base = "data/" + filename, files_count_from = 1,
##                         files_count_to = 81, size = None,
##                         properties = props, matrix = True)

filename = "1.2graph"
npr.set_output_info(filename + ": ")
props = ["gamma"]
##props = ["diameter", "acc", "density", "clique"]
npr.get_properties_files(filename_base = "data/" + filename, files_count_from = 1,
                         files_count_to = 1, size = None,
                         properties = props, matrix = True)
