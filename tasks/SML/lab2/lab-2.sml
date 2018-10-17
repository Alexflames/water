(* Шаблон для выполнения заданий лабораторной работы №2 
 * НЕ СЛЕДУЕТ УДАЛЯТЬ ИЛИ ПЕРЕСТАВЛЯТЬ МЕСТАМИ ЭЛЕМЕНТЫ, 
 * ПРЕДСТАВЛЕННЫЕ В ШАБЛОНЕ (ВКЛЮЧАЯ КОММЕНТАРИИ). 
 * ЭЛЕМЕНТЫ РЕШЕНИЯ СЛЕДУЕТ ВПИСЫВАТЬ В ПРОМЕЖУТКИ,
 * ОПРЕДЕЛЕННЫЕ КОММЕНТАРИЯМИ.
 * Можно (а иногда и нужно) вставлять пустые строки в промежутки, 
 * предназначенные для решения. *)

(****************************************************************************** 
                    Вспомогательные функции и определения
 ******************************************************************************)
(* Выдает "случайное" целое число, на основе текущего времени *)
fun seed () = 
  IntInf.toInt (Time.toMilliseconds (Time.now ()) mod 1000) + 100

(* Превращает некаррированную функцию двух аргументов в каррированную *)
fun curry_2 f x y = f (x, y)

(* Тип данных color для цвета (масти) карт *)
datatype color = RED | GREEN | BLUE | YELLOW | BLACK

(* Тип данных rank для значения карт *)
datatype rank = SKIP 
              | DRAW_TWO 
              | REVERSE 
              | WILD 
              | WILD_DRAW_FOUR 
              | NUM of int 

(* Тип данных card для карты *)
type card = color * rank

(* Тип данных move для состояния очередного хода *)
datatype move = PROCEED | EXECUTE | GIVE of color 

(* Тип strategy для функции, определяющей стратегию игрока *)
type strategy = move * card list * card * int list -> card * color

(* Тип данных player для игрока *)
type player = {name : string, cards : card list, strat : strategy}

(* Тип данных desk для конфигурации игры *)
type desk = { players : player list
            , pile    : card list
            , deck    : card list
            , state   : move
            }

(* Исключение "Недозволенная игра" *)
exception IllegalGame
(* Исключение "Недозволенный ход". Аргумент - имя игрока, сделавшего ход *)
exception IllegalMove of string 

(* Функции сравнения на равенство значений карт, мастей карт и карт *)
fun isSameRank  (r1 : rank, r2 : rank) = r1 = r2
fun isSameColor (col1 : color, col2 : color) = col1 = col2
fun isSameCard  (c1 : card, c2 : card) = c1 = c2

(* Список всевозможных значений карт *)
val ranks = [ NUM 0, NUM 1, NUM 2, NUM 3, NUM 4
            , NUM 5, NUM 6, NUM 7, NUM 8, NUM 9
            , SKIP, DRAW_TWO, REVERSE, WILD, WILD_DRAW_FOUR 
            ]

(* Конструктор значения типа player (игрок) 
 * аргументы имя, список карт и функция стратегии *)
fun makePlayer (n, cs, f) : player = {name= n, cards = cs, strat = f}

(* Селекторы для игрока *)
fun getPlayerName ({name = n, ...} : player) = n
fun getPlayerCards ({cards = cs, ...} : player) = cs
fun getPlayerStrategy ({strat = f, ...} : player) = f 

(* Функция замены набора карт игрока *)
fun setPlayerCards (p, newCs) =
  makePlayer (getPlayerName p, newCs, getPlayerStrategy p)

(* Конструктор конфигурации игры *)
fun makeDesk (ps, cs, ds, st) : desk = 
  {players = ps, pile = cs, deck = ds, state = st}

(* Селекторы для конфигурации игры *)
fun getDeskPlayers ({players = ps, ...} : desk) = ps
fun getDeskPile ({pile = cs, ...} : desk) = cs
fun getDeskDeck ({deck = ds, ...} : desk) = ds
fun getDeskState ({state = st, ...} : desk) = st

