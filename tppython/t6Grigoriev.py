# Grigoriev, 351
s = str(input())
print(s[2])
print(s[-2])
print(s[0:5])
print(s[:-2])
print(s[::2])
print(s[1::2])
print(s[::-1])
print(s[::-2])
print(len(s))

s = str(input())
left = s.find('f')
if left != -1:
    print(left)
right = s.rfind('f')
if left != right and right != -1: 
    print(right)

s = str(input())
print(s[:s.find('h')] + s[s.rfind('h'):s.find('h'):-1] + s[s.rfind('h'):])

print(str(input()).replace('@', ''))