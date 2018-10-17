fun f (x : int) : real =
  let
    (* В названиях сохраняемых величин используются
     * сокращения: P = plus = плюс, M = minus = минус. *)
    val xSqr = x * x
    val xCubeM3 = real (xSqr * x - 3)
    val xSqrP5 = real (xSqr + 5)
    val xP7 = real (x + 7)
  in
    (xSqrP5 * xSqrP5 - xCubeM3 * xCubeM3) / xP7
    + xP7 * xP7 / xSqrP5 + xCubeM3
  end
