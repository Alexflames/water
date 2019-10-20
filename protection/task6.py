# Grigoriev, 451
###################
preps = [' ', ',', ';', '.', '!', '?']
coded = []
alphabet = []
alphabet_size = 0
###################


def create_alphabet():
    global coded
    global alphabet
    global alphabet_size
    # alphabet = [chr(x) for x in range(ord('а'), ord('я') + 1)] + [
    #     chr(x) for x in range(ord('0'), ord('9') + 1)] + [x for x in preps]
    alphabet = [chr(x) for x in range(ord('а'), ord('я') + 1)]
    alphabet_size = len(alphabet)
    for i in range(alphabet_size):
        for j in range(alphabet_size):
            coded.append(alphabet[(i + j) % alphabet_size])
            # decoded.append()


def encode_file(filename, keyword):
    f = open(filename, 'r', encoding='utf-8')
    # fw = open("task4_res.txt", 'w', encoding='utf-8')
    answer = ""
    keyword_i = 0
    for row in f:
        for symbol in row:
            if (symbol not in coded):
                answer = answer + symbol
                continue
            if (symbol == '\n'):
                continue
            # Индекс текущей буквы ключевого слова в алфавите
            keyword_index = alphabet.index(keyword[keyword_i])
            alphabet_index = alphabet.index(symbol) * alphabet_size
            answer = answer + coded[alphabet_index + keyword_index]
            keyword_i = (keyword_i + 1) % len(keyword)
    return answer


def decode_file(filename, keyword):
    f = open(filename, 'r', encoding='utf-8')
    # fw = open("task4_res.txt", 'w', encoding='utf-8')
    answer = ""
    keyword_i = 0
    for row in f:
        for symbol in row:
            if (symbol not in coded):
                answer = answer + symbol
                continue
            if (symbol == '\n'):
                continue
            # Индекс текущей буквы ключевого слова в алфавите
            kw_index = alphabet.index(keyword[keyword_i])
            alph_index = alphabet.index(symbol) + alphabet_size - kw_index
            answer = answer + alphabet[alph_index % alphabet_size]
            keyword_i = (keyword_i + 1) % len(keyword)
    return answer


create_alphabet()
keyword = 'сосиска'
print(encode_file("task4.txt", keyword))
print(decode_file("task6_en.txt", keyword))
