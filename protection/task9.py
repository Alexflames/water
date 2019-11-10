# Grigoriev, 451
###################
preps = [' ', ',', ';', '.', '!', '?', '\n']
alphabet = []
###################


def create_alphabet():
    global alphabet
    alphabet = [chr(x) for x in range(ord('а'), ord('я') + 1)] + [
        chr(x) for x in range(ord('0'), ord('9') + 1)] + [x for x in preps]


def xor_bit(bit1, bit2):
    return (int(bit1) + int(bit2)) % 2


def to_bit(char):
    return bin(ord(char))[2:].zfill(16)


def encode_file(filename, keyword):
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
