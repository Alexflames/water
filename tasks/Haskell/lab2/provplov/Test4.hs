-- Первоначальный набор тестов для лабораторной работы №4
-- по мере реализации решений заданий снимайте комментарий 
-- с тестов соответствующей функции и пополняйте их своими тестами
-- кроме того, снимайте комментарий соответствующих строк вывода 
-- результатов тестов в функции main в конце файла и пополняйте эту 
-- функцию своими строками

-- Для проведения тестов запустите этот файл и выполните запуск main

import Lab4
--------------------------------------------------------------------------------
-- Блок вспомогательных определений
-- Не вносите изменения в этот блок
--------------------------------------------------------------------------------
import Control.Exception

-- вспомогательная функция, для вывода на экран True, когда 
-- возникает сообщение об ошибке
handler1 = (\_ -> putStrLn "True") :: Exception -> IO ()

-- вспомогательная функция, для вывода на экран False, когда 
-- возникает сообщение об ошибке
handler2 = (\_ -> putStrLn "False") :: Exception -> IO ()
--------------------------------------------------------------------------------

------ Задание 1 funName 
test_funName_1 = funName (Fun "" "a" Unit) == []
test_funName_2 = funName Unit == []
test_funName_3 = funName (Fun "funny_fun" "fun" Unit) == "funny_fun"

------ Задание 2 funArg 
test_funArg_1 = funArg (Fun "" "a" Unit) == "a"
test_funArg_2 = funArg Unit == []
test_funArg_3 = funArg (Fun "" "anything" Unit) == "anything"

------ Задание 3 funBody 
test_funBody_1 = funBody (Fun "" "a" Unit) == Unit
test_funBody_2 = funBody Unit == Unit
test_funBody_3 = funBody (Fun "" "a" (IntNum 4)) == IntNum 4

------ Задание 4 pairHead 
test_pairHead_1 = pairHead (Pair (Var "a") Unit) == Var "a"
test_pairHead_2 = pairHead Unit == Unit
test_pairHead_3 = pairHead (Pair (IntNum 55) Unit) == IntNum 55

------ Задание 5 pairTail 
test_pairTail_1 = pairTail (Pair (Var "a") Unit) == Unit
test_pairTail_2 = pairTail Unit == Unit
test_pairTail_3 = pairTail (Pair (Var "a") (IntNum 55)) == IntNum 55

------ Задание 6 closureFun 
test_closureFun_1 = closureFun (Closure [] (Fun "" "a" Unit)) 
                    == (Fun "" "a" Unit)
test_closureFun_2 = closureFun Unit == Unit
test_closureFun_3 = closureFun (Closure [] (Fun "useless" "a" Unit)) 
                    == (Fun "useless" "a" Unit) 

------ Задание 7 closureEnv 
test_closureEnv_1 = closureEnv (Closure [] (Fun "" "a" Unit)) == []
test_closureEnv_2 = closureEnv Unit == [("a", IntNum 5)]
test_closureEnv_3 = closureEnv (Closure [("a", IntNum 5), ("b", IntNum 55)]
  (Fun "" "lol" Unit)) == [("a", IntNum 5), ("b", IntNum 55)]

------ Задание 8 convertListToMUPL 
test_convertListToMUPL_1 = convertListToMUPL [] == Unit
test_convertListToMUPL_2 = convertListToMUPL [Unit] == Pair Unit Unit
test_convertListToMUPL_3 = convertListToMUPL [Unit, Unit] == Pair Unit (Pair Unit Unit)

------ Задание 9 convertListFromMUPL 
test_convertListFromMUPL_1 = convertListFromMUPL Unit == []
test_convertListFromMUPL_2 = convertListFromMUPL (Pair Unit Unit) == [Unit]
test_convertListFromMUPL_3 = convertListFromMUPL (Pair Unit (Pair Unit Unit)) 
  == [Unit, Unit]

------ Задание 10 evalUnderEnv 
test_evalUnderEnv_1 = evalUnderEnv (Var "a") [("a", IntNum 5)] == IntNum 5
test_evalUnderEnv_2 = evalUnderEnv (IntNum 5) [] == IntNum 5
test_evalUnderEnv_3 = evalUnderEnv Unit [] == Unit
test_evalUnderEnv_4 = evalUnderEnv (Pair (IntNum 2) (IntNum 3)) [] ==
  Pair (IntNum 2) (IntNum 3)
test_evalUnderEnv_5 = evalUnderEnv (Let ("a", (IntNum 55)) (Pair (IntNum 55) (Var "a"))) []
  == Pair (IntNum 55) (IntNum 55)

