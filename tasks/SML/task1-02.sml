fun fractionMinMax (a : real, b : real, c : real) : real =
  let
    val maxNum = if a >= b andalso a >= c then a
                 else if b >= a andalso b >= c then b
                 else c
    val minNum = if a <= b andalso a <= c then a
                 else if b <= a andalso b <= c then b
                 else c
  in
    (minNum + 0.5) / (maxNum * maxNum + 1.0)
  end

(* ТЕСТОВЫЕ ЗАПУСКИ *)
val test1 = fractionMinMax (1.5, 2.0, 1.75)
val test2 = fractionMinMax (1.0, 0.5, 0.86)
val test3 = fractionMinMax (7.0, 3.33, ~100.5)
val test4 = fractionMinMax (2.0, 2.0, 0.0)
val test5 = fractionMinMax (2.0, 2.0, 2.0)
val test6 = fractionMinMax (0.0, 0.0, 2.0)