(* Функция замены списка игроков в конфигурации игры *)
fun setDeskPlayers (dsk, newPlayers) =
  makeDesk ( newPlayers
           , getDeskPile dsk
           , getDeskDeck dsk
           , getDeskState dsk
           )

(* Функция замены состояния очередного хода в конфигурации игры *)
fun setDeskState (dsk, newState) =
  makeDesk ( getDeskPlayers dsk
           , getDeskPile dsk
           , getDeskDeck dsk
           , newState
           )

(* Функция - фальшивая стратегия игрока: какой бы не был ход, всегда 
 * выкладывается первая карта из списка карт игрока и заказывается 
 * зеленый цвет.
 * Это вспомогательная функция для отладки и тестирования *)
fun falseStrategy (_ : move, (c :: _) : card list, _ : card, _ : int list) = 
      (c, GREEN)
  | falseStrategy _ = raise IllegalGame
(******************************************************************************
 ******************************************************************************)

(* Задание 1. getNth *)
fun getNth ([], n) = raise List.Empty
  | getNth (firstn :: lst, 0) = firstn
  | getNth (firstn :: lst, n) = getNth (lst, n - 1)
(* Задание 2. reverseAppend *)
fun reverseAppend ([], lst2) = lst2
  | reverseAppend (head :: lst1, lst2) = reverseAppend (lst1, head :: lst2)
(* Задание 3. cardValue *)
fun cardValue (BLACK, _) = 50
  | cardValue (_, NUM value) = value
  | cardValue (_, _) = 20
(* Задание 4. cardCount *)
fun cardCount (BLACK, _) = 4
  | cardCount (_, NUM 0) = 1
  | cardCount (_, _) = 2

(* Задание 5. rankColors *)
fun rankColors WILD_DRAW_FOUR = [BLACK]
  | rankColors WILD = [BLACK]
  | rankColors _ = [RED, GREEN, BLUE, YELLOW]
(* Задание 6. sumCards *)
fun sumCards lst =
  let
    fun recursion ([], acc) = acc
      | recursion (card :: tail, acc) = recursion (tail, acc + cardValue card)
  in
    recursion (lst, 0)
  end
(* Задание 7. removeNth *)
fun removeNth (lst, n) =
  let
    fun recursion (newl, [], i) = raise List.Empty
      | recursion (newl, head :: oldl, 0) = reverseAppend (newl, oldl)
      | recursion (newl, head :: oldl, i) = 
          recursion (head :: newl, oldl, i - 1)
  in
    recursion ([], lst, n)
  end
(* Задание 8. removeCard *)
fun removeCard (lst, c, e) =
  let
    fun recursion (newl, []) = raise e
      | recursion (newl, head :: oldl) = 
          case isSameCard (head, c)
            of true => reverseAppend (newl, oldl)
            |  false => recursion (head :: newl, oldl);
  in
    recursion ([], lst)
  end
(* Задание 9. insertElem *)
fun insertElem (cs, c, n) =
  let
    fun recursion (newl, oldl, 0) = reverseAppend (c :: newl, oldl)
      | recursion (newl, [], _) = raise List.Empty
      | recursion (newl, head :: oldl, i) = 
          recursion (head :: newl, oldl, i - 1)
  in
    recursion ([], cs, n)
  end

(* Задание 10. interchange *)
fun interchange (cs, i, j) =
  if i < j then
    removeNth (removeNth (insertElem (insertElem 
              (cs, getNth (cs, i), j), getNth (cs, j), i), i + 1), j + 1)
  else
    removeNth (removeNth (insertElem (insertElem 
              (cs, getNth (cs, j), i), getNth (cs, i), j), j + 1), i + 1)
(* Задание 11. shuffleList *)
fun shuffleList lst =
  let
    fun getN ([], acc) = acc
      | getN (head :: lst, acc) = getN (lst, acc + 1)
    val nminus1 = getN (lst, 0) - 1
    val some_num = seed ()
    val rnd = Random.rand (some_num, some_num mod 67)
    fun recursion (lst, i) = case i = nminus1 
      of true => lst
      |  false => recursion (interchange 
                            (lst, i, Random.randRange (i, nminus1) rnd), i + 1) 
  in
    recursion (lst, 0)
  end

