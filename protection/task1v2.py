# Grigoriev, 451
###################
rus_m = 33
num_m = 10
preps = [',', '.', ':', ';', '-']
m = rus_m + num_m + len(preps)  # alphabet size
alphabet = dict()
###################
# print(ord('а'))
print('Введите n, k. Например, (5, 7)')
n, k = [int(x) for x in input().split()]


def create_alphabet():
    for i in range(ord('a') + rus_m):
        alph_code = i - ord('a')
        alphabet[i] = alph_code

    num_0_code = ord('0')
    for i in range(num_m):
        alph_code = i - rus_m - num_0_code
        alphabet[i] = alph_code

    for i in range(len(preps)):
        alph_code = i - rus_m - num_0_code
        alphabet[alph_code] = alph_code


def alphabet_equivalent(symbol):
    return alphabet[ord(symbol)]


def to_ceaser(code):
    return (code * n + k) % m


def un_ceaser(code):
    return (code - k) * unmod(n, m)


def unmod(a, m):
    a = a % m
    for x in range(1, m):
        if (a * x) % m == 1:
            return x
    return 1


def read_input():
    input_text = []
    return input_text


def check_n_m():
    