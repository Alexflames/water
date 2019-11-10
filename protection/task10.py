def decode_f1le(filename, keyword):
    f = open(filename, 'r', encoding='utf-8')
    answer = ""
    for row in f:
        for symbol in row:
            answer = answer + symbol
    return answer


# Grigoriev, 451
###################
preps = [' ', ',', ';', '.', '!', '?', '\n']
kw_table = []
kw_normal = dict()
kw_sorted = dict()
alphabet = []
###################


def create_alphabet():
    global alphabet
    alphabet = [chr(x) for x in range(ord('а'), ord('я') + 1)] + [
        chr(x) for x in range(ord('0'), ord('9') + 1)] + [x for x in preps]


def keyword_init(keyword):
    global kw_table
    kw_seq = []
    kw_table = []
    for word in keyword:
        kw_table.append([])
        kw_seq.append(word)

    kw_seq.sort()
    for i in range(len(kw_seq)):
        kw_sorted[kw_seq[i]] = i
    for i in range(len(keyword)):
        kw_normal[keyword[i]] = i


def encode_file(filename, keyword):
    global kw_table
    f = open(filename, 'r', encoding='utf-8')
    # fw = open("task4_res.txt", 'w', encoding='utf-8')
    keyword_init(keyword)
    answer = ""
    kw_rows = len(keyword)
    kw_i = 0
    for row in f:
        s_in_row = len(row) // kw_rows
        for symbol in row:
            kw_table[kw_i // s_in_row].append(symbol)
            kw_i = kw_i + 1
    answer = ""
    kw_table = [list(x) for x in zip(*kw_table)]
    for j in range(len(kw_table)):
        for word in keyword:
            answer = answer + kw_table[j][kw_sorted[word]]
    return answer


def decode_file(filename, keyword):
    global kw_table
    f = open(filename, 'r', encoding='utf-8')
    # fw = open("task4_res.txt", 'w', encoding='utf-8')
    keyword_init(keyword)
    answer = ""
    kw_rows = len(keyword)
    kw_i = 0
    for row in f:
        s_in_row = len(row) // kw_rows
        for symbol in row:
            kw_table[kw_i // s_in_row].append(symbol)
            kw_i = kw_i + 1
    kw_table = [list(x) for x in zip(*kw_table)]
    #print(kw_table)
    answer = ""
    kw = list(keyword)
    kw.sort()
    #print(kw)    
    for j in range(len(keyword)):
        for i in range(len(kw)):
            for k in range(kw_normal[kw[i]] + j, len(kw_table), len(keyword)):
                answer = answer + kw_table[k][i]
    return answer


create_alphabet()
print(encode_file("task10.txt", 'лира'))
print("\nДекодировано:\n")
print(decode_f1le("task10.txt", 'лира'))
