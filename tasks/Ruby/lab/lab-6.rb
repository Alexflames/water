## Шаблон для выполнения заданий Лабораторной работы №6 
## ВСЕ КОММЕНТАРИИ ПРИВЕДЕННЫЕ В ДАННОМ ФАЙЛЕ ДОЛЖНЫ ОСТАТЬСЯ НА СВОИХ МЕСТАХ
## НЕЛЬЗЯ ПЕРЕСТАВЛЯТЬ МЕСТАМИ КАКИЕ-ЛИБО БЛОКИ ДАННОГО ФАЙЛА
## решения заданий должны быть вписаны в отведенные для этого позиции 

################################################################################
# Задание 1 
# add b
class Array
  def add b
    (self.zip b).map { |x| x.reduce(:+) }
  end
end
################################################################################

# конец описания задания 1
################################################################################

################################################################################
# Задания 2-6 
# Класс Field
################################################################################
class Field
  FieldSize = 10
  def initialize
    @field = Array.new(FieldSize) { |i| Array.new(FieldSize) }
  end
  # Задание 3 size (метод класса)
  def self.size
    FieldSize
  end
  # Задание 4 set!(n, x, y, hor, ship)
  def set! (n, x, y, hor, ship=nil)
    if hor == true
      n.times { |i| @field[x + i][y] = ship }
    else
      n.times { |i| @field[x][y + i] = ship }
    end
  end
  # Задание 5 print_field
  def print_field
    print "+"
    FieldSize.times { print "-" }
    print "+\n"

    FieldSize.times do |i| 
      print "|"
      FieldSize.times do |j| 
        if @field[i][j] == nil then print " " else print @field[i][j] end 
      end
      print "|\n"
    end

    print "+"
    FieldSize.times { print "-" }
    print "+\n"
  end
  # Задание 6 free_space?(n, x, y, hor, ship)
  def free_space?(n, x, y, hor, ship)
    if x < 0 || y < 0 || x >= FieldSize || y >= FieldSize
      false 
    elsif hor == true
      if n + x > FieldSize
        false
      else
        if x == 0 then left = 0 else left = x - 1 end
        if x + n == FieldSize then right = x + n - 1 else right = x + n end
        if y == 0 then down = 0 else down = y - 1 end
        if y + 1 == FieldSize then up = y else up = y + 1 end
        ans = true
        (up - down + 1).times do |i|
          (right - left + 1).times do |j|
            if @field[left + j][down + i] != nil &&
                 @field[left + j][down + i] != ship
              ans = false
              break
            end
          end
          if ans == false then break end
        end
        ans
      end
    else
      if n + y > FieldSize
        false
      else
        if x == 0 then left = 0 else left = x - 1 end
        if x + 1 == FieldSize then right = x else right = x + 1 end
        if y == 0 then down = 0 else down = y - 1 end
        if y + n == FieldSize then up = y + n - 1 else up = y + n end
        ans = true
        (up - down + 1).times do |i|
          (right - left + 1).times do |j|
            if @field[left + j][down + i] != nil &&
                 @field[left + j][down + i] != ship
              ans = false
              break
            end
          end
          if ans == false then break end
        end
        ans
      end
    end
  end

end
# конец описания класса Field
################################################################################


