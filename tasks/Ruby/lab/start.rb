load "lab-6.rb"
load "task18_Grigoriev.rb"
p1 = Player.new("Ivan")
p2 = Grigoriev_Player.new("Alyosha")
Game.new(p1, p2).start