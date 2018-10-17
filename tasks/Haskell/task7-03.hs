{- Определяем функцию трех аргументов результатом которой будет
 - заданная последовательность
 - Последовательность организуем как список из трех заданных
 - элементов к которому присоединен результат применения специальной
 - функции к трем подспискам списка и списку целых чисел
 -}
aStream x = seqn
  where
    seqn = [0, x]
           ++ zipWith nextEl seqn (tail seqn)
    nextEl prevprev prev = 0.2 * prev * prev + x * x * prevprev / 2

main = do
  print $ take 5 $ aStream 1.3
  print $ take 5 $ aStream 0.0
  print $ take 5 $ aStream 2.0
  print $ take 15 $ aStream 1.0
  print $ take 15 $ aStream 5.0
  print $ drop 100 $ take 115 $ aStream 1.0
  print $ drop 1000 $ take 1015 $ aStream 1.0



