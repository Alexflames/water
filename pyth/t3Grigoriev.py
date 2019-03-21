# Grigoriev, 351
import math

# Impressive programming skills
# 9 45 - 9 50
# 10 35 - 10 50
# 11 35 - 11 40 ...
def task1():
    n = int(input())
    to_add = n * 45 + n//2 * 5 + (n - 1)//2 * 15
    print(9 + to_add // 60, to_add % 60)

def task2():
    H, M, S = map(int, input().split())
    print(H * 30 + M * 0.5 + S * (0.5 / 60))

def task3():
    n = int(input())
    print((n % 30) * 12)

def task4():
    P, X, Y = map(int, input().split())
    inc_rub = X + (X * P / 100)
    inc_cop = int(Y + (Y * P / 100) + (inc_rub * 100) % 100)
    print(int(inc_rub) + inc_cop // 100, inc_cop % 100)

