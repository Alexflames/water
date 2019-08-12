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

# This block collects information about network
# for the given task
kmin = DATA_SIZE
kmax = 0
for vertex in network:
    if len(vertex) > kmax:
        kmax = len(vertex)
    elif len(vertex) < kmin:
        kmin = len(vertex)
    network_pk[len(vertex)] += 1

DEBUG_SUM = 0
for i in range(N):
    network_pk[i] /= N
    DEBUG_SUM += network_pk[i]
    
if DEBUG_INFO_PRINT:
    print(DEBUG_SUM)

if DEBUG_INFO_PRINT:
    print("kmin, kmax", kmin, kmax)


#Dmin, gamma_min, K_min
res = [1, 0, 0]
res_2 = [1, 0, 0]
for Kmin in range(kmin, kmax + 1):
    if DEBUG_INFO_PRINT:
        print("Текущее значение Kmin =", Kmin)

    sum_log = 0
    for i in range(0, N):
        sum_log += math.log(len(network[i]) / (Kmin - 0.5))
    
    gamma = 1 + N * (sum_log ** -1) #4.41
    if DEBUG_INFO_PRINT:
        print("Гамма =", gamma)

    # 4.42
    Kmin_dzeta = 0
    for k in range(kmin, kmax + 1):
        Kmin_dzeta += (k ** -gamma)
    if DEBUG_INFO_PRINT:
        print("Kmin_dzeta =", Kmin_dzeta)

    pk_theo = []
    for k in range(0, kmax + 1):
        if k < kmin:
            pk_theo.append(0)
        else:
            pk_theo.append((k ** -gamma) / Kmin_dzeta) #4.42
        if DEBUG_INFO_PRINT:
            print(pk_theo[k])

    if DEBUG_INFO_PRINT:
        print("--------------------------------")

    #4.43
    Pk = []
    for i in range(0, kmax + 1):
        if i < kmin:
            Pk.append(0)
        elif i == 0:
            Pk.append(pk_theo[0])
        else:
            Pk.append(Pk[i - 1] + pk_theo[i])
    
    Sk = []
    for j in range(0, kmax + 1):
        if i < kmin:
            Sk.append(0)
        elif j == 0:
            Sk.append(network_pk[j])
        else:
            Sk.append(network_pk[j] + Sk[j - 1])

    #4.44
    D = 0
    Davg = 0
    # в формуле k меняется от Kmin до kmax
    for k in range(kmin, kmax + 1):
        print(Pk[k], Sk[k])
        D = max(D, abs(Sk[k] - Pk[k]))
        Davg += abs(Sk[k] - Pk[k]) / (kmax + 1 - kmin)   
        
    if DEBUG_INFO_PRINT:
        print("D = ", D)
        print("Davg = ", Davg)
        print("==============================")

    if D < res[0]:
        res = [D, gamma, Kmin]

    if Davg < res_2[0]:
        res_2 = [Davg, gamma, Kmin]

print("D ------------ ", "gamma ------------- ", "Kmin")
print(res)
print(res_2)

    











