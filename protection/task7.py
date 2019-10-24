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
    # fw = open("task4_res.txt", 'w', encoding='utf-8')
    answer = ""
    kw_index = 0
    for row in f:
        for symbol in row:
            if (symbol == '\n'):
                continue
            alphabet_index = alphabet.index(symbol)
            kw_alph_ind = alphabet.index(keyword[kw_index])
            index = (alphabet_index + kw_alph_ind) % len(alphabet)
            answer = answer + alphabet[index]
            kw_index = kw_index % len(keyword)
        answer = answer + '\n'
    return answer


def decode_file(filename, keyword):
    f = open(filename, 'r', encoding='utf-8')
    # fw = open("task4_res.txt", 'w', encoding='utf-8')
    answer = ""
    kw_index = 0
    for row in f:
        for symbol in row:
            if (symbol == '\n'):
                continue
            alphabet_index = alphabet.index(symbol)
            kw_alph_ind = alphabet.index(keyword[kw_index])
            index = (alphabet_index - kw_alph_ind) % len(alphabet)
            answer = answer + alphabet[index]
            kw_index = kw_index % len(keyword)
        answer = answer + '\n'
    return answer


create_alphabet()
print(encode_file("task7.txt", 'знамение'))
print(decode_file("task7_en.txt", 'знамение'))
