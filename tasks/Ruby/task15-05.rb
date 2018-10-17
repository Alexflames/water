class CashMachine
  def initialize(n, sum)
    @cassettes_count = n  # количество кассет в автомате
    @maxsum = sum         # максимальная принимаемая сумма
    @banknotes_hash = {}  # хеш банкнот
    @cassettes = []       # массив, каждый элемент - номинал и количество
    # создание пустых кассет
    @cassettes = Array.new(@cassettes_count) {[nil, 0]}
    Banknotes.each { |nom| @banknotes_hash[nom] = 0 }
  end

  Banknotes = [1, 2, 3, 5, 10].sort # Отсортировано, так как порядок важен 
                                    # для функции размена
  CassetteSpace = 5

  def new_max n
    @maxsum = n
    self
  end

  # Состояние автомата + подсчёт суммы денег
  def status
    money = 0
    @banknotes_hash.keys.each do |key|
      money += @banknotes_hash[key] * key
    end
    [money, @banknotes_hash, @cassettes]
  end

  def empty
    @cassettes = Array.new(@cassettes_count) {[nil, 0]}
    @banknotes_hash = self.normalise_hash({})
    self
  end

  def set_cassette n
    self.empty
    @cassettes_count = n
    @cassettes = Array.new(@cassettes_count) {[nil, 0]}
    self
  end

  #Вспомогательная функция:
  #Нормализация hash-а, чтобы его номиналы совпадали с автоматовскими,
  #и если их нет, то создать и приравнять нулю
  def normalise_hash(hs)
    Banknotes.each do |nom| 
      if !hs[nom] then hs[nom] = 0 end
    end
    hs
  end

  # Вспомогательная функция для load: поиск нужной кассеты
  # Выдает номер + количество банкнот в кассете
  # Сначала пытается найти незанятую кассету с такими же банкнотами, 
  # в случае неудачи пытается найти первую свободную
  def get_cassette nom
    @cassettes_count.times do |i|
      if @cassettes[i][0] == nom &&
         @cassettes[i][1] != CassetteSpace then return [i, @cassettes[i][1]] end
    end
    @cassettes_count.times do |i|
      if @cassettes[i][0] == nil
        @cassettes[i] = [nom, 0]
        return [i, 0]
      end
    end
    nil
  end

  # Вспомогательная функция для load: 
  # Заполняет кассету до предела
  def fill(amount, to_fill)
    space = CassetteSpace - amount
    if to_fill > space
      [CassetteSpace, to_fill - space]
    else
      [amount + to_fill, 0]
    end
  end 

 # Распределение банкнот по ячейкам
  def load(hs)
    @banknotes_hash = self.normalise_hash(@banknotes_hash)
    hs.keys.each do |nominal|
      @banknotes_hash[nominal] += hs[nominal]
      while hs[nominal] != 0
        cas_tofil = self.get_cassette(nominal)
        if !cas_tofil
          puts "В автомате нет места." 
          return hs 
        end
        spare_money = fill(cas_tofil[1], hs[nominal])
        @cassettes[cas_tofil[0]][1] = spare_money[0]
        hs[nominal] = spare_money[1]
      end
    end
    puts "Количество купюр в автомате изменено."
    hs
  end

  # Вспомогательная функция для change:
  # Полный перебор всех возможных комбинаций.
  # ----------------------------------------------------------------------------
  # Логика выполения рекурсивной функции:
  # берем максимально разрешенный номинал (если номинал не максимальный,
  # увеличиваем его и запускаем функцию) 
  # увеличиваем количество купюр, пока сумма не превышает нужную нам,
  # либо все купюры не использованы. Если не удалось получить ровную сумму,
  # возвращаемся на 1 уровень и увеличиваем количество купюр того уровня на 1. 
  # Алгоритм повторяется, пока не найдёт ответ / возьмёт все варианты 
  # ----------------------------------------------------------------------------
  # hs      - хэш всех купюр
  # i       - номер номинала банкноты в порядке возрастания, уровень рекурсии
  # nom     - максимально разрешенный номинал (запрещенный минус 1)
  # cur_sum - текущая сумма
  # sum     - требуемая сумма
  # ans     - хэш - ответ
  def brute_force(hs, i, nom, cur_sum, sum, ans)
    (hs[Banknotes[i]] + 1).times do |j|
      # iter_sum - сумма с учетом кол-ва банкнот текущего уровня
      iter_sum = cur_sum + j * Banknotes[i] 
      # print i
      # print " "
      # print j             # Можно раскомментировать и посмотреть ход 
      # print " "           # данной функции
      # print iter_sum
      # puts
      if iter_sum == sum 
        ans[Banknotes[i]] = j
        return [true, ans]
      end
      if iter_sum > sum
        return [false, nil]
      end
      # Если текущая сумма всё ещё меньше нужной,
      # то пытаемся уйти глубже на уровень
      rec_result = Array.new(2)
      if Banknotes[i + 1] && Banknotes[i + 1] <= nom 
        rec_result = self.brute_force(hs, i + 1, nom, iter_sum, sum, ans)
      end
      # Проверяем, получен ли результат благодаря уходу в рекурсию, либо
      # nil -> самый глубокий уровень
      # false -> результат не подходит
      # true -> найден результат 
      if rec_result[0]
        rec_result[1][Banknotes[i]] = j
        return [true, rec_result[1]]
      end
    end
    [false, nil]            # ответ не найден
  end

  def change(hs)
    save_hs = hs.dup
    save_cassettes = @cassettes.dup             # Создаем копии кассет.

    @cassettes_count.times do |i|                # Заполняем копии кассет 
      save_cassettes[i] = @cassettes[i].dup     # копиями внутренностей
    end                                         # соответствующих кассет.
    save_banknotes_hash = @banknotes_hash.dup

    banknotes_left = self.load(hs)              # Пробуем заполнить наш автомат
    # Если не удалось загрузить все банкноты, то возвращаем состояние начала
    banknotes_left.keys.each do |key|
      if banknotes_left[key] != 0
        @cassettes = save_cassettes
        @banknotes_hash = save_banknotes_hash
        puts "Возвращаю деньги."
        return hs
      end
    end

    hs = save_hs
    # Не превышает ли сумма максимальную?
    sum = 0
    hs.keys.each { |key| sum += hs[key] * key }
    if sum > @maxsum
      print "Максимальная сумма обмена: "
      puts @maxsum
      print "Действие невозможно, вы вставили: "
      puts sum
      return hs
    end

    # Самая страшная часть этой программы.
    #---------------------------------------------------------------------------
    # Ищем минимум из имеющихся номиналов банкнот
    min_nom = Banknotes.max 
    @banknotes_hash.keys.each do |key|
      if key < min_nom && @banknotes_hash[key] != 0 then min_nom = key end
    end
    ans_hash = self.normalise_hash({})          # здесь будет храниться ответ
    after_brute_force = Array.new(2)             # Результат функции перебора

    # аргумент brute_force для корректной работы немного изменен
    bf_hs = self.normalise_hash(@banknotes_hash) 
    while !after_brute_force[0]
      # print "Текущий минимальный номинал: "
      # puts min_nom
      after_brute_force = self.brute_force(bf_hs, 0, min_nom, 0, sum, ans_hash)
      # print "Результат полного перебора - "
      # puts after_brute_force[0]         # Раскомментировать, чтобы посмотреть
      # print after_brute_force[1]
      # Нахождение следующего минимального номинала, если не удался перебор
      if !after_brute_force[0]
        n_min_nom = Banknotes.max
        @banknotes_hash.keys.each do |key|
          if key > min_nom && key < n_min_nom then n_min_nom = key end
        end
        min_nom = n_min_nom
      # Если перебор удачен, количество купюр обновляется с учетом выдачи
      else
        @banknotes_hash.keys.each do |key|
          @banknotes_hash[key] -= after_brute_force[1][key]
        end
      end
    end
    # Так как в кассетах из-за того, что не использовалась функция load,
    # то исправим это вручную
    fix_hash = @banknotes_hash.dup
    self.set_cassette(@cassettes_count)
    self.load(fix_hash)
    print "Выданные деньги: "
    after_brute_force[1]         # Возвращаем хэш возвращаемых денег
  end

