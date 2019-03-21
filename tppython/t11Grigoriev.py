# Grigoriev, 351
import math
# task 1
def otr_len(t1, t2):
    return ((t2[0] - t1[0]) ** 2 + (t2[1] - t1[1]) ** 2) ** (1/2)

def exists_triangle(t1, t2, t3):
    t1t2, t2t3, t3t1 = otr_len(t1, t2), otr_len(t2, t3), otr_len(t3, t1)
    return t1t2 < t2t3 + t3t1 and t2t3 < t1t2 + t3t1 and t3t1 < t1t2 + t2t3

def s_triangle(t1, t2, t3):
    p = (otr_len(t1, t2) + otr_len(t2, t3) + otr_len(t3, t1)) * (1/2)
    return (p * (p - otr_len(t1, t2))
            * (p - otr_len(t2, t3)) * (p - otr_len(t3, t1))) ** (1/2) 

print("Длина отрезка с точками (1,1) и (3, 3)", otr_len((1, 1), (3, 3)))
print("Существует треуг. с вершинами (2,2), (3,3), (5,5)?",
      exists_triangle((2,2), (3,3), (5,5)))
print("Существует треуг. с вершинами (2,2), (3,3), (6,6)?",
      exists_triangle((2,2), (3,3), (6,6)))
print("Площадь треуг. с вершинами (2, 2), (2, 5), (5, 5):",
      s_triangle((2,2), (2,5), (5,5)))

n = int(input())
pts = []
for i in range(n):
    info = input()
    t1, t2 = map(int, info.split(' '))
    pts.append((t1, t2))

minpts = [pts[0], pts[1], pts[2]] 
mins = s_triangle(minpts[0], minpts[1], minpts[2])
for i in range(1, n):
    thispts = [pts[i], pts[(i+1)%n], pts[(i+2)%n]]
    this_s = s_triangle(thispts[0], thispts[1], thispts[2])
    print(this_s)
    if this_s < mins:
        mins = this_s
        minpts[0], minpts[1], minpts[2] = thispts[0], thispts[1], thispts[2]
print(minpts, mins)
