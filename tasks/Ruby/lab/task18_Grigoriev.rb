# Универсальной стратегии для всех случаев мне не удалось разработать, но
# получилось немного улучшить % побед

# Расстановка V
# Выстрел     V
# Движение    V

class Grigoriev_Player < Player

# Вид поля. Сверху вниз ось X, слева направо Y
########################################
  # Движение кораблей длины 3
#   Y 0 1 2 3 4 5 6 7 8 9  h   t
# X _____________________  o = r
# 0 | . . . . . . . . . .  r   u
# 1 | . . . . . . . . . .      e
# 2 | . . . . . . . . . .
# 3 | . . . . . . . . . .
# 4 | . . . . . . . . . .
# 5 | . . . . . . . . . .
# 6 | . . . . . . . . . .
# 7 | . . . . . . . . . .
# 8 | . . . . . . . . . .
# 9 | . . . . . . . . . .  ! h o r = f a l s e
#########################################

# Расстановка кораблей соответствует возможности выполнения стратегии движения кораблей 
# 1) Корабли длиной 2 и более легче убить, если они стоят возле границы
# 2) Корабли длиной 3 и 4 должны иметь достаточно пространства для манёвров.
# 3) При уничтожении кораблей длины 3 и 4 корабли 1 и 2 тоже начинают передвигаться.

# Цифрам в поле соответствуют место для движения кораблей с соответствующими цифрам длинами
# двухклеточные и одноклеточные корабли не сильно важны для стратегии перемещения
# Цифры в скобках - начальные позиции кораблей длины 3 и 4
# Точки - пустые клетки