################################################################################
# Задания 7-16 
# Класс Ship
################################################################################
class Ship                        # Выводит field, а не X
  def initialize(field, len)
    @len = len
    @myfield = field
    @maxhealth = len * 100
    @minhealth = len * 30
    @health = len * 100
  end
  attr_reader :len, :coord
  # Задание 8 to_s
  def to_s
    "X"
  end
  # Задание 9 clear
  def clear
    @myfield.set!(@len, @coord[0], @coord[1], @hor)
  end
  # Задание 10 set!(x, y, hor)
  def set!(x, y, hor)
    if !@myfield.free_space?(@len, x, y, hor, self)
      false
    else
      if @coord then self.clear end
      @myfield.set!(@len, x, y, hor, self)
      if hor == true
        @coord = [x, y, x + @len - 1, y]
      else
        @coord = [x, y, x, y + @len - 1]
      end
      @hor = hor
      true
    end
  end
  # Задание 11 kill
  def kill
    self.clear
    @coord = nil
  end
  # Задание 12 explode
  def explode
    @health -= 70
    if @health <= @minhealth
      self.kill
      @len
    end
  end
  # Задание 13 cure
  def cure
    if @health > @maxhealth - 30 
    then @health = @maxhealth else @health += 30 end
  end
  # Задание 14 health
  def health
    ((@health.to_f / @maxhealth) * 100).round(2)
  end
  # Задание 15 move(forward)
  def move(forward)
    if forward 
      if  @hor then self.set!(@coord[0] + 1, @coord[1], @hor)
               else self.set!(@coord[0], @coord[1] + 1, @hor) end
    elsif @hor then self.set!(@coord[0] - 1, @coord[1], @hor)
               else self.set!(@coord[0], @coord[1] - 1, @hor) end
  end
  # Задание 16 rotate(n, k)
  def rotate(n, k)
    if !(n.between?(1, @len) && k.between?(1, 3))
      false
    # В задании не запрещено упрощение, что я и сделал ниже в каждом случае
    elsif @hor # Это значит, что y - yc = 0 (y не изменяется)
      xc = @coord[0] + n - 1
      if k == 1     # Начальная точка осталась начальной
        self.set!(xc, @coord[1] + @coord[0] - xc, !@hor)
      elsif k == 2  # Конечная точка стала начальной
        self.set!(xc + xc - @coord[2], @coord[3], @hor)
      else          # Конечная точка стала начальной
        self.set!(xc, @coord[3] - @coord[2] + xc, !@hor)
      end
    else # @hor равен false, и это значит, что x - xc = 0
      yc = @coord[1] + n - 1
      if k == 1    # Конечная точка стала начальной
        self.set!(@coord[2] - @coord[3] + yc, yc, !@hor)
      elsif k == 2 # Конечная точка стала начальной
        self.set!(@coord[2], yc + yc - @coord[3], @hor)
      else         # Начальная точка осталась начальной
        self.set!(@coord[0] + @coord[1] - yc, yc, !@hor)
      end
    end
  end

end
# конец описания класса Ship
################################################################################

################################################################################
# Задания 17-25
# Класс BattleField
################################################################################
class BattleField < Field
  Ships = [4, 3, 3, 2, 2, 2, 1, 1, 1, 1]
  def newships 
    @field = Array.new(Field.size) { |i| Array.new(Field.size) }
    @allships = []
    Ships.each { |x| @allships.push(Ship.new(self, x)) }
  end

  def initialize
    newships
  end
  # Задание 18 fleet
  def fleet
    @allships.each_with_index.map { |x, i| [i, x.len] }
  end
  # Задание 19 place_fleet pos_list
  def place_fleet(pos_list)
    ok = pos_list.all? { |pos| @allships[pos[0]].set!(pos[1], pos[2], pos[3]) }
    if !ok
     @allships.each { |x| if x.coord then x.kill end } 
     false
    else
      ok = @allships.all? { |x| x.coord }
      if !ok
        @allships.each { |x| if x.coord then x.kill end} 
        false
      else
        true
      end
    end
  end
  # Задание 20 remains
  def remains
    @allships.each_with_index.map { |x, i| [i, x.coord, x.len, x.health] }
  end
  # Задание 21 refresh
  def refresh
    @allships = @field.reduce(:|).find_all { |x| x }
  end
  # Задание 22 shoot c
  def shoot c
    if !@field[c[0]][c[1]]
      "miss"
    else 
      state = @field[c[0]][c[1]].explode
      if !state
        "wounded"
      else 
        refresh
        "killed #{state}"
      end
    end
  end
  # Задание 23 cure
  def cure
    @allships.each { |x| x.cure }
  end
  # Задание 24 game_over?
  def game_over?
    @allships.empty?
  end
  # Задание 25 move l_move
  def move l_move
    if l_move[1].between?(1, 3)
      @allships[l_move[0]].rotate(l_move[2], l_move[1])
    elsif l_move[2] == 1
      @allships[l_move[0]].move(true)
    else
      @allships[l_move[0]].move(false)
    end
  end
end
# конец описания класса BattleField
################################################################################


