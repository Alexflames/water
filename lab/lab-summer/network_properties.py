import csv
import math

# GLOBAL CONSTANTS BLOCK
DATA_SIZE = 4940
DEBUG_INFO_PRINT = True
########################

N = DATA_SIZE + 1

network = []
network_pk = [] # degree distribution
for i in range(N):
    network.append([])
    network_pk.append(0)

csv_path = "powergrid.edgelist.csv"
with open(csv_path, "r") as f_obj:
    reader = csv.reader(f_obj, delimiter='\t')
    for row in reader:
        network[int(row[0])].append(int(row[1]))
        network[int(row[1])].append(int(row[0]))


    











