# Grigoriev, 351
def task1():
    n = int(input()) % 1440
    print(n // 60, n % 60) 

def task2():
    a, b, c = map(int, input().split())
    print((a + 1) // 2 + (b + 1) // 2 + (c + 1) // 2)

def task3():
    a, b, l, N = map(int, input().split())
    print(2 * (a*N + b*(N - 1) + l) - a)
