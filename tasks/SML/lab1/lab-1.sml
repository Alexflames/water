(* Шаблон для выполнения заданий лабораторной работы №1 *)

(* Задание 1 isLeapYear *)
fun isLeapYear (y : int) : bool =
  y mod 4 = 0 andalso (y mod 400 = 0 orelse y mod 100 <> 0)  
(* Задание 2 isCorrectDate *)
fun isCorrectDate (date : int * int * int) : bool =
  let
    val d = #1 date
    val m = #2 date
    val y = #3 date
  in
    if d >= 1 andalso d <= 31 andalso m >= 1 andalso m <= 12 andalso y > 0 then
      if m = 2 then
        if isLeapYear y = true andalso d <= 29 then true
        else d <= 28
      else m <= 30 + (m + m div 8) mod 2
    else false
  end
(* Задание 3 newStyleCorrection *)
fun newStyleCorrection (date : int * int * int) : int =
  let
    val m = #2 date
    val y = #3 date
    val delay = if y mod 100 = 0 andalso
    m < 2 orelse (m = 2 andalso #1 date < 29) then y - 1 else y
  in
    delay div 100 - delay div 400 - 2
  end
(* Задание 4 getNthInt *)
fun getNthInt (nums : int list, n : int) : int =
  if n > 0 then getNthInt (tl nums, n - 1)
  else hd nums
(* Задание 5 getNthStr *)
fun getNthStr (words : string list, n : int) : string =
  if n > 0 then getNthStr (tl words, n - 1)
  else hd words
(* Задание 6 lastSmaller *)
fun lastSmaller (amount : int, nums : int list) : int = 
  let
    fun getNum (ans : int, newlist : int list) : int =
      if null newlist then ans
      else if hd newlist >= amount then ans
           else getNum(hd newlist, tl newlist)
  in
    getNum(0, nums)
  end
(* Списки для выполнения задания 8 (списки поправок) *)
(* поправка на тысячи года *)
val thousandCorrection = [ 0, 1390000, 2770000, 1210000, 2590000
                          , 1030000, 2420000 ]
(* поправка на сотни года *)
val hundredCorrection  = [ 0, 430000, 870000, 1300000, 1740000
                          , 2170000, 2600000, 80000, 520000, 950000 ]
(* поправка на десятки года *)
val decadeCorrection   = [ 0, 930000, 1860000, 2790000, 760000
                          , 1690000, 2620000, 600000, 1530000, 2460000 ]
(* поправка на единицы года *)
val yearCorrection     = [ 0, 1860000, 780000, 2640000, 1550000
                          , 460000, 2330000, 1240000, 150000, 2020000 ]
(* поправка на месяц *)
val monthCorrection    = [ 1340000, 1190000, 2420000, 2260000, 2200000
                          , 2060000, 2000000, 1840000, 1700000, 1660000
                          , 1510000, 1480000 ]
(* календарная поправка *)
val calendarCorrection = [0, 20000, 50000, 80000]
(* поправка для нормализации дня месяца *)
val reductions = [2953059, 5906118, 8859177, 11812236, 14765295, 17718354] 

(* Задание 7 firstNewMoonInt *)
fun firstNewMoonInt (date : int * int * int) : int option =
  let
    val m = #2 date
    val y = #3 date
    val thirdDate = if m = 1 orelse m = 2 then y - 1 
    else y
    val correction = newStyleCorrection (date) * 100000
    + getNthInt (thousandCorrection, thirdDate div 1000) 
    + getNthInt (hundredCorrection, thirdDate mod 1000 div 100)
    + getNthInt (decadeCorrection, thirdDate mod 100 div 10)
    + getNthInt (yearCorrection, thirdDate mod 10) 
    + getNthInt (monthCorrection, m - 1) 
    + getNthInt (calendarCorrection, thirdDate mod 4) 
    val correction = correction - lastSmaller (correction - 100000, reductions)
    val numberOfDays = 
    if m = 2 then if isLeapYear y then 29 else 28
    else 30
  in
    if correction div 100000 <= numberOfDays then SOME (correction) else NONE
  end

(* Задание 8 firstNewMoon *)
fun firstNewMoon (date : int * int * int) : (int * int * int) option =
  let
    val newMoon = firstNewMoonInt date
  in
    if newMoon = NONE then NONE 
    else SOME (valOf newMoon div 100000, #2 date, #3 date)
  end

(* Задание 9 dateToString *)
val monthList = [ "January", "February", "March", "April", "May", "June"
                 , "July", "August", "September", "October", "November"
                 , "December" ]

fun dateToString (date : int * int * int) : string =
  getNthStr (monthList, #2 date - 1) ^ " " 
  ^ Int.toString(#1 date) ^ ", " ^ Int.toString(#3 date)
(* Задание 10 isOlder *)
fun isOlder (date1 : int * int * int,
             date2 : int * int * int) : bool =
  let
    val m1 = #2 date1
    val m2 = #2 date2
    val y1 = #3 date1
    val y2 = #3 date2
  in
    y2 > y1 orelse (y2 = y1 andalso m2 > m1)
            orelse (y2 = y1 andalso m2 = m1 andalso #1 date2 > #1 date1)
  end
(* Задание 11 winterSolstice *)
fun winterSolstice (y : int) : int =
  (2250000 + y * 24220) div 100000
  - y div 4 + y div 100 - y div 400
(* Задание 12 chineseNewYear *)
fun chineseNewYear (y : int) : int * int * int =
  let
    val ymin1 = y - 1
    val solsticeDate = winterSolstice ymin1 
    val newMoonDay = valOf (firstNewMoonInt (1, 12, ymin1))
    val diff = if (newMoonDay div 100000) <= solsticeDate
               then 5906118 + newMoonDay
               else 2953059 + newMoonDay
    val m = diff div 3100000
    val d = (diff mod 3100000 + m - 1) div 100000
  in
    if d = 0 then (31, m - 1, y)
             else (d, m, y)
  end

(* Списки для выполнения задания 13 *)
(* список небесных стихий (по-китайски) *)
val celestialChi   = [ "Jia", "Yi", "Bing", "Ding", "Wu"
                      , "Ji", "Geng", "Xin", "Ren", "Gui" ] 
(* список небесных стихий (по-английски) *)
val celestialEng   = [ "Growing wood", "Cut timber", "Natural fire"
                      , "Artificial fire", "Earth", "Earthenware"
                      , "Metal", "Wrought metal", "Running water"
                      , "Standing water" ]
(* цвета, соответствующие небесным стихиям *)
val celestialColor = ["Green", "Red", "Brown", "White", "Black"] 
(* список земных стихий (по-китайски) *)
val terrestrialChi = [ "Zi", "Chou", "Yin", "Mao"
                      , "Chen", "Si", "Wu", "Wei"
                      , "Shen", "You", "Xu", "Hai" ]
(* список земных стихий (по-английски) *)
val terrestrialEng = [ "Rat", "Cow", "Tiger", "Rabbit"
                      , "Dragon", "Snake", "Horse", "Sheep"
                      , "Monkey", "Chicken", "Dog", "Pig" ]

(* Задание 13 chineseYear *)
fun chineseYear (year : int) : string * string * string * string =
  let
    val y = (year + 2396) mod 60
    val ymod10 = y mod 10
    val ymod12 = y mod 12
  in
    ( getNthStr (celestialChi, ymod10) ^ "-" 
    ^ getNthStr (terrestrialChi, y mod 12)
    , getNthStr (celestialColor, ymod10 div 2)
    , getNthStr (terrestrialEng, ymod12)
    , getNthStr (celestialEng, ymod10) )
  end
(* Задание 14 dateToChineseYear *)
fun dateToChineseYear (date : int * int * int) 
                      : string * string * string * string =
let
  val y = #3 date
in
    if isOlder (date, chineseNewYear y) then chineseYear (y - 1)
    else chineseYear y
end
(* Задание 15 dateToAnimal *)
fun dateToAnimal (date : int * int * int) : string =
  #3 (dateToChineseYear date)
(* Задание 16 animal *)
fun animal (person : string * (int * int * int)) : string =
  dateToAnimal (#2 person)
(* Задание 17 extractAnimal *)
fun goThrough ( person : (string * (int * int * int)) list
                  , l : (string * (int * int * int)) list
                  , name : string )
                  : (string * (int * int * int)) list =
      if null person then l
      else if animal (hd person) = name then 
             goThrough (tl person, hd person::l, name)
           else
             goThrough (tl person, l, name)

fun extractAnimal (students : (string * (int * int * int)) list, name : string)
                  : (string * (int * int * int)) list =
    goThrough (students, [], name)
(* Задание 18 extractAnimals *)
fun extractAnimals ( students : (string * (int * int * int)) list
                   , names : string list ) 
                   : (string * (int * int * int)) list =
  let
    fun goThroughAnims ( animals : string list
                       , l : (string * (int * int * int)) list )
                       : (string * (int * int * int)) list =
      if null animals then l 
      else goThroughAnims (tl animals, goThrough (students, l, hd animals))
  in
    goThroughAnims (names, [])
  end

(* Задание 19 oldest *)
fun oldest (data : (string * (int * int * int)) list) : string option =
  if null data then NONE
  else
    let
      fun iter ( max : (string * (int * int * int))
               , l : (string * (int * int * int)) list ) : string =
        if null l then #1 max
        else if isOlder (#2 (hd l), #2 max) then iter (hd l, tl l)
             else iter (max, tl l)
    in
      SOME (iter (hd data, tl data))
    end
(* Задание 20 oldestFromAnimals *)
fun oldestFromAnimals (students : (string * (int * int * int)) list
                      , names : string list) : string option =
  let
    val l = extractAnimals (students, names)
  in
    if null l then NONE else oldest l
  end
