
-- Шаблон для выполнения заданий Лабораторной работы №4 
-- ВСЕ КОММЕНТАРИИ ПРИВЕДЕННЫЕ В ДАННОМ ФАЙЛЕ ДОЛЖНЫ ОСТАТЬСЯ НА СВОИХ МЕСТАХ
-- предыдущее замечание относится к тем комментариям, которые
-- не предполагают раскомментирование
-- НЕЛЬЗЯ ПЕРЕСТАВЛЯТЬ МЕСТАМИ КАКИЕ-ЛИБО БЛОКИ ДАННОГО ФАЙЛА
-- решения заданий должны быть вписаны в отведенные для этого позиции 

-- ниеже перечисляются имена, доступные после загрузки данного модуля
-- (например в файле с тестами)
-- по мере реализации решений заданий снимайте комментарий 
-- с соответствующей функции
module Lab4 (
  Expr ( Var, IntNum, Add, IfGreater, Fun, Call, Let
       , Pair, Head, Tail, Unit, IsAUnit, Closure )
  , valOfIntNum
  , funName
  , funArg
  , funBody
  , pairHead
  , pairTail
  , closureFun
  , closureEnv
  , convertListToMUPL
  , convertListFromMUPL
  , envLookUp
  , evalExp
  , evalUnderEnv
  , ifAUnit
  , mLet
  , ifEq
  , mMap
  , mMapAddN
  , fact
  )
  where
--------------------------------------------------------------------------------
-- Вспомогательные определения
-- нельзя вносить изменения в следующий блок
--------------------------------------------------------------------------------
data Expr = Var String
          | IntNum Integer
          | Add Expr Expr
          | IfGreater Expr Expr Expr Expr
          | Fun String String Expr
          | Call Expr Expr
          | Let (String, Expr) Expr
          | Pair Expr Expr
          | Head Expr
          | Tail Expr
          | Unit 
          | IsAUnit Expr
          | Closure [(String, Expr)] Expr
  deriving (Show, Eq) 

valOfIntNum (IntNum n) = n
valOfIntNum e          = error $ "The expression " 
                                 ++ show (e) 
                                 ++ " is not a number"
--------------------------------------------------------------------------------
-- Задание 1 funName 
funName (Fun name _ _) = name
funName e = error $ "The expression " ++ show (e) ++ " is not a function"

-- Задание 2 funArg 
funArg (Fun _ arg _) = arg
funArg e = error $ "The expression " ++ show (e) ++ " is not a function"

-- Задание 3 funBody 
funBody (Fun _ _ body) = body
funBody e = error $ "The expression " ++ show (e) ++ " is not a function"

-- Задание 4 pairHead 
pairHead (Pair hd _) = hd
pairHead e = error $ "The expression " ++ show (e) ++ " is not a pair"

-- Задание 5 pairTail 
pairTail (Pair _ tl) = tl
pairTail e = error $ "The expression " ++ show (e) ++ " is not a pair"

-- Задание 6 closureFun 
closureFun (Closure _ f) = f
closureFun e = error $ "The expression " ++ show (e) ++ " is not a closure"

-- Задание 7 closureEnv 
closureEnv (Closure env _) = env
closureEnv e = error $ "The expression " ++ show (e) ++ " is not a closure"

-- Задание 8 convertListToMUPL 
convertListToMUPL (x : xs) = Pair x $ convertListToMUPL xs
convertListToMUPL [] = Unit

-- Задание 9 convertListFromMUPL 
convertListFromMUPL (Pair x xs) = x : convertListFromMUPL xs
convertListFromMUPL Unit = []

--------------------------------------------------------------------------------
-- Вспомогательные определения
-- нельзя вносить изменения в следующий блок
--------------------------------------------------------------------------------
envLookUp [] str = error $ "Unbound variable " ++ str
envLookUp ((var, expr) : xs) str 
  | var == str = expr
  | otherwise  = envLookUp xs str