(* Задание 12. allRankColors *)
fun allRankColors r =
  map (fn x => (x, r)) (rankColors r)
(* Задание 13. copyCardNTimes *)
fun copyCardNTimes c =
  let
    fun nTimes (lst, 0) = lst
      | nTimes (lst, i) = nTimes (c :: lst, i - 1)
  in
    nTimes ([], cardCount c)
  end
(* Задание 14. deck *)
val deck = foldr (op @) [] (map (copyCardNTimes)
           (foldr (op @) [] (map allRankColors ranks)))
(* Задание 15. getSameRank *)
fun getSameRank (r, cs) =
  List.filter (fn (clr, thisrank) => isSameRank (thisrank, r)) cs
(* Задание 16. getSameColor *)
fun getSameColor (col, cs) =
  List.filter (fn (clr, thisrank) => isSameColor (clr, col)) cs
(* Задание 17. hasRank *)
fun hasRank (r, cs) =
  isSome (List.find (fn (clr, thisrank) => isSameRank (thisrank, r)) cs)
(* Задание 18. hasColor *)
fun hasColor (col, cs) =
  isSome (List.find (fn (clr, thisrank) => isSameColor (clr, col)) cs)
(* Задание 19. hasCard *)
fun hasCard (c, cs) =
  isSome (List.find (fn thiscard => isSameCard (thiscard, c)) cs)
(* Задание 20. countColor *)
fun countColor (col, cs) = length (getSameColor (col, cs))
(* Задание 21. maxColor *)
fun maxColor cs = 
  let
    fun makePairs clr = 
      map (fn x => (x, countColor (x, cs))) clr
    fun diffPairs ((c1, n1), (c2, n2)) = case n1 > n2
     of true => (c1, n1)
     |  false => (c2, n2)
    fun findGreatest [] = raise List.Empty
      | findGreatest (head :: tail) = foldl diffPairs head tail
    fun getClr (clr, n) = clr
  in
    getClr (findGreatest (makePairs [RED, GREEN, BLUE, YELLOW]))
  end
(* Задание 22. deal *)
fun deal lst =
  let
    fun giveCards ([], res, curdeck) = (res, curdeck)
      | giveCards ((n, str) :: lst, res, cards) =
          giveCards (lst, makePlayer 
                    (n, List.take (cards, 7), str) :: res
                    , List.drop (cards, 7))
    val (people, head :: curdeck) = giveCards (lst, [], shuffleList deck)
  in
    makeDesk (reverseAppend (people, []), [head], curdeck, PROCEED)
  end
(* Задание 23. getPlayersFirst *)
fun getPlayersFirst dsk = 
  let val first :: pls = getDeskPlayers dsk in first end
(* Задание 24. getPileTop *)
fun getPileTop dsk = let val first :: pile = getDeskPile dsk in first end
(* Задание 25. nextPlayer *)
fun nextPlayer dsk =
  let
    val head :: ppl = getDeskPlayers dsk
  in
    setDeskPlayers (dsk, ppl @ [head])
  end
(* Задание 26. changeDirection *)
fun changeDirection dsk =
  let
    val head :: ppl = getDeskPlayers dsk
  in
    setDeskPlayers (dsk, [head] @ reverseAppend (ppl, [])) 
  end
(* Задание 27. start *)
fun start dsk =
  let
    val c = getPileTop dsk
    fun checkCard c = case c
      of (BLACK, _) => 
        let
          val (head :: thisdeck) = shuffleList (c :: (getDeskDeck dsk))
          val dsk = makeDesk (getDeskPlayers dsk, [head], thisdeck, PROCEED)
        in
          checkCard head
        end
      |  (_, REVERSE) => changeDirection dsk
      |  _ => nextPlayer dsk
    fun isActiveCard c = case c
      of (_, DRAW_TWO) => setDeskState (dsk, EXECUTE)
      |  (_, SKIP) => setDeskState (dsk, EXECUTE)
      |  _ => setDeskState (dsk, PROCEED)
    val dsk = isActiveCard c
  in
    checkCard c
  end 
