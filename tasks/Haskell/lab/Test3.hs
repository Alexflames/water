import Lab3

-- Первоначальный набор тестов для лабораторной работы №3 
-- по мере реализации решений заданий снимайте комментарий 
-- с тестов соответствующей функции и пополняйте их своими тестами
-- кроме того, снимайте комментарий соответствующих строк вывода 
-- результатов тестов в функции main в конце файла и пополняйте эту 
-- функцию своими строками

-- Для проведения тестов запустите этот файл и выполните запуск main

------  Задание 1 nat 
test_nat_1 = take 5 (drop 24 nat) == [25, 26, 27, 28, 29]
test_nat_2 = take 5 (drop 124 nat) == [125, 126, 127, 128, 129]
test_nat_3 = take 5 (drop 114 nat) == [115, 116, 117, 118, 119]

------  Задание 2 fibonacci 
test_fibonacci_1 = take 8 fibonacci == [0,1,1,2,3,5,8,13]
test_fibonacci_2 = take 10 fibonacci == [0,1,1,2,3,5,8,13,21,34]

------ Задание 3 factorial 
test_factorial_1 = take 5 factorial == [1,1,2,6,24] 
test_factorial_2 = take 7 factorial == [1,1,2,6,24,120,720] 

------ Задание 4 powerSeq 
------ для вещественнозначного аргумента тесты не требуются
------ но при наличии тестов для вещественных чисел следует проверять ответ 
------ с некоторой точностью
------ точность epsilon для проверки вполне подходит
test_powerSeq_1 = take 5 (powerSeq 1) == [1,1,1,1,1] 
test_powerSeq_2 = abs (hd - 1.4641) <= epsilon
      where hd = head (drop 4 (powerSeq 1.1))   
test_powerSeq_3 = take 5 (powerSeq $ -1) == [1,-1,1,-1,1] 

------  Задание 5 findCloseEnough 
------ тесты не требуются 

------ Задание 6 streamSum 
------ тесты не требуются 

------ Задание 7 expSummands 
------ тесты не требуются

------ Задание 8 expStream 
------ тесты не требуются

------  Задание 9 expAppr 
test_expAppr_1 = abs (expAppr epsilon'' 1 - exp 1) < epsilon
test_expAppr_2 = abs (expAppr epsilon'' 5 - exp 5) < epsilon
test_expAppr_3 = abs (expAppr epsilon'' 2.5 - exp 2.5) < epsilon

------ Задание 10 derivativeAppr 
test_derivativeAppr_1 = abs (derivativeAppr sin epsilon'' x - cos x) < epsilon
  where x = pi
test_derivativeAppr_2 = abs (derivativeAppr log epsilon'' x - 1/x) < epsilon
  where x = 2
------ Задание 11 derivativeStream 
------ тесты не требуются

------ Задание 12 derivative 
test_derivative_1 = abs (derivative sin x - cos x) < epsilon
  where x = pi
test_derivative_2 = abs (derivative log x - 1/x) < epsilon
  where x = 2
------ Задание 13 invF и funAkStream
------ для funAkStream тесты не требуются
test_invF_1 = abs (invF (\x -> x * x) 4.3 16 - 4) < epsilon
test_invF_2 = abs (invF (\x -> x * x * x) 4.7 125 - 5) < epsilon
test_invF_3 = abs (invF sin 0 pi - 0) < epsilon

------ Задание 14 average 
test_average_1 = (average 4 8) == 6
test_average_2 = (average (-2) 2) == 0

------ Задание 15 averageDump 
test_averageDump_1 = (averageDump (\x -> x + x) 8) == 12
test_averageDump_2 = (averageDump (\x -> 3 * x) 8) == 16

------ Задание 16 newtonTransform 
test_newtonTransform_1 = abs (newtonTransform (\x -> x * x / 2) 4 - 2) < epsilon
test_newtonTransform_2 = abs ( newtonTransform 
                             ( \x -> x * x * 500) 4 - 2 ) < epsilon

------ Задание 17 eitken 
------ тесты не требуются

------ Задание 18 fixedPoint
------ тесты не требуются

------ Задание 19 fixedPointOfTransform 
------ тесты не требуются

------ Задание 20 sqrt1 
test_sqrt1_1 = abs (sqrt1 25 - 5) < epsilon
test_sqrt1_2 = abs (sqrt1 1 - 1) < epsilon

