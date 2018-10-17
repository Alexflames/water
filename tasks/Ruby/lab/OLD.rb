# load "lab-6.rb" # УДАЛИТЬ ПОТОМ!! ТОЛЬКО ДЛЯ ТЕСТИРОВАНИЯ!

# Рассказать о логике.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# Расстановка кораблей соответствует возможности выполнения стратегии движения кораблей 
# Для четырёхпалубного корабля выделена левая и нижняя граница поля, для остальных 
# правая верхняя часть 8x8. Причём в стратегии важными являются именно трёх- и
# четырёхпалубные корабли


# Расстановка V (для того, чтобы можно было двигаться)
# Выстрел     ? (улучшить ведение боя у границ)
# Движение    X
class Grigoriev_Player < Player

# Цифрам в поле соответствуют место для движения кораблей с соответствующим размеру
# количеством занимаемым ими клеток
# двухклеточные и одноклеточные корабли не важны для моей стратегии\
# Цифры в скобках - начальные позиции
# Точки - пустые клетки
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
  # Движение кораблей длины 3
#   Y 0 1 2 3 4 5 6 7 8 9  h   t
# X _____________________  o = r
# 0 | . . 4 . . . . . . .  r   u
# 1 | . . 4 . . . 3 3 3 .      e
# 2 | . . 4 . . . 3 3 3 .
# 3 | . . 4 . . . 3 3 3 .
# 4 | . . 4 . . . . . . .
# 5 | . . 4 4 4 4 4 4 4 .
# 6 | . . . . . . . . 4 .
# 7 | . . . . . . . . 4 .
# 8 | . . . . . . . . 4 .
# 9 | . . . . . . . . . .  ! h o r = f a l s e

#   Y 0 1 2 3 4 5 6 7 8 9  h   t
# X _____________________  o = r
# 0 | 4 . 3 3 3 . 3 3 3 .  r   u
# 1 | 4 . 3 3 3 . 3 3 3 .      e
# 2 | 4 .(3 3 3).(3 3 3).
# 3 | 4 . . . . . . . . .
# 4 | 4 .(2).(1).(2).(2 2)
# 5 | 4 .(2). . .(2). . .
# 6 | 4 . . .(1). . . .(4)
# 7 | 4 .(1). . .(1). .(4)
# 8 | 4 . . . . . . . .(4)
# 9 | 4 4 4 4 4 4 4 4 4(4) ! h o r = f a l s e

# @p = Grigoriev_Player.new("MemeMachine")
# @b = BattleField.new
# @plan = @p.place_strategy(@b.fleet)
# @b.place_fleet(@plan)
# @b.print_field

  def place_strategy(ship_list)
    ship_list = ship_list.sort { |x, y| y[1] <=> x[1] }
    [ [ship_list[0][0], 6, 9, true],    # 4
      [ship_list[1][0], 2, 2, false],   # 3
      [ship_list[2][0], 2, 7, false],   # 3
      [ship_list[3][0], 4, 2, true],    # 2
      [ship_list[4][0], 4, 6, true],    # 2
      [ship_list[5][0], 4, 8, false],   # 2
      [ship_list[6][0], 7, 2, false],
      [ship_list[7][0], 4, 4, false],
      [ship_list[8][0], 6, 4, false],
      [ship_list[9][0], 7, 6, false] ]
  end

  def reset
    @allshots = []
    @lastshots = []
    @go_backward = false
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

      # Ищем корабль, имеющий длину 3 или 4 с наименьшим здоровьем
      remains.sort! { |x, y| y[2] <=> x[2] }
      ship_to_move = remains[0]
      remains.each do |x| 
        if x[3] < ship_to_move[3] && x[2] > 2 then ship_to_move = x end
      end

      # Если текущее здоровье отличается от макс. на не более чем 30, то пропускаем шаг
      # (делаем невозможное движение, так как противник скорее всего потерял наш корабль)
      if ship_to_move[3] >= ship_to_move[2] * 100 - 30
      then [ship_to_move[0], 707, 707]

      # Движемся по заданной фигуре в зависимости от
      # местоположения. Все перемещения заданы заранее.
      elsif ship_to_move[2] == 4  

      # При достижении позиций со скобками меняем направление движения,
      # go_backward на противоположное (true или false)

      #   Y 0 1 2 3 4 5 6 7 8 9  h   t
      # X _____________________  o = r
      # 0 |<4>. . . . . . . . .  r   u
      # 1 | 4 . . . . . . . . .      e
      # 2 | 4 . . . . . . . . .
      # 3 | 4 . . . . . . . . .
      # 4 | 4 . . . . . . . . .
      # 5 | 4 . . . . . . . . .
      # 6 | 4 . . . . . . . .<4>
      # 7 | 4 . . . . . . . . 4
      # 8 | 4 . . . . . . . . 4
      # 9 | 4 4 4 4 4 4 4 4 4 4  ! h o r = f a l s e

        if ship_to_move[1][0] == 6 && ship_to_move[1][1] == 9
          go_backward = false # Направляемся на конечную позицию
          [ship_to_move[0], 1, 4]
        elsif ship_to_move[1][0] == 9 && ship_to_move[1][1] == 0
          if go_backward  # Если возвращаемся на исходную позицию
            [ship_to_move[0], 3, 4]
          else
            [ship_to_move[0], 1, 1]
          end
        elsif ship_to_move[1][0] == 0 && ship_to_move[1][1] == 0
          go_backward = true # Возвращаемся на исходную позицию
          [ship_to_move[0], 2, 4]
        else
          if go_backward # Если возвращаемся на исходную позицию
            [ship_to_move[0], 2, 4]
          else
            [ship_to_move[0], 2, 1]
          end
        end
      elsif ship_to_move[2] == 3
        # Движение кораблей длины 3
      #   Y 0 1 2 3 4 5 6 7 8 9  h   t
      # X _____________________  o = r
      # 0 | . . 3 3 3 . 3 3 3 .  r   u
      # 1 | . . 3 3 3 . 3 3 3 .      e
      # 2 | . .(3 3 3).(3 3 3).
      # 3 | . . . . . . . . . .
      # 4 | . . . . . . . . . .
      # 5 | . . . . . . . . . .
      # 6 | . . . . . . . . . .
      # 7 | . . . . . . . . . .
      # 8 | . . . . . . . . . .
      # 9 | . . . . . . . . . .  ! h o r = f a l s e
        if (ship_to_move[1][0] == 2 && ship_to_move[1][1] == 2) ||
           (ship_to_move[1][2] == 2 && ship_to_move[1][3] == 2) ||
           (ship_to_move[1][0] == 2 && ship_to_move[1][1] == 6) ||
           (ship_to_move[1][2] == 2 && ship_to_move[1][3] == 6)
          [ship_to_move[0], 3, 3]
        else (ship_to_move[1][0] == 0 && ship_to_move[1][1] == 4) ||
             (ship_to_move[1][0] == 0 && ship_to_move[1][1] == 2) ||
             (ship_to_move[1][0] == 0 && ship_to_move[1][1] == 8) ||
             (ship_to_move[1][0] == 0 && ship_to_move[1][1] == 6)
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
end