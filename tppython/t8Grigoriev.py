# Grigoriev, 351
import math

##n = int(input())
##a = [['.'] * n for i in range(n)]
##for i in range(n):
##    a[n // 2][i] = '*'
##    a[i][n // 2] = '*'
##    a[i][i] = '*'
##    a[i][n-i-1] = '*'
##
##for row in a:
##    print(' '.join([str(elem) for elem in row]))

##n = int(input())
##a = [[0] * n for i in range(n)]
##for i in range(n):
##    for j in range(n):
##        a[i][j] = abs(i - j)
##
##for row in a:
##    print(' '.join(str(num) for num in row))

n = int(input())
a = [['.'] * n for i in range(n)]
for i in range(n):
    a[i] = [sym for sym in input()]
win = '-' # Winner
for i in range(n):
    cnthor = cntver = 1       #same symbols sequence length
    lastsymV = lastsymH = '.' #last vertical and horizontal symbol
    for j in range(n):
        cnthor = cnthor + 1 if a[i][j] != '.' and a[i][j] == lastsymH else 1
        lastsymH = a[i][j]
        if cnthor == 3:
            win = lastsymH
            break
        cntver = cntver + 1 if a[j][i] != '.' and a[j][i] == lastsymV else 1
        lastsymV = a[j][i]
        if cntver == 3:
            win = lastsymV
            break
print(win)
##for row in a:
##    print(' '.join(str(sym) for sym in row))