------ Задание 21 cubert1 
test_cubert1_1 = abs (cubert1 125 - 5) < epsilon
test_cubert1_2 = abs (cubert1 1 - 1) < epsilon

------ Задание 22 sqrt2 
test_sqrt2_1 = abs (sqrt2 25 - 5) < epsilon
test_sqrt2_2 = abs (sqrt2 1 - 1) < epsilon

------ Задание 23 cubert2 
test_cubert2_1 = abs (cubert2 125 - 5) < epsilon
test_cubert2_2 = abs (cubert2 1 - 1) < epsilon

------ Задание 24 extremum 
test_extremum_1 = abs (x - 0) < epsilon && str == "minimum"
  where (x, str) = extremum (\x -> x * x)

test_extremum_2 = abs (x - 3) < epsilon && str == "maximum"
  where (x, str) = extremum (\x -> (- (x - 3)) * (x - 3))

------ Задание 25 myPi 
test_myPi_1 = abs (myPi - pi) < epsilon 
test_myPi_2 = abs (myPi / 10 - pi / 10) < epsilon 

main = do 
  putStrLn ("1 test_nat_1 " ++ (show test_nat_1))
  putStrLn ("1 test_nat_2 " ++ (show test_nat_2))
  putStrLn ("1 test_nat_3 " ++ (show test_nat_3))
  putStrLn ("2 test_fibonacci_1 " ++ (show test_fibonacci_1))
  putStrLn ("2 test_fibonacci_2 " ++ (show test_fibonacci_2))
  putStrLn ("3 test_factorial_1 " ++ (show test_factorial_1))
  putStrLn ("3 test_factorial_2 " ++ (show test_factorial_2))
  putStrLn ("4 test_powerSeq_1 " ++ (show test_powerSeq_1))
  putStrLn ("4 test_powerSeq_2 " ++ (show test_powerSeq_2))
  putStrLn ("4 test_powerSeq_3 " ++ (show test_powerSeq_3))
  putStrLn ("9 test_expAppr_1 " ++ (show test_expAppr_1))
  putStrLn ("9 test_expAppr_2 " ++ (show test_expAppr_2))
  putStrLn ("9 test_expAppr_3 " ++ (show test_expAppr_3))
  putStrLn ("10 test_derivativeAppr_1 " ++ (show test_derivativeAppr_1))
  putStrLn ("10 test_derivativeAppr_2 " ++ (show test_derivativeAppr_2))
  putStrLn ("12 test_derivative_1 " ++ (show test_derivative_1))
  putStrLn ("12 test_derivative_2 " ++ (show test_derivative_2))
  putStrLn ("13 test_invF_1 " ++ (show test_invF_1))
  putStrLn ("13 test_invF_2 " ++ (show test_invF_2))
  putStrLn ("13 test_invF_3 " ++ (show test_invF_3))
  putStrLn ("14 test_average_1 " ++ (show test_average_1))
  putStrLn ("14 test_average_2 " ++ (show test_average_2))
  putStrLn ("15 test_averageDump_1 " ++ (show test_averageDump_1))
  putStrLn ("15 test_averageDump_2 " ++ (show test_averageDump_2))
  putStrLn ("16 test_newtonTransform_1 " ++ (show test_newtonTransform_1))
  putStrLn ("16 test_newtonTransform_2 " ++ (show test_newtonTransform_2))
  putStrLn ("20 test_sqrt1_1 " ++ (show test_sqrt1_1))
  putStrLn ("21 test_cubert1_1 " ++ (show test_cubert1_1))
  putStrLn ("22 test_sqrt2_1 " ++ (show test_sqrt2_1))
  putStrLn ("23 test_cubert2_1 " ++ (show test_cubert2_1))
  putStrLn ("20 test_sqrt1_2 " ++ (show test_sqrt1_2))
  putStrLn ("21 test_cubert1_2 " ++ (show test_cubert1_2))
  putStrLn ("22 test_sqrt2_2 " ++ (show test_sqrt2_2))
  putStrLn ("23 test_cubert2_2 " ++ (show test_cubert2_2))
  putStrLn ("24 test_extremum_1 " ++ (show test_extremum_1))
  putStrLn ("24 test_extremum_2 " ++ (show test_extremum_2))
  putStrLn ("25 test_myPi_1 " ++ (show test_myPi_1))
  putStrLn ("25 test_myPi_2 " ++ (show test_myPi_2))
  putStrLn "all tests done"







