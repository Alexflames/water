# Grigoriev, 451
###################
preps = [' ', ',', ';', '.', '!', '?']
alphabet = []
A = 7
C = 4
###################


def create_alphabet():
    global alphabet
    alphabet = [chr(x) for x in range(ord('а'), ord('я') + 1)] + [
        chr(x) for x in range(ord('0'), ord('9') + 1)] + [x for x in preps]


def encode_file(filename, keyword):
    f = open(filename, 'r', encoding='utf-8')
    text = ""
    for row in f:
        for symbol in row:
            text = text + symbol
    answer = ""

    T = 2
    keyText = []
    for i in range(len(text) // len(keyword)):
        for symb in keyword:
            keyText.append(keyword[T])
            T = (A * T + C) % len(keyword)
    for i in range(len(text) % len(keyword)):
        keyText.append(keyword[T])
        T = (A * T + C) % len(keyword)

    for i in range(len(text)):
        answer = answer + alphabet[(alphabet.index(text[i]) +
                                    alphabet.index(keyText[i])) % len(alphabet)]

    return answer


def decode_file(filename, keyword):
    f = open(filename, 'r', encoding='utf-8')
    text = ""
    for row in f:
        for symbol in row:
            text = text + symbol
    answer = ""

    T = 2
    keyText = []
    for i in range(len(text) // len(keyword)):
        for symb in keyword:
            keyText.append(keyword[T])
            T = (A * T + C) % len(keyword)
    for i in range(len(text) % len(keyword)):
        keyText.append(keyword[T])
        T = (A * T + C) % len(keyword)

    for i in range(len(text)):
        answer = answer + alphabet[(alphabet.index(text[i]) -
                                    alphabet.index(keyText[i])) % len(alphabet)]

    return answer


create_alphabet()
print(encode_file("task13.txt", 'солнцестояние'))
print(decode_file("task13_en.txt", 'солнцестояние'))