################################################################################
# Задания 26-31
# Класс Player
################################################################################
class Player
  attr_reader :name
  attr_accessor :manual

  def reset
    @allshots = []
    @lastshots = []
  end

  def initialize(name, manual = false)
    @name = name
    @manual = manual
    @lastsample = [1, 0]
    self.reset
  end

  # Задание 27 random_point
  def random_point
    [rand(Field.size), rand(Field.size)]
  end
  # Задание 28 place_strategy ship_list
  def place_strategy(ship_list)
    tempf = Field.new
    ship_list = ship_list.sort { |x, y| y[1] <=> x[1] }
    ans = []
    ship_list.each do |x|
      ok = false
      rnd_point = [0,0]
      rnd_hor = false
      this_ship = Ship.new(tempf, x[1])
      while !ok
        if rand(2) == 1 then rnd_hor = true else rnd_hor = false end
        rnd_point = self.random_point
        ok = this_ship.set!(rnd_point[0], rnd_point[1], rnd_hor)
      end
      ans.push([x[0], rnd_point[0], rnd_point[1], rnd_hor])
    end
    ans
  end
  # Задание 29 hit message
  def hit(message)
    @lastshots.push([@shot, message])
  end
  #            miss
  def miss
    @lastshots.push([@shot, "miss"])
    @allshots.push(@lastshots)
    @lastshots = []
  end
  # Задание 30 shot_strategy
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
      # Здесь необходимо разместить решение задания 30
      n_shots = @lastshots.length
            # Если первый выстрел / предыдущий привёл к уничтожению
      if n_shots == 0 || @lastshots[n_shots - 1][1] != "wounded"
        @shot = random_point
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
      # конец решения задания 30
    end
  end

  # Задание 31 ship_move_strategy remains
  def ship_move_strategy remains
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
      # Здесь необходимо разместить решение задания 31
      ship_to_move = remains[0]
      remains.each { |x| if x[3] < ship_to_move[3] then ship_to_move = x end }
      [ship_to_move[0], rand(4), rand(1..ship_to_move[2])]
      # конец решения задания 31
    end
  end 

end
# конец описания класса Player
################################################################################

################################################################################
# Задания 32-33 
# Класс Game
################################################################################
class Game
  def initialize(player_1, player_2)
    @game_over = false
    @players = [[player_1, BattleField.new, 0], [player_2, BattleField.new, 0]]
    @players.each { |p| reset(p) }
    @players = @players.shuffle
  end

  # p = [player, bfield, count]
  def reset p
    "#{p[0].name} game setup"
    p[0].reset
    player_fleet = p[1].fleet
    plan_fleet = p[0].place_strategy(player_fleet)
    success = p[1].place_fleet(plan_fleet)
    if success then puts "Ships placed" else raise "Illegal ship placement" end
  end

  # Задание 33 start
  def start
    @lastshots = []
    # активный игрок - @players[0]
    while !@game_over

      @players[0][2] += 1
      puts "Step #{@players[0][2]} of player #{@players[0][0].name}"
      @players[0][1].cure
      ships_left = @players[0][1].remains
      movement = @players[0][0].ship_move_strategy(ships_left)
      # puts "#{movement}"
      @players[0][1].move(movement)
      shot_coord = @players[0][0].shot_strategy
      res = "miss"    # Просто инициализация
      if !(@lastshots.all? { |x| shot_coord != x })
        puts "Illegal shoot"
      else
        @lastshots.push(shot_coord)
        res = @players[1][1].shoot(shot_coord)
      end
      puts "#{shot_coord} #{res}"
      if res == "miss"
        @lastshots = []
        @players[0][0].miss
        temp = @players[0].dup
        @players[0] = @players[1].dup
        @players[1] = temp
      else
        @players[0][0].hit(res)
        @game_over = @players[1][1].game_over?
        if @game_over
          puts "Player #{@players[0][0].name} wins!"
        end
      end
    end
  end
end
# конец описания класса Game
################################################################################

################################################################################
# Переустановка датчика случайных чисел
################################################################################
srand
################################################################################

#№ Пример запуска
# p1 = Player.new("Alyosha")
# p2 = Player.new("Sergey_Vladimirovich")
                                        
# g = Game.new(p1,p2)
# g.start

