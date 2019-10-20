# Grigoriev, 451
###################
import math
preps = [' ', ',', ';', '.', '!', '?']
coded = dict()
decoded = dict()
###################


def create_alphabet():
    alphabet = [chr(x) for x in range(ord('а'), ord('я') + 1)] + [
        chr(x) for x in range(ord('0'), ord('9') + 1)] + [x for x in preps]
    max_square = math.ceil(math.sqrt(len(alphabet)))
    for i in range(max_square):
        for j in range(max_square):
            index = i * max_square + j
            if (index >= len(alphabet)):
                break
            coded[alphabet[index]] = str(i) + str(j)
            decoded[str(i) + str(j)] = alphabet[index]


def encode_file(filename):
    f = open(filename, 'r', encoding='utf-8')
    # fw = open("task4_res.txt", 'w', encoding='utf-8')
    answer = ""
    for row in f:
        for symbol in row:
            if (symbol == '\n'):
                continue
            answer = answer + coded[symbol] + ' '
        answer = answer + '\n'
    return answer


def decode_file(filename):
    f = open(filename, 'r', encoding='utf-8')
    # fw = open("task4_res.txt", 'w', encoding='utf-8')
    answer = ""
    for row in f:
        for numbers in row.split():
            if (numbers == '\n'):
                continue
            answer = answer + decoded[numbers]
        answer = answer + '\n'
    return answer


create_alphabet()
print(encode_file("task4.txt"))
print(decode_file("task4_en.txt"))