------ Задание 11 ifAUnit 
test_ifAUnit_1 = (evalExp $ ifAUnit Unit (IntNum 5) (IntNum 6)) == IntNum 5
test_ifAUnit_2 = (evalExp $ ifAUnit (IntNum 5) (IntNum 6) Unit) == Unit
test_ifAUnit_3 = (evalExp $ ifAUnit (IntNum 0) (IntNum 6) Unit) == Unit

------ Задание 12 mLet 
test_mLet_1 = 
 mLet [ ("a", IntNum 5)
      , ("b", IntNum 6)
      , ("c", Unit)
      , ("d", Pair Unit Unit)
      ]
   (IfGreater (Var "a") (Var "b") (Var "d") (Var "c"))
 == Let ("a", IntNum 5)
      (Let ("b", IntNum 6)
        (Let ("c", Unit)
          (Let ("d", Pair Unit Unit) 
            (IfGreater (Var "a") (Var "b") (Var "d") (Var "c")))))
test_mLet_2 = mLet [] (IntNum 55) == (IntNum 55)

------ Задание 13 ifEq 
test_ifEq_1 = 
 ( evalExp 
   $ ifEq (IntNum 5) (IntNum 6) Unit (Pair Unit Unit) )
 == Pair Unit Unit
test_ifEq_2 = 
 ( evalExp 
   $ ifEq (IntNum 5) (IntNum 5) Unit (Pair Unit Unit) ) == Unit

------ Задание 14 mMap 
test_mMap_1 = 
 ( evalExp 
   $ Call 
       (Call mMap (Fun "" "x" 
                    (Add (Var "x") (IntNum 5)))) 
       (Pair (IntNum 1) (Pair (IntNum 2) (Pair (IntNum 3) Unit))) )
 == Pair (IntNum 6) (Pair (IntNum 7) (Pair (IntNum 8) Unit))
test_mMap_2 = 
 ( evalExp 
   $ Call 
       (Call mMap (Fun "" "x" 
                    (Add (Var "x") (Var "x")))) 
       (Pair (IntNum 1) (Pair (IntNum 2) (Pair (IntNum 3) Unit))) )
 == Pair (IntNum 2) (Pair (IntNum 4) (Pair (IntNum 6) Unit))

------ Задание 15 mMapAddN 
test_mMapAddN_1 = 
 ( evalExp 
   $ Call (mMapAddN (IntNum 5))
          (Pair (IntNum 1) (Pair (IntNum 2) (Pair (IntNum 3) Unit))) )
 == Pair (IntNum 6) (Pair (IntNum 7) (Pair (IntNum 8) Unit))
test_mMapAddN_2 = 
 ( evalExp 
   $ Call (mMapAddN (IntNum 15))
          (Pair (IntNum 1) (Pair (IntNum 2) (Pair (IntNum 3) Unit))) )
 == Pair (IntNum 16) (Pair (IntNum 17) (Pair (IntNum 18) Unit))

---- Задание 16 fact 
test_fact_1 = ( evalExp $ Call fact (IntNum 5) ) == IntNum 120
test_fact_2 = ( evalExp $ Call fact (IntNum 6) ) == IntNum 720


