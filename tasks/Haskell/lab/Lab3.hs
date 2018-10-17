
-- Шаблон для выполнения заданий Лабораторной работы №3 

-- ниеже перечисляются имена, доступные после загрузки данного модуля
-- (например в файле с тестами)
-- по мере реализации решений заданий снимайте комментарий 
-- с соответствующей функции
module Lab3 
  ( epsilon
  , epsilon'
  , epsilon''
  , nat
  , fibonacci
  , factorial
  , powerSeq
  , findCloseEnough
  , streamSum
  , expSummands
  , expStream
  , expAppr
  , derivativeAppr
  , derivativeStream
  , derivative
  , funAkStream 
  , invF
  , average
  , averageDump
  , newtonTransform
  , eitken
  , fixedPoint
  , fixedPointOfTransform
  , sqrt1
  , cubert1
  , sqrt2
  , cubert2
  , extremum
  , myPi
  ) where
--------------------------------------------------------------------------------
-- Вспомогательные определения
--------------------------------------------------------------------------------
import Data.List
epsilon  = 0.001
epsilon' = 0.00001
epsilon'' = 0.00000001
--------------------------------------------------------------------------------

-- Задание 1 nat 
nat = [1..]
-- Задание 2 fibonacci 
fibonacci = [0, 1] ++ zipWith (+) fibonacci (tail fibonacci)
-- Задание 3 factorial 
factorial = [1] ++ zipWith (*) factorial nat
-- Задание 4 powerSeq 
powerSeq x = iterate (x*) 1
-- Задание 5 findCloseEnough 
findCloseEnough eps stream = ans
  where
    (fst, scnd) : seq = zipWith (,) stream (tail stream)
    ans = if abs (scnd - fst) < eps 
          then scnd else findCloseEnough eps (tail stream)
-- Задание 6 streamSum 
streamSum stream = [0] ++ zipWith (+) (streamSum stream) stream
-- Задание 7 expSummands 
expSummands x = zipWith (/) (powerSeq x) fact
  where fact = map fromIntegral factorial
-- Задание 8 expStream 
expStream x = streamSum (expSummands x)
-- Задание 9 expAppr 
expAppr eps = \x -> findCloseEnough eps (expStream x)
-- Задание 10 derivativeAppr 
derivativeAppr f dx = \x -> (f (x + dx) - f x) / dx 
-- Задание 11 derivativeStream 
derivativeStream f = \x -> map (\dx -> derivativeAppr f dx x) (powerSeq 0.5)
-- Задание 12 derivative 
derivative f = \x -> findCloseEnough epsilon' (derivativeStream f x)
-- Задание 13 funAkStream и invF     
funAkStream g = iterate (\y x -> (derivative y x) / (g x)) (\x -> x)

invF f y0 = \x ->
  let
    multStream = funAkStream (derivative f)
    drobStream = expSummands (x - f y0)
    multdrobStream = zipWith (\mlt drb -> mlt y0 * drb) multStream drobStream
  in
    findCloseEnough epsilon (streamSum multdrobStream)
-- Задание 14 average 
average x y = (x + y) / 2
-- Задание 15 averageDump 
averageDump f = \x -> (x + (f x)) / 2
-- Задание 16 newtonTransform 
newtonTransform g = \x -> x - (g x) / (derivative g x)
-- Задание 17 eitken 
eitken stream = zipWith (\(s3, s2) s -> (s3 * s - s2 * s2) / (s3 - 2 * s2 + s))
                        (zipWith (,) (tail $ tail stream) (tail stream)) stream
-- Задание 18 fixedPoint
fixedPoint f x0 = iterate f x0
-- Задание 19 fixedPointOfTransform 
fixedPointOfTransform f transform x0 = 
  findCloseEnough epsilon' (fixedPoint (transform f) x0) 
-- Задание 20 sqrt1 
sqrt1 x = fixedPointOfTransform (\y -> x / y) averageDump 1.0
-- Задание 21 cubert1 
cubert1 x = fixedPointOfTransform (\y -> x / (y * y)) averageDump 1.0
-- Задание 22 sqrt2 
sqrt2 x = fixedPointOfTransform (\y -> y * y - x) newtonTransform 1.0
-- Задание 23 cubert2 
cubert2 x = fixedPointOfTransform (\y -> y * y * y - x) newtonTransform 1.0
-- Задание 24 extremum
extremum f = (ans, word)
  where
    derf = derivative f
    ans = fixedPointOfTransform derf newtonTransform 1.0
    der2f = derivative derf
    word = if der2f ans < (- epsilon) then "maximum"
           else if der2f ans > epsilon then "minimum"
                else "inflection"
-- Задание 25 myPi 
myPi = 4 * (findCloseEnough epsilon'' $ eitken $ streamSum $ 
  zipWith (\fact znam -> fact / (fromIntegral znam)) 
          (powerSeq (-1)) (iterate (2+) 1))