(* Задание 28. take_1 *)
fun take_1 dsk = 
  let
    val first :: thisPile = getDeskPile dsk
    val dsk = case (getDeskDeck dsk)
      of [] => makeDesk ( getDeskPlayers dsk
                        , [first], shuffleList thisPile, getDeskState dsk )
      |  _ => dsk
    val upper :: thisDeck = getDeskDeck dsk
    val playerToDraw :: currPlayers = getDeskPlayers dsk
    val playerToDraw = setPlayerCards ( playerToDraw
                                      , upper :: (getPlayerCards playerToDraw) )
  in
    makeDesk ( playerToDraw :: currPlayers, getDeskPile dsk
             , thisDeck, getDeskState dsk )
  end
(* Задание 29. take_2 *)
fun take_2 dsk = (take_1 o take_1) dsk
(* Задание 30. take_4 *)
fun take_4 dsk = (take_2 o take_2) dsk
(* Задание 31. pass *)
fun pass dsk =
  case (getPileTop dsk, getDeskState dsk) 
    of ((_, SKIP), EXECUTE) => nextPlayer (setDeskState (dsk, PROCEED))
     | ((_, SKIP), _) => nextPlayer dsk
     | ((_, DRAW_TWO), EXECUTE) => nextPlayer (setDeskState 
                                              ((take_2 dsk), PROCEED))
     | ((_, DRAW_TWO), _) => nextPlayer dsk
     |  (_, _) => nextPlayer dsk
(* Задание 32. requiredColor *)
fun requiredColor dsk = 
  case getDeskState dsk
    of GIVE col => col
    |  _ => let val (clr, rk) = getPileTop dsk in clr end
(* Задание 33. playableCards *)
fun playableCards dsk =
  case getDeskState dsk
    of GIVE col => List.filter (fn (xClr, xRk) => (isSameColor (xClr, col)) 
                     orelse (isSameRank (xRk, (WILD_DRAW_FOUR)))
                     orelse (isSameRank (xRk, (WILD))))
                     (getPlayerCards (getPlayersFirst dsk))
    |  EXECUTE => let val (yClr, yRk) = getPileTop dsk 
                  in 
                    List.filter (fn (xClr, xRk) => 
                    isSameRank (xRk, yRk))
                    (getPlayerCards (getPlayersFirst dsk)) 
                  end
    |  PROCEED => 
         let
           val (yClr, yRk) = getPileTop dsk
         in
           List.filter (fn (xClr, xRk) => isSameColor (xClr, yClr) 
           orelse isSameRank (xRk, yRk)
           orelse isSameRank (xRk, WILD_DRAW_FOUR) 
           orelse isSameRank (xRk, WILD)) (getPlayerCards (getPlayersFirst dsk))
         end 
(* Задание 34. countCards *)
fun countCards dsk = 
  let
    fun recursion (person :: ps, res) 
        = recursion (ps, ((length o getPlayerCards) person) :: res)
      | recursion ([], res) = reverseAppend (res, [])
  in
    recursion (getDeskPlayers dsk, [])
  end
(* Задание 35. hasNoCards *)
fun hasNoCards this = (null o getPlayerCards) this
(* Задание 36. countLoss *)
fun countLoss players =
  let
    fun getLoss ps =
      (getPlayerName ps, sumCards (getPlayerCards ps))
  in
    map (fn x => getLoss x) players
  end
