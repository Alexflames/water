# Классы: печатное издание, журнал, книга, учебник
class Paper:
    def __init__(self, publisher, year, title):
        self.publisher = publisher
        self.year = year
        self.title = title


class Magazine(Paper):
    def __init__(self, publisher, year, title, number, month):
        super().__init__(publisher, year, title)
        self.number = number
        self.month = month


class Book(Paper):
    def __init__(self, publisher, year, title, topic, author, pages):
        super().__init__(publisher, year, title)
        self.topic = topic
        self.author = author
        self.pages = pages


class SchoolBook(Book):
    def __init__(self, publisher, year, title, topic, author, pages,
                 purpose):
        super().__init__(publisher, year, title, topic, author, pages)
        self.purpose = purpose


paper = Paper('Саратовский мясокомбинат', 2019, 'Пособие по нарезке мяса')
magazine = Magazine('Саратовский мясокомбинат', 2019, 'Мясник недели',
                    444, 4)
book = Book('GreenPeace', 2019, 'The extreme danger of Saratov butchers',
            'nature, society', 'J.K. Rowling', 500)
school_book = SchoolBook('неСГУ', 2015, 'Как разложить противника на ряд Фурье',
                         'самооборона', 'Вася Демидович', 15350,
                         'Студенты 3 курса факультета неКНИТ')

class Vector:
    def __init__(self, comp):
        self.comp = []
        try:
            for i in range(len(comp)):
                icomp = float(comp[i])
                self.comp.append(icomp)
        except ValueError:
            print("Вектор должен состоять из чисел а не строк!")

    def __getitem__(self, key):
        return self.comp[key]

    def __setitem__(self, key, value):
        self.comp[key] = value
        
    def __eq__(self, other):
        for i in range(len(self.comp)):
            if self[i] != other[i]:
                return False
        return True

    def __ne__(self, other):
        return not (self == other)

    def __neg__(self):
        return Vector(list(map(lambda x: -x, self.comp)))

    def __add__(self, other):
        new_vector = Vector([])
        for i in range(len(self.comp)):
            new_vector.comp.append(self[i] + other[i])
        return new_vector

    def __mul__(self, other):
        if isinstance(other, int) or isinstance(other, float):
            return Vector(list(map(lambda x: x * other, self.comp)))
        else:
            new_vector = Vector([])
            for i in range(len(self.comp)):
                new_vector.comp.append(self[i] * other[i])
                return new_vector

    def __str__(self):
        s = "("
        for comp in self.comp[:-1]:
            s = s + str(comp) + ", "
        return s + str(self.comp[-1]) + ")"

    def norma(self):
        s = 0
        for x in self.comp:
            s += x * x
        return s ** (1/2)

    def normalize(self):
        s = 0.
        for x in self.comp:
            s += x
        return Vector(list(map(lambda x: round(x / s, 2), self.comp)))

    @staticmethod
    def collinear(v1, v2):
        return v1.normalize() == v2.normalize()
        
v1 = Vector([3,4,5])
v2 = Vector([3,4,5])
print(v1 == v2)
v2[2] = 6
print(v1 == v2)
print(v1)
print(v1.norma())
print(v1.normalize())
v3 = Vector([6, 8, 10])
print(v3.normalize())
print(Vector.collinear(v1, v3))
print(v1 + v2)
print(v1 * v2)
print(v1 * 5)
        

