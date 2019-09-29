# Grigoriev, 451
###################
char_count = dict()
chars_count = 0
###################


def read_file(filename):
    global chars_count

    f = open(filename, 'r', encoding='utf-8')
    fw = open("task2_res.txt", 'w', encoding='utf-8')

    for i in range(ord('а'), ord('я') + 1):
        char_count[chr(i)] = 0

    for row in f:
        for symbol in row:
            if symbol in char_count:
                char_count[symbol] += 1
            else:
                char_count[symbol] = 1
            chars_count += 1

    for i in range(ord('а'), ord('я') + 1):
        outstr = "{}: {:.4f}".format(chr(i), char_count[chr(i)] / chars_count)
        print(outstr)
        fw.write(outstr + '\n')


read_file("task2.txt")