(* Задание 37. naiveStrategy *)
fun naiveStrategy (st, hand, (clrP, rkP), number) =
  let
    val dominantColor = maxColor hand
    val hasWild = hasCard ((BLACK, WILD), hand)
    val hasWildDraw = hasCard ((BLACK, WILD_DRAW_FOUR), hand)
    fun findGreatest ([], biggest, bcard) = (bcard, clrP)
      | findGreatest (c :: cs, biggest, bcard) = 
          let val amount = cardValue c 
          in 
            if amount >= biggest 
            then findGreatest (cs, amount, c) 
            else findGreatest (cs, biggest, bcard)
          end
    fun actionGiveCol col = 
      let
        val sameColor = getSameColor (col, hand)
        val numberOfSame = length sameColor
      in
        if hasWild andalso numberOfSame < (countColor (dominantColor, hand)) 
        then ((BLACK, WILD), dominantColor)
        else if (length sameColor) = 0 
             then if hasWildDraw then ((BLACK, WILD_DRAW_FOUR), dominantColor)
                                 else ((BLACK, WILD), dominantColor)
             else let
                    val (first :: sameColor) = sameColor
                  in
                    findGreatest ((first :: sameColor), 0, first)
                  end 
      end

    fun actionExecute () = 
      let 
        val (frk :: sameRankCs) = getSameRank (rkP, hand)
      in (frk, clrP) end

    fun actionProceed () = 
      let
        val sameColorCs = getSameColor (clrP, hand)
        val sameRankCs = getSameRank (rkP, hand)
      in
        if null sameColorCs  andalso null sameRankCs
      then if hasWildDraw then ((BLACK, WILD_DRAW_FOUR), dominantColor) 
           else ((BLACK, WILD), dominantColor) 
      else 
        findGreatest ( (sameRankCs @ sameColorCs)
                      , 0, (clrP, NUM (0)) )
      end
  in
    case st
      of GIVE col => actionGiveCol col
      |  EXECUTE => actionExecute ()
      |  PROCEED => actionProceed ()
  end

(* Задание 38. play *)
fun play (desk, playCards) =
  let
    val p1 :: ps = getDeskPlayers desk
    val pl = getDeskPile desk
    val dk = getDeskDeck desk
    val st = getDeskState desk 

    val firstPlayer = getPlayersFirst desk
    val name = getPlayerName firstPlayer
    val strat = getPlayerStrategy firstPlayer
    val hand = getPlayerCards firstPlayer
    val (useStrategy, sClr) = strat (st, hand, getPileTop desk, countCards desk)
    val _ = removeCard ( playCards, useStrategy
                          , IllegalMove name )
    val hand = removeCard (hand, useStrategy, IllegalMove name)
    val desk = makeDesk ( (setPlayerCards (firstPlayer, hand)) :: ps
                         , useStrategy :: pl, dk, st)
    val requiredClr = requiredColor desk
  in
    case (useStrategy, sClr)
      of ((BLACK, WILD_DRAW_FOUR), clr) => 
           if hasColor (requiredClr, getSameColor (requiredClr, hand))
           then nextPlayer (setDeskState (take_4 desk, GIVE clr))
           else nextPlayer (setDeskState  
                           (take_4 (nextPlayer desk), GIVE clr))
      |  ((BLACK, WILD), clr) => nextPlayer 
                                (setDeskState (desk, GIVE clr))
      |  ((_, NUM (n)), _) => nextPlayer (setDeskState (desk, PROCEED))
      |  ((_, REVERSE), _) => 
           nextPlayer (changeDirection (setDeskState (desk, PROCEED)))
      |  _ => nextPlayer (setDeskState (desk, EXECUTE))
  end

(* Задание 39. gameStep *)
fun gameStep desk = 
  let
    val playable = playableCards desk
  in
    if null playable 
    then
      case getDeskState desk
        of EXECUTE => pass desk
        |  _ => let val playable = playableCards desk
                in
                  if null playable 
                  then pass desk
                  else play (desk, playable)
                end
    else play (desk, playable)
  end
(* Задание 40. game *)
fun game desk =
  let
    val desk = start desk
    fun iter players = case (List.find hasNoCards players)
      of NONE => iter (getDeskPlayers (gameStep desk))
      |  SOME winner => (getPlayerName winner, countLoss players)
  in
    iter (getDeskPlayers desk)
  end 