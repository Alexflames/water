# Grigoriev, 451
###################
preps = [' ', ',', ';', '.', '!', '?']
alphabet = []
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

    keyText = []
    for i in range(len(text) // len(keyword)):
        for symb in keyword:
            keyText.append(symb)
    for i in range(len(text) % len(keyword)):
        keyText.append(keyword[i])

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

    keyText = []
    for i in range(len(text) // len(keyword)):
        for symb in keyword:
            keyText.append(symb)
    for i in range(len(text) % len(keyword)):
        keyText.append(keyword[i])

    for i in range(len(text)):
        answer = answer + alphabet[(alphabet.index(text[i]) -
                                    alphabet.index(keyText[i])) % len(alphabet)]

    return answer


create_alphabet()
print(encode_file("task12.txt", 'солнцестояние'))
print(decode_file("task12_en.txt", 'солнцестояние'))
