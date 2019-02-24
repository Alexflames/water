# Grigoriev, 351
A = int(input())
B = int(input())
for i in range((A + 1) // 2 * 2, B // 2 * 2, -2):
    print(i - 1)

N = int(input())
cnt = 0
for i in range(0, N):
    num = int(input())
    if num == 0:
        cnt = cnt + 1
print(cnt)

sumN = 0
sumnum = 0
N = int(input())
for i in range(1, N + 1):
    if i != N:
        num = int(input())
        sumnum += num
    sumN += i
print(sumN - sumnum)

