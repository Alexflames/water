# Grigoriev, 351
##N, M = (int(num) for num in input().split())
##A = set()
##B = set()
##for i in range(N):
##    num = int(input())
##    A.add(num)
##for i in range(M):
##    num = int(input())
##    B.add(num)
##print(len(A & B))
##ABlist = list(A & B)
##ABlist.sort()
##print(' '.join(str(num) for num in ABlist))
##print(len(A - B))
##AmBlist = list(A - B)
##AmBlist.sort()
##print(' '.join(str(num) for num in AmBlist))
##print(len(B - A))
##BmAlist = list(B - A)
##BmAlist.sort()
##print(' '.join(str(num) for num in BmAlist))

##n = int(input())
##Words = set()
##for i in range(n):
##    for word in input().split(' '):
##        Words.add(word)
##print(len(Words))

n = int(input())
schoolBoys = []
All = set()
AtleastOne = set()
for i in range(n):
    m = int(input())
    SchoolBoy = set()
    for _ in range(m):
        lang = input()
        SchoolBoy.add(lang)
        SchoolBoy.add(lang)
    if i == 0:
        All.update(SchoolBoy)
    else:
        All &= SchoolBoy
    AtleastOne |= SchoolBoy
print(len(All))
for lang in sorted(All):
    print(lang)
print(len(AtleastOne))
for lang in sorted(AtleastOne):
    print(lang)