#   Y 0 1 2 3 4 5 6 7 8 9  h   t
# X _____________________  o = r
# 0 | 1 . . . 1 . . . . .  r   u
# 1 | . . . . . .(3 3 3).      e
# 2 | 1 . 4 . 2 . 3 3 3 .
# 3 | . . 4 . 2 . 3 3 3 .
# 4 | 1 . 4 . . . . . . .
# 5 | . . 4 4 4 4 4 4(4).
# 6 | 2 . . . . . . .(4).
# 7 | 2 .(3 3 3). 2 .(4).
# 8 | . . 3 3 3 . 2 .(4).
# 9 | . . 3 3 3 . . . . .  ! h o r = f a l s e

  def place_strategy(ship_list)
    ship_list = ship_list.sort { |x, y| y[1] <=> x[1] }
    [ [ship_list[0][0], 5, 8, true],    # 4
      [ship_list[1][0], 7, 2, false],   # 3
      [ship_list[2][0], 1, 6, false],   # 3
      [ship_list[3][0], 6, 0, true],    # 2
      [ship_list[4][0], 2, 4, true],    # 2
      [ship_list[5][0], 7, 6, true],    # 2
      [ship_list[6][0], 0, 0, false],
      [ship_list[7][0], 0, 4, false],
      [ship_list[8][0], 2, 0, false],
      [ship_list[9][0], 4, 0, false] ]
  end

  def reset
    @allshots = []
    @lastshots = []
    @go_backward = false # Переменная для перемещения корабля длины 4
    @brute_force = [0, 0] # Стрельба. Сначала полный перебор по всему полю
  end

  def ship_move_strategy remains
    # Стандартное (осталось неизменным)
    if @manual
      print "Ship health"
      tmp_field = Field.new
      names = ("0".."9").to_a + ("A".."Z").to_a + ("a".."z").to_a
      ship_hash = {}
      remains.each do |ship|
        name = names[ship[0]]
        x = ship[1][0]; y = ship[1][1]
        hor = (ship[1][1] == ship[1][3])
        ship_hash[name] = [ship[0], ship[2]]
        tmp_field.set!(ship[2], x, y, hor, name)
        print(name, " - ", ship[3], "%\n") 
      end
      print "Your ships"
      tmp_field.print_field
      print "Make a move. To switch off the manual mode enter an incorrect ship name"
      while true
        print "Choose ship: "; 
        name = gets.strip; print name
        if !ship_hash[name] then break end
        move = 0
        begin
          print "Enter 0 to move, 1-3 to rotate: " 
          move = gets.to_i; print move
        end until move.between?(0,3)
        if move == 0
          print "1 - forward/any - backward): "; dir = gets.to_i
          print dir
        else
          dir = 0
          begin
            print "Choose a center point: (1..#{ship_hash[name][1]}): "
            dir = gets.to_i; print dir
          end until dir.between?(1,ship_hash[name][1])
        end
        break
      end
      if !ship_hash[name]
        @manual = false
        ship_move_strategy remains
      else
        [ship_hash[name][0], move, dir]
      end
    else
      ##########################################################################
      # Стратегия перемещения кораблей.
      # Корабли длины 3 в игровом поле движутся квадратами,
      # Корабль длины 4 следует заданному маршруту. 
      # Каждое движение максимально отдаляет корабль от места попадания за 2 хода
      # При этом никакие корабли не мешают перемещению друг друга 

      # Ищем корабль, имеющий длину 3 или 4 с наименьшим здоровьем
      remains.sort! { |x, y| y[2] <=> x[2] }
      ship_to_move = remains[0] # ищется наибольший
      anybig = ship_to_move[2] - 2 # Если корабль 4 утонул, то двойки тоже могут передвигаться
      remains.each do |x| 
        if x[3] < ship_to_move[3] && x[2] > anybig then ship_to_move = x end
      end

      # Движемся по заданной фигуре в зависимости от
      # местоположения. Все перемещения заданы заранее.
      if ship_to_move[2] == 4  

      # При достижении позиций со скобками меняем направление движения,
      # go_backward на противоположное (true или false)

      #   Y 0 1 2 3 4 5 6 7 8 9  h   t
      # X _____________________  o = r
      # 0 | . . . . . . . . . .  r   u
      # 1 | . . . . . . . . . .      e
      # 2 | . .<4>. . . . . . .
      # 3 | . . 4 . . . . . . .
      # 4 | . . 4 . . . . . . .
      # 5 | . . 4 4 4 4 4 4<4>.
      # 6 | . . . . . . . . 4 .
      # 7 | . . . . . . . . 4 .
      # 8 | . . . . . . . . 4 .
      # 9 | . . . . . . . . . .  ! h o r = f a l s e

        if ship_to_move[1][0] == 5 && ship_to_move[1][1] == 8
          @go_backward = false # Направляемся на конечную позицию
          [ship_to_move[0], 3, 1]
        elsif ship_to_move[1][0] == 5 && ship_to_move[1][1] == 2
          if @go_backward # Если возвращаемся на исходную позицию
            [ship_to_move[0], 2, 4]
          else
            [ship_to_move[0], 1, 1]
          end
        elsif ship_to_move[1][0] == 2 && ship_to_move[1][1] == 2
          @go_backward = true # Возвращаемся на исходную позицию
          [ship_to_move[0], 3, 4]
        elsif ship_to_move[1][0] == 5 && ship_to_move[1][1] == 5
          if @go_backward # Если возвращаемся на исходную позицию
            [ship_to_move[0], 1, 4]
          else
            [ship_to_move[0], 2, 1]
          end
        else # Значит идём параллельно прямой x = 5
          if @go_backward # Если возвращаемся на исходную позицию
            [ship_to_move[0], 2, 4]
          else
            [ship_to_move[0], 2, 1]
          end
        end
      elsif ship_to_move[2] == 3

        # Движение кораблей длины 3
        # Y 0 1 2 3 4 5 6 7 8 9  h   t
      # X _____________________  o = r
      # 0 | . . . . . . . . . .  r   u
      # 1 | . . . . . . 3 3 3 .      e
      # 2 | . . . . . . 3 3 3 .
      # 3 | . . . . . . 3 3 3 .
      # 4 | . . . . . . . . . .
      # 5 | . . . . . . . . . .
      # 6 | . . . . . . . . . .
      # 7 | . . 3 3 3 . . . . .
      # 8 | . . 3 3 3 . . . . .
      # 9 | . . 3 3 3 . . . . .  ! h o r = f a l s e

        if (ship_to_move[1][0] == 9 && ship_to_move[1][1] == 2) ||
           (ship_to_move[1][2] == 9 && ship_to_move[1][3] == 2) ||
           (ship_to_move[1][0] == 3 && ship_to_move[1][1] == 6) ||
           (ship_to_move[1][2] == 3 && ship_to_move[1][3] == 6)
          [ship_to_move[0], 3, 3]
        else (ship_to_move[1][0] == 7 && ship_to_move[1][1] == 4) ||
             (ship_to_move[1][2] == 7 && ship_to_move[1][2] == 4) ||
             (ship_to_move[1][0] == 1 && ship_to_move[1][1] == 8) ||
             (ship_to_move[1][2] == 1 && ship_to_move[1][2] == 8)
          [ship_to_move[0], 3, 1]
        end
      # Иначе движемся случайно, мы можем спокойно это делать, так как корабли
      # с хитрым движением (длины 3 и 4 уничтожены)
      else [ship_to_move[0], rand(4), rand(1..ship_to_move[2])]
      end
      # конец моей стратегии перемещения кораблей
      ##########################################################################
    end
  end

  # При попадании в полном переборе не берем соседнюю клетку
  def hit(message)
    @lastshots.push([@shot, message])
    if message != "wounded" then @brute_force[0] += 1 end
  end

  # На всякий случай переопредилим miss, чтобы вариант реализации с использованием
  # hit внутри miss не мешал данному решению. hit является частью стратегии стрельбы
  def miss
    @lastshots.push([@shot, "miss"])
    @allshots.push(@lastshots)
    @lastshots = []
  end

  def shot_strategy
    if @manual
      @lastshots.each { |x| print(x, "\n") }
      print "Make a shot. To switch off the manual mode enter -1 for any coordinate"
      while true
        print "x = "; x = gets.to_i; print x
        print " y = "; y = gets.to_i; print y
        shot = [x,y]
        if shot.all? { |a| a.between?(-1, Field.size - 1) }
          break
        else
          print "Incorrect input"
        end
      end
      if shot.any? { |a| a == -1 }
        @manual = false
        shot_strategy
      else
        @shot = shot
      end
    else