evalExp e = evalUnderEnv e []
--------------------------------------------------------------------------------
-- Задание 10 evalUnderEnv 
-- Заданную строку определения изменять нельзя
-- необходимо дополнить определение функции
evalUnderEnv (Var name) env = envLookUp env name
evalUnderEnv (IntNum num) _ = IntNum num
evalUnderEnv Unit env = Unit
evalUnderEnv (Add e1 e2) env = 
  IntNum (valOfIntNum (evalUnderEnv e1 env) + valOfIntNum (evalUnderEnv e2 env))
evalUnderEnv (IfGreater e1 e2 e3 e4) env = 
  evalUnderEnv ( if valOfIntNum (evalUnderEnv e1 env)
                    > valOfIntNum (evalUnderEnv e2 env)
                 then e3 
                 else e4 )
               env
evalUnderEnv (Pair e1 e2) env = Pair (evalUnderEnv e1 env) (evalUnderEnv e2 env)
evalUnderEnv (Head e) env = pairHead $ evalUnderEnv e env
evalUnderEnv (Tail e) env = pairTail $ evalUnderEnv e env
evalUnderEnv (IsAUnit e) env = 
  if evalUnderEnv e env == Unit then IntNum 1 else IntNum 0
evalUnderEnv (Let (str, e1) e2) env = 
  evalUnderEnv e2 $ (str, evalUnderEnv e1 env) : env
evalUnderEnv (Closure env f) _ = Closure env f
evalUnderEnv (fun @ (Fun name arg e)) env = Closure env fun
evalUnderEnv (Call e1 e2) env = 
  evalUnderEnv (funBody fun) $ if not (null nFun) then (nFun, v1) : env2
                               else env2
  where
    v1 = evalUnderEnv e1 env
    fun = closureFun v1
    nFun = funName fun
    env2 = (funArg fun, evalUnderEnv e2 env) : closureEnv v1

--------------------------------------------------------------------------------
-- Последующие решения связывают переменные Haskellа с выражениями на MUPL
-- (определяют макросы языка MUPL)
-- Задание 11 ifAUnit 
ifAUnit e1 e2 e3 = IfGreater (IsAUnit e1) (IntNum 0) e2 e3

-- Задание 12 mLet 
mLet [] e = e
mLet (x : xs) e  = Let x (mLet xs e)

-- Задание 13 ifEq 
ifEq e1 e2 e3 e4 =
  mLet [("_x", e1), ("_y", e2)]
       ( IfGreater (Var "_x") (Var "_y") e4
                   (IfGreater (Var "_y") (Var "_x") e4 e3) )

-- Задание 14 mMap 
mMap = 
  Fun "" "fun"
      ( Fun "map" "lst"
            ( ifAUnit (Var "lst") Unit
                      ( Pair (Call (Var "fun") (Head (Var "lst"))) 
                             (Call (Var "map") (Tail (Var "lst"))) ) ) )

-- Задание 15 mMapAddN 
mMapAddN n = Call mMap (Fun "" "x" (Add n (Var "x")))

-- Задание 16 fact 
fact = 
  Fun "" "n" 
      ( mLet [ ( "mul"
               , Fun "" "x" 
                     ( Fun "" "y" 
                           ( Fun "iter" "z" 
                                 ( IfGreater (Var "x") (Var "z")
                                             ( Add (Var "y")
                                                   ( ( Call (Var "iter")
                                                            ( Add (Var "z")
                                                                  (IntNum 1) ) )
                                                   )
                                             )
                                             (IntNum 0) ) ) ) )
             , ( "fact"
               , Fun "iter" "k" 
                     ( IfGreater (Var "k") (Var "n") (IntNum 1)
                                 ( Call ( Call (Call (Var "mul") (Var "k"))
                                               ( Call (Var "iter")
                                                      (Add (Var "k") (IntNum 1))
                                               )
                                        )
                                        (IntNum 0) ) ) ) ] 
             (Call (Var "fact") (IntNum 1)) )