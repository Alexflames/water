fun zip (x, y) =
  let
    fun zipIter ([], _, res) = rev res
      | zipIter (_, [], res) = rev res
      | zipIter (x1X :: x2X, x1Y :: x2Y, res) = 
          zipIter (x2X, x2Y, (x1X, x1Y) :: res)
  in
    zipIter (x, y, [])
  end

(* ТЕСТОВЫЕ ЗАПУСКИ *)
val test0 = zip ([], [])
val test1 = zip ([55, 4], [])
val test2 = zip ([], [16])
val test3 = zip ([1], [2])
val test4 = zip ([1, 2], [1, 19, 255])
val test5 = zip ([1, 2, 3, 4], [1, 19, 255])
val testTask = zip ([1, 2, 3], [4, 6])