##########################################################
      # Стратегия стрельбы
      # Чтобы не было проблем с неудачей попаданий по кораблям длины 1 
      # хоть раз сделаем выстрел по каждой клетке поля, а затем уже выбираем случайные.
      # так можно получить преимущество за первые ~ 120 выстрелов, а потом уже надеяться, 
      # что повезет.

      n_shots = @lastshots.length
      n_all_shots = @allshots.length
      if @brute_force[0] > 9 # Выравниваем полный перебор клеток поля
        @brute_force[0] = 0
        @brute_force[1] += 1
      end
            # Если первый выстрел / предыдущий привёл к уничтожению
      if n_shots == 0 || @lastshots[n_shots - 1][1] != "wounded"
        if @brute_force[1] < 10
          @shot = @brute_force.dup
          @brute_force[0] += 1
        else
          @shot = random_point
        end
      # Если предыдущий выстрел в серии был попаданием, пытаемся добить корабль 
      # выстрелом в случайную ближайшую сторону
      # (Реализация совпадает с тем, что требовалось в лабораторной) 
      else  # Если второй выстрел в серии, делаем смещение относительно предыдущего
        if n_shots == 1 || @lastshots[n_shots - 2][1] != "wounded"
          use_rand = rand(4)
          @lastsample = if    use_rand == 0 then [0, 1]
                        elsif use_rand == 1 then [1, 0]
                        elsif use_rand == 2 then [0, -1]
                                            else [-1, 0] end
          @shot = @lastshots[n_shots - 1][0].add @lastsample
        else # Третий в серии -> повторяем смещение
          @shot = @shot.add @lastsample
        end
        if !( @shot[0].between?(0, Field.size - 1) &&
              @shot[1].between?(0, Field.size - 1) )
          @lastsample.each_index { |i| @lastsample[i] *= -1 }
          @shot = @lastshots[n_shots - 1][0].add @lastsample
        end
      end
      ok = @lastshots.all? { |x| @shot != x[0] }
      if !ok then return shot_strategy else @shot end   # Возвращается @shot
      # конец стратегии стрельбы
##########################################################
    end
  end
end