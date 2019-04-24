import queue

class Graph:
    
    def __init__(self, filename = 'GGraph.txt'):
        self.filename = filename
        self.graph = dict()
        self.default_node = '1'


    def from_file(self):
        file = open(self.filename, 'r')
        
        f = file.readlines()
        for node in f[0].split():
            self.graph[node] = []
            self.default_node = node

        for line in f[1:]:
            nodes = line.split()
            for node in nodes[1:]:
                self.graph[nodes[0]].append(node)

        return self.graph

    def __str__(self):
        return str(self.graph)

    def deg(self, node_input):
        return len(self[node_input])


    def nodes(self):
        return self.graph.keys()


    def adjacent(self):
        return self.graph.values()


    def __getitem__(self, key):
        return self.graph[str(key)]


    def __setitem__(self, key, value):
        self.graph[str(key)] = value

# не доделано
    @staticmethod
    def inverse(graph):
        new_graph = GraphNonOriented()
        for node in graph.nodes():
            new_graph.graph[node] = []
            for node2 in graph.nodes():
                if node != node2 and not node2 in graph.graph[node]:
                    new_graph.graph[node].append(node2)
        return new_graph

    @staticmethod
    def bfs_visit(graph, colors, node_from, info, node_to):
        length = info[2]
        parents = info[3]
        q = queue.Queue()
        q.put(node_from)
        while not q.empty():
            node = q.get() #int???
            colors[node] = 'BLACK'
            for adjacent_node in graph[str(node)]:
                if colors[adjacent_node] == 'GREY':
                    info[1] = False
                if colors[adjacent_node] == 'WHITE':
                    q.put(adjacent_node)
                    colors[adjacent_node] = 'GREY'
                    length[adjacent_node] = length[str(node)] + 1
                    parents[adjacent_node] = node
        info[2] = length
        info[3] = parents

    def bfs(self, node_from, node_to = 0):
        graph = self.graph
        colors = dict()
        length = dict()
        for node in graph.keys():
            colors[node] = 'WHITE'
            length[node] = 0

        component_counter = 0
        parents = dict()
        # 0. component_counter 1. bipartite 2. length 3. parents
        info = [0, True, length, parents]
        for node in graph.keys():    
            if colors[node] == 'WHITE':
                info[0] = info[0] + 1
                Graph.bfs_visit(graph, colors, str(node_from), info, node_to)

        return info
    

    def shortest_route(self, node_from, node_to):
        info = self.bfs(str(node_from), str(node_to))
        s = str(node_to)
        while node_to != node_from:
            node_to = str(info[3][str(node_to)])
            s = s + " >- " + node_to

        return s[::-1]

    def is_full(self):
        nodes_count = len(self.nodes()) - 1
        for node in self.nodes():
            if len(self.graph[node]) != nodes_count:
                return False
        return True
                

class GraphOriented(Graph):
    def __init__(self):
        super().__init__()

    def is_strong_connected(self):
        return self.bfs(self.default_node)[0] == 1

    def is_weak_connected(self):
        for node in self.graph:
            if self.bfs(node)[0] == 1:
                return True
        return False

    def deg_out(self, node_to_count):
        self.deg(node_to_count)


class GraphNonOriented(Graph):
    def __init__(self, filename = 'GGraphNotOriented.txt'):
        super().__init__()
        self.filename = filename


    def is_connected(self):
        return self.bfs(self.default_node)[0] == 1


    def components_count(self):
        return self.bfs(self.default_node)[0]


    def from_file(self):
        file = open(self.filename, 'r')
        self.graph = dict()
        f = file.readlines()
        for node in f[0].split():
            self.graph[node] = []
            self.default_node = node

        for line in f[1:]:
            nodes = line.split()
            for node in nodes[1:]:
                self.graph[nodes[0]].append(node)
                self.graph[node].append(nodes[0])


    def is_bipartite(self):
        return self.bfs(self.default_node)[1]

class GraphWeighted(GraphNonOriented):
    def __init__(self, filename = 'GGraphWeighted.txt'):
        super().__init__(filename)
        self.weights = dict()

    def from_file(self):
        file = open(self.filename, 'r')
        
        f = file.readlines()
        for node in f[0].split():
            self.graph[node] = []
            self.default_node = node

        for line in f[1:]:
            node_1, node_2, value = line.split()
            self.graph[node_1].append(node_2)
            self.graph[node_2].append(node_1)
            self.weights[(node_1, node_2)] = int(value)
            self.weights[(node_2, node_1)] = int(value)

        return self.graph

    def __str__(self):
        return str((str(self.graph), str(self.weights)))


    def prim(self):
        new_graph = GraphWeighted()

        new_graph.graph[self.default_node] = []
        
        was_addition = 1
        while was_addition == 1:
            min_edge = ('0', '0', 10000)
            was_addition = 0
            for node in new_graph.graph:
                for adjacent_node in self.graph[node]:
                    if self.weights[(node, adjacent_node)] < min_edge[2] and new_graph.graph.get(adjacent_node, '0') == '0':
                        min_edge = (node,
                                    adjacent_node,
                                    self.weights[(node, adjacent_node)])
            if min_edge[2] != 10000:
                new_graph.graph[min_edge[1]] = []
                new_graph.graph[min_edge[0]].append(min_edge[1])
                new_graph.graph[min_edge[1]].append(min_edge[0])
                new_graph.weights[(min_edge[0], min_edge[1])] = min_edge[2]
                new_graph.weights[(min_edge[1], min_edge[0])] = min_edge[2]
                was_addition = 1

        return new_graph
            
        
    
graph = GraphOriented()
graph.from_file()
nograph = GraphNonOriented()
nograph.from_file()
print("Работа с ориентированным графом:")
print("Граф:", graph.graph)
print("Количество компонент связности:", graph.bfs('1'))
print("Сильно связный:", graph.is_strong_connected())
print("Слабо связный:", graph.is_weak_connected())
print("Работа с неориентированным графом:")
print(nograph.graph)
print(nograph.is_connected())
print(nograph.components_count())
print(nograph.is_bipartite())
print(nograph.is_full())
print("Кратчайший путь между 4 и 2: ", nograph.shortest_route('4', '2'))
fullgraph = GraphNonOriented('GGraphFull.txt')
fullgraph.from_file()
print("Работа с полным графом:")
print(fullgraph.graph)
print("Граф полный?", fullgraph.is_full())
print("Степень вершины 2 полного графа:", fullgraph.deg('2'))
print("Дополнение графа 2:")
print(Graph.inverse(nograph).graph)
print("Дополнение полного графа:")
print(Graph.inverse(fullgraph).graph)
weightedgraph = GraphWeighted()
weightedgraph.from_file()
print("Взвешенный граф:", weightedgraph)
minimum_tree = weightedgraph.prim()
print("Минимальное дерево:", minimum_tree)
        
