-- Тип данных "дробь" с инфиксным конструктором :/:
data Ratio a = a :/: a

-- Функция сокращения дроби
normaliseRatio (_ :/: 0) = error "Division by zero"
normaliseRatio (x :/: y) = (x `div` gd) :/: (y `div` gd)
  where gd   = gcd x y

-- Селекторы (геттеры) для числителя и знаменателя
numerator drb = x
  where (x :/: _) = normaliseRatio drb
denominator drb = y
  where (_ :/: y) = normaliseRatio drb

-- -- Предикат (инфиксный) для определения принадлежности x интервалу i
-- (<~) x i = (x >= iStart i) && (x <= iEnd i)

-- -- Функция применения функции operation к интервалу i
-- iMap operation i  =
--   iNormalize (operation (iStart i) :-: operation (iEnd i))

-- Назначение типа данных Ratio экземпляром класса Eq
instance (Eq a, Num a) => Eq (Ratio a) where
    (==) (x1 :/: x2) (y1 :/: y2) = x1 * y2 == y1 * x2

-- Назначение типа данных Ratio экземпляром класса Show
instance (Show a, Integral a) => Show (Ratio a) where
    show drb = show (numerator drb) ++ "/" ++ show (denominator drb)

-- Назначение типа данных Ratio экземпляром класса Num
instance (Num a, Integral a) => Num (Ratio a) where
    (+) drb1 drb2 = 
      (numerator drb1 * denominator drb2 + numerator drb2 * denominator drb1)
      :/: (denominator drb1 * denominator drb2)
    (*) drb1 drb2 = 
      (numerator drb1 * numerator drb2) 
      :/: (denominator drb1 * denominator drb2)
    negate drb = (numerator drb * (-1)) :/: denominator drb
    abs drb = (abs (numerator drb)) :/: (abs (numerator drb))
      -- if signum x == signum y then iNormalize (ax :-: ay)
      -- else 0 :-: (max ax ay)
      --     where ax = abs x
      --           ay = abs y
    signum drb = (signum (numerator drb) * signum (denominator drb)) :/: 1 
    fromInteger x = (fromInteger x) :/: 1

-- Назначение типа данных Ratio экземпляром класса Fractional
instance (Num a, Integral a) => Fractional (Ratio a) where
    (/) drb1 drb2 =
      if numerator drb2 == 0 || denominator drb1 == 0 
      then error "Division by zero"
      else a :/: b
        where a = numerator drb1 * denominator drb2
              b = numerator drb2 * denominator drb1

-- Назначение типа данных Ratio экземпляром класса Ord
instance (Ord a, Num a, Eq a) => Ord (Ratio a) where
    (<)  (a1 :/: b1) (a2 :/: b2) = na1 * nb2 < na2 * nb1
      where 
        (na1, nb1) = 
          if b1 < 0 then ((-1) * a1, (-1) * b1) else (a1, b1)
        (na2, nb2) = 
          if b2 < 0 then ((-1) * a2, (-1) * b2) else (a2, b2)
    (<=) (a1 :/: b1) (a2 :/: b2) = na1 * nb2 <= na2 * nb1
      where 
        (na1, nb1) = 
          if b1 < 0 then ((-1) * a1, (-1) * b1) else (a1, b1)
        (na2, nb2) = 
          if b2 < 0 then ((-1) * a2, (-1) * b2) else (a2, b2)
    (>)  (a1 :/: b1) (a2 :/: b2) = na1 * nb2 > na2 * nb1
      where 
        (na1, nb1) = 
          if b1 < 0 then ((-1) * a1, (-1) * b1) else (a1, b1)
        (na2, nb2) = 
          if b2 < 0 then ((-1) * a2, (-1) * b2) else (a2, b2)
    (>=) (a1 :/: b1) (a2 :/: b2) = na1 * nb2 >= na2 * nb1
      where 
        (na1, nb1) = 
          if b1 < 0 then ((-1) * a1, (-1) * b1) else (a1, b1)
        (na2, nb2) = 
          if b2 < 0 then ((-1) * a2, (-1) * b2) else (a2, b2)
    compare drb1 drb2
      | drb1 <= drb2  = LT
      | drb1 >= drb2  = GT
      | drb1 == drb2  = EQ
      | otherwise = error "The Ratios are non-comparable"

-------------------------------------------------------------------------------
--                                  ПРИМЕРЫ
-------------------------------------------------------------------------------
main = do
  -- предопределяем три дроби
  let drb1 = (-12) :/: (-4)
  let drb2 = 16 :/: 8
  let drb3 = (-10) :/: 5
  -- вывод значений первых двух дробей
  print $ drb1
  print $ numerator drb2
  print $ denominator drb2
  print $ normaliseRatio drb2
  print $ drb2
  -- арифметические операции  над дробями
  print $ drb1 + drb2
  print $ drb1 - drb3
  print $ drb3 * drb1
  print $ drb3 / drb1
  print $ negate drb1
  print $ abs drb1
  print $ abs drb3
  print $ signum drb3
  -- смешанные арифметические операции, подключающие frominteger
  print $ 2 * drb1
  print $ drb1 / 4
  print $ 4 / drb1
  print $ drb1 / (4 / 3)
  -- операции сравнения дробей
  print $ drb1 < drb2
  print $ drb1 <= drb3
  print $ drb1 > drb3
  print $ compare drb2 drb1
  print $ compare drb1 drb2
