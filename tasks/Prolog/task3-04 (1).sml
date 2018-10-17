(* N - целочисленный параметр *)
fun y (N : int) : real =
  let
    (* Так как в выражении присутствуют вещественнозначные операции 
     * (деление), параметры i и j будем рассматривать как вещественные 
     * числа и сравнивать с вещественным эквивалентом параметра N *)
    val rN = real N

    fun jIter (i : real, j : real, slag : real) : real =
      if j > rN + 1.0
      then slag
      else jIter (i, j + 1.0, slag + (j / i - i))

    fun iIter (i : real, rez : real) : real =
      if i > rN 
      then rez
      else iIter (i + 1.0, rez * jIter (i, ~5.0, 0.0))
  in
    iIter (4.0, 1.0)
  end

(* ТЕСТОВЫЕ ЗАПУСКИ *)
val test2 = y ~3
val test3 = y 2
val test5 = y 4
val test6 = y 5
