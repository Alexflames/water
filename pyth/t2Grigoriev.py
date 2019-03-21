# Grigoriev, 351
import math

def task1():
    i1, j1, i2, j2 = map(int, input().split())
    clr1 = math.fabs(i1 - j1) % 2
    clr2 = math.fabs(i2 - j2) % 2
    print('YES') if clr1 == clr2 else print('NO')

def task2():
    i1, j1, i2, j2 = map(int, input().split())
    d1 = math.fabs(i1 - i2)
    d2 = math.fabs(j1 - j2)
    print('YES') if d1 <= 1 and d2 <= 1 else print('NO')

def task3():
    i1, j1, i2, j2 = map(int, input().split())
    if i1 == i2 or j1 == j2 or (math.fabs(i1 - i2) == math.fabs(j1 - j2)):
        print('YES')
    else:
        print('NO')

def task4():
    i1, j1, i2, j2 = map(int, input().split())
    d1 = math.fabs(i1 - i2)
    d2 = math.fabs(j1 - j2)
    print('YES') if (d1 == 2 and d2 == 1) or (d1 == 1 and d2 == 2) else print('NO')

def task5():
    N, M, x, y = map(int, input().split())
    long = min(N, M)
    short = max(N, M)
    d1 = long - x if long - x < x else x
    d2 = short - y if short - y < y else y
    print(d1) if d1 < d2 else print(d2)

