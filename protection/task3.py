# Grigoriev, 451
###################
char_count = dict()
pairs_count = 0
###################


def read_file(filename):
    global pairs_count

    f = open(filename, 'r', encoding='utf-8')
    fw = open("task3_res.txt", 'w', encoding='utf-8')

    for i in range(ord('а'), ord('я') + 1):
        for j in range(ord('а'), ord('я') + 1):
            pair = chr(i) + chr(j)
            char_count[pair] = 0

    for row in f:
        for i in range(len(row) - 1):
            pair = row[i] + row[i + 1]
            if pair in char_count:
                char_count[pair] += 1
            else:
                char_count[pair] = 1
            pairs_count += 1

    for i in range(ord('а'), ord('я') + 1):
        for j in range(ord('а'), ord('я') + 1):
            pair = chr(i) + chr(j)
            outstr = "{}: {:.4f}".format(pair, char_count[pair] / pairs_count)
            print(outstr)
            fw.write(outstr + '\n')


read_file("task2.txt")
