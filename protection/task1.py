# Grigoriev, 451
###################
rus_m = 33
num_m = 10
preps = [',','.',':',';','-']
A_to_B = dict()
B_to_A = dict()
code_to_sym = [] 
m = rus_m + num_m + len(preps)  # alphabet size
###################
#print(ord('а'))
print('Введите n, k. Например, (5, 7)')
n, k = [int(x) for x in input().split()]

# A = ord(number)
# chr(ord(number)) = number

def create_alphabet():
    rus_a_code = ord('а')
    for i in range(rus_m):
        A_letter = i + rus_a_code
        ceaser_code = divmod(i * n + k, m)[1]
        code_to_sym.append(chr(A_letter))
        A_to_B[A_letter] = ceaser_code 
        B_to_A[ceaser_code] = A_letter
        
    num_0_code = ord('0')
    for i in range(num_m):
        A_letter = i + num_0_code
        code_to_sym.append(chr(A_letter))
        ceaser_code = divmod((i + rus_m) * n + k, m)[1]
        A_to_B[A_letter] = ceaser_code
        B_to_A[ceaser_code] = A_letter

    for i in range(len(preps)):
        A_letter = ord(preps[i])
        code_to_sym.append(preps[i])
        ceaser_code = divmod((i + rus_m + num_m) * n + k, m)[1]
        A_to_B[A_letter] = ceaser_code
        B_to_A[ceaser_code] = A_letter

##    for i in range(len(code_to_sym)):
##        print(i, code_to_sym[i], code_to_sym[A_to_B[ord(code_to_sym[i])]],
##              chr(B_to_A[A_to_B[ord(code_to_sym[i])]]))

def encode_sym(symbol):
    to_num = ord(symbol)
    return code_to_sym[A_to_B[to_num]]

def encode_file(filename):
    f = open(filename, 'r')
    fw = open("task1_res.txt", 'w')
    for row in f:
        encoded_string = ""
        for word in row.split():
            encoded_string = encoded_string + ''.join([encode_sym(symbol) for symbol in word])
        print(row, "--->", encoded_string)
        fw.write(encoded_string)

def decode_sym(symbol):
    number = ord(symbol)
    return code_to_sym[B_to_A[to_num]]

def decode_file(filename):
    f = open(filename, 'r')
            

create_alphabet()
encode_file("task1.txt")


