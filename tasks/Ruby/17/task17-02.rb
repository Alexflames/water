# подгружаются основные определения
require_relative './task17-math'

# Деление
class Divide < MathExpression
  def initialize(e)  # e - выражение для которого ищется 
    @e = e           # обратное ему выражение
  end 

  # вычисление в окружении env
  def eval env
    e = @e.eval env  # вычисляется выражение без деления
    e.evalExp        # вычисление экспоненты от выражения
  end

  # вычисление производной
  def derivative var
    e = @e.derivative var # формируем результат по правилу 
    e.multiply self       # (e^f)'=f'*e^f
  end

  # строковое представление экспоненты выражения
  def to_s
    "exp(#{@e.to_s})"
  end
end







# ПРИМЕРЫ
puts(Derivative.new(
        Multiply.new(
          Add.new(
            Add.new(
              Multiply.new(Number.new(2),      
                           Variable.new("x")), 
              Multiply.new(Number.new(3), 
                           Variable.new("y"))), 
            Negate.new(Variable.new("z"))), 
          Add.new(Number.new(5), 
                  Variable.new("x"))), 
        "x"))  

puts(Let.new("a", Multiply.new(Number.new(2), 
                               Variable.new("x")),        # a = 2x
       Let.new("b", Multiply.new(Number.new(3), 
                                 Variable.new("y")),      # b = 3y
         Let.new("e", Add.new(Variable.new("a"),         
                              Variable.new("b")),         # e = a + b
            Multiply.new(Multiply.new(Variable.new("e"),
                                      Variable.new("e")),
                         Variable.new("e"))))))            

puts(Let.new("a", Multiply.new(Number.new(2), 
                               Variable.new("x")),   # a = 2x
       Let.new("b", Multiply.new(Number.new(3), 
                                 Variable.new("y")), # b = 3y
         Let.new("cube",                             # cube(e) = e * e * e
                 MyFunc.new(nil, "e",
                   Multiply.new(Multiply.new(Variable.new("e"),
                                             Variable.new("e")),
                                Variable.new("e"))),
           # вычисление cube(a + b) + cube(b)
           Add.new(Call.new(Variable.new("cube"),        # вызов cube(a + b)
                            Add.new(Variable.new("a"), 
                                    Variable.new("b"))),
                   Call.new(Variable.new("cube"),        # вызов cube(b)
                            Variable.new("b")))))))

# вычисление выражений
puts(Derivative.new(
        Multiply.new(
          Add.new(
            Add.new(
              Multiply.new(Number.new(2),      
                           Variable.new("x")), 
              Multiply.new(Number.new(3), 
                           Variable.new("y"))), 
            Negate.new(Variable.new("z"))), 
          Add.new(Number.new(5), 
                  Variable.new("x"))), 
        "x").eval_exp)  

puts(Let.new("a", Multiply.new(Number.new(2), 
                               Variable.new("x")),        # a = 2x
       Let.new("b", Multiply.new(Number.new(3), 
                                 Variable.new("y")),      # b = 3y
         Let.new("e", Add.new(Variable.new("a"),         
                              Variable.new("b")),         # e = a + b
            Multiply.new(Multiply.new(Variable.new("e"),
                                      Variable.new("e")),
                         Variable.new("e"))))).eval_exp)            

puts(Let.new("a", Multiply.new(Number.new(2), 
                               Variable.new("x")),   # a = 2x
       Let.new("b", Multiply.new(Number.new(3), 
                                 Variable.new("y")), # b = 3y
         Let.new("cube",                             # cube(e) = e * e * e
                 MyFunc.new(nil, "e",
                   Multiply.new(Multiply.new(Variable.new("e"),
                                             Variable.new("e")),
                                Variable.new("e"))),
           # вычисление cube(a + b) + cube(b)
           Add.new(Call.new(Variable.new("cube"),        # вызов cube(a + b)
                            Add.new(Variable.new("a"), 
                                    Variable.new("b"))),
                   Call.new(Variable.new("cube"),        # вызов cube(b)
                            Variable.new("b")))))).eval_exp)
