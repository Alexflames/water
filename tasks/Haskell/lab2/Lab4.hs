
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
module Lab4(
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
funName (Fun s1 s2 expr) = s1
funName e                = error $ "The expression " 
                                   ++ show (e) 
                                   ++ " is not a function"

-- Задание 2 funArg 
funArg (Fun s1 s2 expr) = s2
funArg e                = error $ "The expression " 
                                  ++ show (e) 
                                  ++ " is not a function"

-- Задание 3 funBody 
funBody (Fun s1 s2 expr) = expr
funBody e                = error $ "The expression " 
                                   ++ show (e) 
                                   ++ " is not a function"

-- Задание 4 pairHead 
pairHead (Pair h t) = h
pairHead e          = error $ "The expression " ++ show (e) ++ " is not a pair"

-- Задание 5 pairTail 
pairTail (Pair h t) = t
pairTail e          = error $ "The expression " ++ show (e) ++ " is not a pair"

-- Задание 6 closureFun 
closureFun (Closure ps f) = f
closureFun e              = error $ "The expression " 
                                    ++ show (e) 
                                    ++ " is not a closure"

-- Задание 7 closureEnv 
closureEnv (Closure ps f) = ps
closureEnv e              = error $ "The expression " 
                                    ++ show (e) 
                                    ++ " is not a closure"

-- Задание 8 convertListToMUPL 
convertListToMUPL (h : t) = Pair h (convertListToMUPL t)
convertListToMUPL []      = Unit

-- Задание 9 convertListFromMUPL 
convertListFromMUPL Unit = []
convertListFromMUPL p    = pairHead p : (convertListFromMUPL (pairTail p))
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
evalUnderEnv (IntNum n) env = IntNum n
evalUnderEnv Unit env = Unit
evalUnderEnv (Closure ps f) env = Closure ps f
evalUnderEnv (Add e1 e2) env = IntNum ( valOfIntNum (evalUnderEnv e1 env) 
                                      + valOfIntNum (evalUnderEnv e2 env) )
evalUnderEnv (IfGreater e1 e2 e3 e4) env = 
  if valOfIntNum (evalUnderEnv e1 env) > valOfIntNum (evalUnderEnv e2 env) 
  then evalUnderEnv e3 env else evalUnderEnv e4 env
evalUnderEnv (Pair e1 e2) env = Pair (evalUnderEnv e1 env) (evalUnderEnv e2 env)
evalUnderEnv (Head e) env = pairHead (evalUnderEnv e env) 
evalUnderEnv (Tail e) env = pairTail (evalUnderEnv e env)
evalUnderEnv (IsAUnit e) env =
 if evalUnderEnv e env == Unit then IntNum 1 else IntNum 0 
evalUnderEnv (Let (str, e1) e2) env = evalUnderEnv e2 envNew
  where
    v1 = evalUnderEnv e1 env
    envNew = (str, v1) : env
evalUnderEnv (Fun name arg e) env = Closure env (Fun name arg e)
evalUnderEnv (Call e1 e2) env = evalUnderEnv (funBody clFun) newEnv
  where
    v1 = evalUnderEnv e1 env
    clFun = closureFun v1
    v2 = evalUnderEnv e2 env
    name = funName clFun
    newEnv = case name of "" -> (funArg clFun, v2) : closureEnv v1
                          _ -> (name, v1) : (funArg clFun, v2) : closureEnv v1
--------------------------------------------------------------------------------
-- Последующие решения связывают переменные Haskellа с выражениями на MUPL
-- (определяют макросы языка MUPL)
-- Задание 11 ifAUnit 
ifAUnit e1 e2 e3 = IfGreater (IsAUnit e1) (IntNum 0) e2 e3
-- Задание 12 mLet
mLet (h : l) e = Let h (mLet l e)
mLet [] e      = e
-- Задание 13 ifEq : mLet используется для избежания повторных вычислений
ifEq e1 e2 e3 e4 = 
  mLet [("_x", e1), ("_y", e2)]
    ( IfGreater (Var "_x") (Var "_y") e4 
      (IfGreater (Var "_y") (Var "_x") e4 e3) )
-- Задание 14 mMap 
mMap =
  Fun "" "func" 
  ( Fun "iter" "l" (
    ifAUnit (Var "l") Unit 
            ( Pair (Call (Var "func") (Head (Var "l")))
                   (Call (Var "iter") (Tail (Var "l"))) )
                   ) ) 
--Haskell--  
--nMap f [] = []
--nMap f (h : l) = f h : nMap f l

-- Задание 15 mMapAddN 
mMapAddN n = 
  Fun "" "l" (Call (Call mMap (Fun "" "elem" (Add n (Var "elem")))) (Var "l"))
-- Задание 16 fact 

-- hMinusOne x res = if x == (res + 1) then res else hMinusOne x (res + 1) 
-- mMinusOne x = Add x (IntNum (-1))--Нельзя использовать т.к. нет отрицательных

-- hMult x y = hMult (x (y - 1)) + x
-- hMult x 0 = 0

-- hfact 0 = 1
-- hfact n = n * hfact (n-1)
fact = 
  mLet [ ("mMinusOne", (Fun "" "x"
              ( Call ( Fun "toX" "res"
                ( Let ("newres", Add (Var "res") (IntNum 1)) 
                  ( ifEq (Var "x") (Var "newres") (Var "res") 
                         (Call (Var "toX") (Var "newres")) ) ) ) 
                       (IntNum 0) ) ) ),
         ("mMult", (Fun "" "x" 
          ( Fun "somefunc" "y" 
            ( IfGreater (Var "y") (IntNum 0) 
                       ( Add  (Call (Var "somefunc") 
                                    (Call (Var "mMinusOne") (Var "y")) )
                              (Var "x") )
                       (IntNum 0) ) ) ) ) ]
        (Fun "fact" "n" 
            ( ifEq (Var "n") (IntNum 0) (IntNum 1)
                   ( Call (Call (Var "mMult") (Var "n"))
                          ( ( Call (Var "fact") 
                                   (Call (Var "mMinusOne") (Var "n"))) ) ) ) )
