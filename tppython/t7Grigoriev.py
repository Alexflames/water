# Grigoriev, 351
import re
import math

##a = [int(s) for s in input().split()]
##for item in a:
##    if item % 2 == 0:
##        print(item)

##a = [int(s) for s in input().split()]
##for i in range(1, len(a)):
##    if (a[i - 1] > 0 and a[i] > 0) or (a[i - 1] < 0 and a[i] < 0):
##        print(a[i - 1], a[i])
##        break

##a = [int(s) for s in input().split()]
##maxel = a[0] 
##imax = 0
##for i in range(1, len(a)):
##    if a[i] > maxel:
##        maxel = a[i]
##        imax = i
##print (maxel, imax)

##a = [int(s) for s in input().split()]
##a.sort()
##a.reverse()
##cnt = 1
##for i in range(1, len(a)):
##    if a[i - 1] != a[i]:
##        cnt += 1
##print(cnt)

##l = input().split(',')
##maxlenwrong = 0
##wrongl = []
##for i in range(len(l)):
##    match = re.search(r'(?:\w+|\d+)+', l[i])[0] # l[i].isalnum()
##    if len(match) != len(l[i]):
##        maxlenwrong = max(maxlenwrong, len(l[i]))
##        wrongl.append(l[i])
##for i in range(len(wrongl)):
##    print(wrongl[i].rjust(maxlenwrong, ' '))


l = input().split(' ')
stackl = []
for sym in l:
    if sym.isdigit():
        stackl.append(int(sym))
    elif sym == '+':
        stackl[-2] = stackl[-2] + stackl[-1]
        del stackl[- 1]
    elif sym == '-':
        stackl[-2] = stackl[-2] - stackl[-1]
        del stackl[- 1]
    elif sym == '*':
        stackl[-2] = stackl[-2] * stackl[-1]
        del stackl[- 1]
    elif sym == '/':
        stackl[-2] = stackl[-2] / stackl[-1]
        del stackl[- 1]
    elif sym == '~':
        stackl[-1] = stackl[-1] * -1
    elif sym == '!':
        stackl[-1] = math.factorial(stackl[-1])
    elif sym == '#':
        stackl.append(stackl[-1])
    elif sym == '@':
        stackl[-3], stackl[-2], stackl[-1] = stackl[-2], stackl[-1], stackl[-3]
print (stackl[0])