---- Запуск всех тестов
---- На каждый тест 2 строки main
main = do      
  putStr ("1 test_funName_1 ")
  Control.Exception.catch (putStrLn $ show test_funName_1) handler2 
  putStr ("1 test_funName_2 ")
  Control.Exception.catch (putStrLn $ show test_funName_2) handler1
  putStr ("1 test_funName_3 ")
  Control.Exception.catch (putStrLn $ show test_funName_3) handler2 
  putStr ("2 test_funArg_1 ")
  Control.Exception.catch (putStrLn $ show test_funArg_1) handler2 
  putStr ("2 test_funArg_2 ")
  Control.Exception.catch (putStrLn $ show test_funArg_2) handler1 
  putStr ("2 test_funArg_3 ")
  Control.Exception.catch (putStrLn $ show test_funArg_3) handler2 
  putStr ("3 test_funBody_1 ")
  Control.Exception.catch (putStrLn $ show test_funBody_1) handler2 
  putStr ("3 test_funBody_2 ")
  Control.Exception.catch (putStrLn $ show test_funBody_2) handler1 
  putStr ("3 test_funBody_3 ")
  Control.Exception.catch (putStrLn $ show test_funBody_3) handler2 
  putStr ("4 test_pairHead_1 ")
  Control.Exception.catch (putStrLn $ show test_pairHead_1) handler2 
  putStr ("4 test_pairHead_2 ")
  Control.Exception.catch (putStrLn $ show test_pairHead_2) handler1 
  putStr ("4 test_pairHead_3 ")
  Control.Exception.catch (putStrLn $ show test_pairHead_3) handler2 
  putStr ("5 test_pairTail_1 ")
  Control.Exception.catch (putStrLn $ show test_pairTail_1) handler2 
  putStr ("5 test_pairTail_2 ")
  Control.Exception.catch (putStrLn $ show test_pairTail_2) handler1 
  putStr ("5 test_pairTail_3 ")
  Control.Exception.catch (putStrLn $ show test_pairTail_3) handler2 
  putStr ("6 test_closureFun_1 ")
  Control.Exception.catch (putStrLn $ show test_closureFun_1) handler2 
  putStr ("6 test_closureFun_2 ")
  Control.Exception.catch (putStrLn $ show test_closureFun_2) handler1 
  putStr ("6 test_closureFun_3 ")
  Control.Exception.catch (putStrLn $ show test_closureFun_3) handler2 
  putStr ("7 test_closureEnv_1 ")
  Control.Exception.catch (putStrLn $ show test_closureEnv_1) handler2 
  putStr ("7 test_closureEnv_2 ")
  Control.Exception.catch (putStrLn $ show test_closureEnv_2) handler1 
  putStr ("7 test_closureEnv_3 ")
  Control.Exception.catch (putStrLn $ show test_closureEnv_3) handler2
  putStr ("8 test_convertListToMUPL_1 ")
  Control.Exception.catch (putStrLn $ show test_convertListToMUPL_1) handler2 
  putStr ("8 test_convertListToMUPL_2 ")
  Control.Exception.catch (putStrLn $ show test_convertListToMUPL_2) handler2 
  putStr ("8 test_convertListToMUPL_3 ")
  Control.Exception.catch (putStrLn $ show test_convertListToMUPL_3) handler2
  putStr ("9 test_convertListFromMUPL_1 ")
  Control.Exception.catch (putStrLn $ show test_convertListFromMUPL_1) handler2 
  putStr ("9 test_convertListFromMUPL_2 ")
  Control.Exception.catch (putStrLn $ show test_convertListFromMUPL_2) handler2 
  putStr ("9 test_convertListFromMUPL_3 ")
  Control.Exception.catch (putStrLn $ show test_convertListFromMUPL_3) handler2 
  putStr ("10 test_evalUnderEnv_1 ")
  Control.Exception.catch (putStrLn $ show test_evalUnderEnv_1) handler2 
  putStr ("10 test_evalUnderEnv_2 ")
  Control.Exception.catch (putStrLn $ show test_evalUnderEnv_2) handler2 
  putStr ("10 test_evalUnderEnv_3 ")
  Control.Exception.catch (putStrLn $ show test_evalUnderEnv_3) handler2 
  putStr ("10 test_evalUnderEnv_4 ")
  Control.Exception.catch (putStrLn $ show test_evalUnderEnv_4) handler2 
  putStr ("10 test_evalUnderEnv_5 ")
  Control.Exception.catch (putStrLn $ show test_evalUnderEnv_5) handler2 
  putStr ("11 test_ifAUnit_1 ")
  Control.Exception.catch (putStrLn $ show test_ifAUnit_1) handler2 
  putStr ("11 test_ifAUnit_2 ")
  Control.Exception.catch (putStrLn $ show test_ifAUnit_2) handler2 
  putStr ("11 test_ifAUnit_3 ")
  Control.Exception.catch (putStrLn $ show test_ifAUnit_3) handler2 
  putStr ("12 test_mLet_1 ")
  Control.Exception.catch (putStrLn $ show test_mLet_1) handler2 
  putStr ("12 test_mLet_2 ")
  Control.Exception.catch (putStrLn $ show test_mLet_2) handler2 
  putStr ("13 test_ifEq_1 ")
  Control.Exception.catch (putStrLn $ show test_ifEq_1) handler2 
  putStr ("13 test_ifEq_2 ")
  Control.Exception.catch (putStrLn $ show test_ifEq_2) handler2 
  putStr ("14 test_mMap_1 ")
  Control.Exception.catch (putStrLn $ show test_mMap_1) handler2 
  putStr ("14 test_mMap_2 ")
  Control.Exception.catch (putStrLn $ show test_mMap_2) handler2 
  putStr ("15 test_mMapAddN_1 ")
  Control.Exception.catch (putStrLn $ show test_mMapAddN_1) handler2 
  putStr ("15 test_mMapAddN_2 ")
  Control.Exception.catch (putStrLn $ show test_mMapAddN_2) handler2 
  putStr ("16 test_fact_1 ")
  Control.Exception.catch (putStrLn $ show test_fact_1) handler2 
  putStr ("16 test_fact_2 ")
  Control.Exception.catch (putStrLn $ show test_fact_2) handler2 
  putStrLn "all tests done"


