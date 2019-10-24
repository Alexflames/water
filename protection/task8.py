# Grigoriev, 451
###################
# preps = [' ', ',', ';', '.', '!', '?']
alphabet = []
coded = dict()
###################


def create_alphabet(keyword):
    global alphabet
    global coded
    alphabet = [chr(x) for x in range(ord('а'), ord('я') + 1)]  # + [
#        chr(x) for x in range(ord('0'), ord('9') + 1)] + [x for x in preps]
    alphabet_symbol = ord('а')
    for char in keyword:
        flag = chr(alphabet_symbol) in keyword
        while flag:
            alphabet_symbol += 1
            flag = chr(alphabet_symbol) in keyword
        coded[chr(alphabet_symbol)] = char
        coded[char] = chr(alphabet_symbol)
        alphabet_symbol += 1

    alphabet_symbol = ord('я')


def encode_file(filename):
    f = open(filename, 'r', encoding='utf-8')
    # fw = open("task4_res.txt", 'w', encoding='utf-8')
    answer = ""
    for row in f:
        for symbol in row:
            if (symbol not in alphabet):
                answer = answer + symbol
                continue
            answer = answer + coded[symbol]
    return answer


def decode_file(filename):
    f = open(filename, 'r', encoding='utf-8')
    # fw = open("task4_res.txt", 'w', encoding='utf-8')
    answer = ""
    for row in f:
        for symbol in row:
            if (symbol not in alphabet):
                answer = answer + symbol
                continue
            answer = answer + coded[symbol]
    return answer


keyword = "квенролдьтичсмбш"
create_alphabet(keyword)
print(coded)
print(encode_file("task8.txt"))
print(decode_file("task8_en.txt"))
