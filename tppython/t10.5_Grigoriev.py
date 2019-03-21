# Grigoriev, 351
import datetime
##d, m, y = [int(x) for x in input().split()]
##bday = datetime.date(y, m, d)
##today = datetime.date.today()
##thisybday = datetime.date(today.year, m, d)
##wasBday = 1 if thisybday < today else 0
##nextbday = thisybday if wasBday == 0 else datetime.date(today.year + 1, m, d)
##print(today.year - bday.year - 1 + wasBday, nextbday.isoweekday())

d, m, y, last = [int(x) for x in input().split()]
ans = "ДА" if ((datetime.date.today() -
                datetime.date(y, m, d)).days > last) else "НЕТ"
print("Просрочено? " + ans)
