# Grigoriev, 351
max = 0
secondmax = 0
num = 1
while num != 0:
    num = int(input())
    if max == 0:
        max = num
    elif num > max:
        secondmax = max
        max = num
    elif num > secondmax:
        secondmax = num
print (secondmax)

num = 1
cur = 0
counter = 0
maxcounter = 1
while num != 0:
    num = int(input())
    if num == cur:
        counter = counter + 1
        if counter > maxcounter:
            maxcounter = counter 
    else:
        counter = 1
        cur = num
print (maxcounter)

import math

num = 1
n = sumsqr = av = 0
num = int(input())
while num != 0:
    av += num
    n += 1
    sumsqr += num * num
    num = int(input())
av /= n
print(math.sqrt((sumsqr - n * av * av) / (n - 1)))