end

# Примеры запуска автомата:
# Число купюр в кассетах - 5
# Номиналы: 1, 2, 3, 5, 10
# Автомат будет выводиться в форме: 
# 1 - сумма денег, 2 - хэш всех купюр, 3 - занятость кассет
# -----------------------------------------------------------------------------
# Создаем новый автомат с шестью кассетами и максимальной суммой обмена 300
puts "Действие №1"
a = CashMachine.new(6, 300)
print a.status
print "\n"

# Загружаем в него тринадцать "десяток", две "тройки" и три "единицы"
# Получаем сообщение об успешном изменении количества купюр в автомате
puts "Действие №2"
print a.load({5 => 13, 3 => 2, 1 => 3})
print "\n"

puts "Действие №3"
print a.change({10 => 2, 1 => 1})
print "\n"

# Загрузить их удалось, получаем сообщение об успешной загрузке, 
# в результате получаем сообщение о том, что данную сумму удалось 
# разменять, причём удалось это сделать с помощью двух троек. 
# С помощью единиц не получилось, 
# поэтому был увеличен номинал на следующий за этим

# А теперь заглянем в автомат, как видно, общая сумма денег неизменна,
# но теперь количество первых и пятых купюр увеличено
puts "Действие №4"
print a.status
print "\n"

# Опустошим автомат, оставив 3 кассеты
puts "Действие №5"
a.set_cassette(3)
print a.status
print "\n"

# Попробуем загрузить в него те же купюры (занимают 5 кассет)
puts "Действие №6"
puts a.load({10 => 13, 3 => 2, 1 => 3})
print a.status
print "\n"

# Уберем лишнее
a.empty

# А теперь чуть меньше.., но 2 раза
puts "Действие №7"
puts a.load({10 => 2, 2 => 5})
print a.status
print "\n"

puts a.load({10 => 2, 2 => 5})
print a.status
print "\n"

# Попробуем ещё "немного" разменять, хочу разменять свои 750 монеток
# в 75 купюрах. Попробуем..
puts "Действие №8"
a.change({10 => 75})
print a.status
print "\n"

# Но, там места нет, поэтому загруженные купюры возвращены.

# Ага, раз места нет, то увеличим количество кассет!
puts "Действие №9"
a.set_cassette(80)
# 250 троек в автомат
a.load({3 => 250})  
# Вот теперь все тройки в автомате достанутся мне!
a.change({10 => 75})
# Но минимальная сумма не позволила это сделать
print a.status
print "\n"

# Теперь рассмотрим обычные случаи размена денег
# В автомате шесть единиц, отправили на размен пятак
puts "Действие №10"
a.set_cassette(6)
a.load({1 => 6})
print a.change({5 => 1})

print "\n"
print a.status
print "\n"

# Изначально только пятак. Отправили на размен шесть "единиц"
puts "Действие №11"
a.set_cassette(6)
a.load({5 => 1})
print a.change({1 => 6})

print "\n"
print a.status
print "\n"

# Изначально ничего нет, дают десятку
puts "Действие №12"
a.set_cassette(6)
print a.change({10 => 1})

print "\n"
print a.status
print "\n"

puts "Спасибо за пользование. Приятного времяпровождения."