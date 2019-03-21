# Grigoriev, 351
##def firstKey(t):
##    return t[0]
##def secondKey(t):
##    return t[1]
##
##wordFreq = dict()
##for _ in range(int(input())):
##    for word in input().split():
##        wordFreq[word] = 1 if word not in wordFreq else wordFreq[word] + 1
##listAns = []
##for word, freq in wordFreq.items():
##    listAns.append((freq, word))
##listAns = sorted(listAns, key=lambda x: x[1])
##listAns = sorted(listAns, key=lambda x: x[0], reverse=True)
##print('\n'.join(word for (freq, word) in listAns))

##bloodline = dict()
##levels = dict()
##n = int(input())
##for _ in range(n - 1):
##    person, parent = input().split()
##    bloodline[person] = parent
##    levels[parent] = 0
##
##for _ in range(len(bloodline)):
##    for person in bloodline.keys():
##        levels[person] = levels[bloodline[person]] + 1
##
##for person in sorted(levels.keys()):
##    print(person, levels[person])

n = int(input())
bdays = dict()
bmonth = dict()
for _ in range(n):
    name, day, month = input().split()
    bdays[name] = day
    bmonth[name] = month

m = int(input())
for _ in range(m):
    month = input()
    goodppl = []
    for person in sorted(bmonth.keys()):
        if bmonth[person] == month:
            goodppl.append((person, bdays[person]))
    ppl = ""
    for person in sorted(goodppl, key=lambda x: x[1]):
        ppl = ppl + person[0] + " " + str(person[1]) + " "
    print(ppl)
