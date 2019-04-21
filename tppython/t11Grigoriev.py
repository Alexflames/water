# Grigoriev, 351
import math
# task 1
def otr_len(t1, t2):
    return math.sqrt((t2[0] - t1[0]) ** 2 + (t2[1] - t1[1]) ** 2)

def exists_triangle(t1, t2, t3):
    t1t2, t2t3, t3t1 = otr_len(t1, t2), otr_len(t2, t3), otr_len(t3, t1)
    return t1t2 < t2t3 + t3t1 and t2t3 < t1t2 + t3t1 and t3t1 < t1t2 + t2t3

def s_triangle(t1, t2, t3):
    p = (otr_len(t1, t2) + otr_len(t2, t3) + otr_len(t3, t1)) * (1/2)
    return math.sqrt((p * (p - otr_len(t1, t2))
            * (p - otr_len(t2, t3)) * (p - otr_len(t3, t1))))

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
    if this_s < mins:
        mins = this_s
        minpts[0], minpts[1], minpts[2] = thispts[0], thispts[1], thispts[2]
print(minpts, mins)

##def change(list1, list2):
##    n1, n2 = len(list1), len(list2)
##    for i in range(n1):
##        list2.append(list1[i])
##
##    for i in range(n2):
##        list1.append(list2[i])
##
##    del list1[0:n1]
##    del list2[0:n2]
##
##list1 = [2, 3, 4]
##list2 = [0, 1, 8, 9, 10]
##change(list1, list2)
##print(list1)
##print(list2)

##def calc_symb_percentage(line, sym):
##    good, alls = 0, 0
##    for char in line:
##        if char.isalpha():
##            good = good + 1 if char == sym else good
##            alls = alls + 1
##    return 0 if good == 0 or alls == 0 else good / alls
##
##f = open('t11input.txt')
##lineN = 0
##sym = ''
##maxp, max_line_N = 0, 0
##for line in f:
##    if lineN == 0:
##        sym = line[0]
##    else:
##        perc = calc_symb_percentage(line, sym)
##        if perc > maxp:
##            maxp = perc
##            max_line_N = lineN
##    lineN = lineN + 1
##
##print(maxp, max_line_N)
##f.close()

list_items = []
check_counter = 1

def add_item(name, value):
    global list_items
    list_items.append((name, value))

def print_receipt():
    global check_counter, list_items
    if bool(list_items):
        sum_vals = 0
        print("Чек %d. Всего предметов: %d " % (check_counter, len(list_items)))
        for item in list_items:
            print("%s - %d" % (item[0], item[1]))
            sum_vals = sum_vals + item[1]
        check_counter = check_counter + 1
        list_items = []
        print("Итого: %s" % sum_vals)
        print("-----")

add_item('Блокнот', 100)
print_receipt()

add_item('Ручка', 70)
print_receipt()
print_receipt()

add_item('Булочка', 15)
add_item('Булочка', 15)
add_item('Чай', 5)
print_receipt()

add_item('Булочка', 15)
add_item('Булочка', 15)
# ....
