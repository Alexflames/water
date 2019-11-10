# Grigoriev, 451
###################
preps = [' ', ',', ';', '.', '!', '?', '\n']
kw_table = []
kw_sequence = dict()
alphabet = []
###################


def create_alphabet():
    global alphabet
    alphabet = [chr(x) for x in range(ord('а'), ord('я') + 1)] + [
        chr(x) for x in range(ord('0'), ord('9') + 1)] + [x for x in preps]


def keyword_init_encode(keyword):
    kw_seq = []
    for word in keyword:
        kw_table.append([])
        kw_seq.append(word)
    kw_seq.sort()


def encode_file(filename, keyword):
    f = open(filename, 'r', encoding='utf-8')
    # fw = open("task4_res.txt", 'w', encoding='utf-8')
    answer = ""
    kw_i = 0
    for row in f:
        for symbol in row:
            kw_i += 1
    return answer


def decode_file(filename, keyword):
    f = open(filename, 'r', encoding='utf-8')
    # fw = open("task4_res.txt", 'w', encoding='utf-8')
    answer = ""
    kw_b = ""
    for char in keyword:
        kw_b = kw_b + to_bit(char)

    kw_index = 0
    for row in f:
        for symbol in row:
            new_bit = ""
            for bit in to_bit(symbol):
                new_bit = new_bit + str(xor_bit(kw_b[kw_index], bit))
                kw_index = (kw_index + 1) % len(kw_b)
            answer = answer + chr(int(new_bit, 2))
    return answer


create_alphabet()
print(encode_file("task9.txt", '@aA@@AAacaaa'))
print("\nДекодировано:\n")
print(encode_file("task9_en.txt", '@aA@@AAacaaa'))
