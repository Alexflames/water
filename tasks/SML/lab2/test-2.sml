(* Задание 1. getNth *)
val testGetNth1 = getNth ([0, 1, 2, 3, 4], 2) = 2
val testGetNth2 = getNth (["0", "1", "2", "3", "4"], 2) = "2"
val testGetNth3 = getNth ([0, 1, 2, 3, 4], 5) = 5
                        handle List.Empty => true
val testGetNth4 = getNth ([],2) = 0
                        handle List.Empty => true
val testGetNth5 = getNth ([1,3], ~2) = 3
                        handle List.Empty => true
val testGetNth6 = getNth ([8, 3, 9, 2, 5, 4, 6, 11, 19], 5) = 4
val testGetNthMy = getNth ([0, 1, 2, 3, 4], 0) = 0

(* Задание 2. REVERSEAppend *)
val testReverseAppend1 = reverseAppend ([0, 1, 2, 3], [4, 5, 6]) 
                            = [3, 2, 1, 0, 4, 5, 6]
val testReverseAppend2 = reverseAppend ([], [4, 5, 6]) 
                            = [4, 5, 6]
val testReverseAppend3 = reverseAppend ([], []) 
                            = []
val testReverseAppend4 = reverseAppend ([1], [2]) 
                            = [1, 2]
val testReverseAppend5 = reverseAppend ([8, 17, 0, 3, 9], [2, 5, 7]) 
                            = [9, 3, 0, 17, 8, 2, 5, 7]
val testReverseAppendMy = reverseAppend ([50, 0], [50]) 
                            = [0, 50, 50]

(* Задание 3. cardValue *)
val testCardValue1 = cardValue (RED, NUM 9) = 9
val testCardValue2 = cardValue (BLACK, WILD) = 50
val testCardValue3 = cardValue (GREEN, REVERSE) = 20
val testCardValue4 = cardValue (BLACK, WILD_DRAW_FOUR) = 50
val testCardValue5 = cardValue (GREEN, NUM 0) = 0
val testCardValue6 = cardValue (BLUE, NUM 5) = 5
val testCardValue7 = cardValue (YELLOW, NUM 7) = 7
val testCardValue8 = cardValue (RED, NUM 8) = 8
val testCardValueMy = cardValue (YELLOW, DRAW_TWO) = 20

(* Задание 4. cardCount *)
val testCardCount1 = cardCount (RED, NUM 0) = 1
val testCardCount2 = cardCount (RED, NUM 3) = 2
val testCardCount3 = cardCount (BLACK, WILD) = 4
val testCardCount4 = cardCount (YELLOW, SKIP) = 2
val testCardCount5 = cardCount (GREEN, DRAW_TWO) = 2
val testCardCountMy = cardCount (BLACK, WILD_DRAW_FOUR) = 4

(* Задание 5. rankColors *)
val testRankColors1 = rankColors WILD = [BLACK]
val testRankColors2 = rankColors (WILD_DRAW_FOUR) = [BLACK]
val testRankColors3 = rankColors (NUM 0) = [RED, GREEN, BLUE, YELLOW]
val testRankColors4 = rankColors (SKIP) = [RED, GREEN, BLUE, YELLOW]
val testRankColorsMy = rankColors (REVERSE) = [RED, GREEN, BLUE, YELLOW]

(* Задание 6. sumCards *)
val testSumCards1 = sumCards [(BLACK, WILD), (RED, NUM 0)] = 50
val testSumCards2 = sumCards [] = 0
val testSumCards3 = sumCards [(BLUE, NUM 5), (YELLOW, NUM 7)] = 12
val testSumCards4 = sumCards [(BLACK, WILD_DRAW_FOUR), (GREEN, SKIP)] = 70
val testSumCardsMy = sumCards [ (BLACK, WILD_DRAW_FOUR), (GREEN, SKIP)
                              , (RED, DRAW_TWO) ] = 90

(* Задание 7. removeNth *)
val testRemoveNth1 = removeNth ([0, 1, 2, 3, 4], 2) = [0, 1, 3, 4]
val testRemoveNth2 = removeNth (["0", "1", "2", "3", "4"], 2) 
                     = ["0", "1", "3", "4"]
val testRemoveNth3 = removeNth ([0, 1, 2, 3, 4], 5) = []
                          handle List.Empty => true
val testRemoveNth4 = removeNth ([0, 1, 2, 3, 4], 0) = [1, 2, 3, 4]
val testRemoveNth5 = removeNth ([0, 1, 2, 3, 4], 4) = [0, 1, 2, 3]
val testRemoveNth6 = removeNth ([0, 1, 2, 3, 4], ~4) = [0, 1, 3]
                          handle List.Empty => true 
val testRemoveNth7 = removeNth ([], 4) = []
                          handle List.Empty => true
val testRemoveNthMy = removeNth ([1], 0) = []

(* Задание 8. removeCard *)
val testRemoveCard1 = removeCard ([], (BLUE, NUM 2), List.Empty) = []
                            handle List.Empty => true
val testRemoveCard2 = 
    removeCard ([(BLUE, NUM 2)], (BLUE, NUM 2), List.Empty) = []
val testRemoveCard3 = 
    removeCard ( [ (BLACK, WILD)
                 , (RED, REVERSE)
                 , (YELLOW, NUM 3) ]
               , (RED, REVERSE)
               , List.Empty ) = [(BLACK, WILD), (YELLOW, NUM 3)]
val testRemoveCardMy = 
    removeCard ( [(BLACK, WILD), (BLACK, WILD)]
               , (BLACK, WILD)
               , List.Empty ) = [(BLACK, WILD)]

(* Задание 9. insertElem *)
val testInsertElem1 = insertElem ([], 2, 0) = [2]
val testInsertElem2 = insertElem ([], 2, 1) = [2]
                            handle List.Empty => true
val testInsertElem3 = insertElem ([1, 3, 4], 2, 1) = [1, 2, 3, 4]
val testInsertElemMy = insertElem ([1, 2, 3], 0, 0) = [0, 1, 2, 3]

(* Задание 10. interchange *)
val testInterchange1 = interchange ([0, 1, 2, 3], 1, 3) = [0, 3, 2, 1]
val testInterchange2 = interchange ([0, 1, 2, 3], 3, 1) = [0, 3, 2, 1]
val testInterchange3 = interchange ([0, 1, 2, 3], ~3, 3) = []
                              handle List.Empty => true
val testInterchange4 = interchange ([0, 1, 2, 3], 1, 5) =[0, 1, 2, 3]
                              handle List.Empty => true
val testInterchange5 = interchange ([12, 5, 9, 6], 0, 3) = [6, 5, 9, 12]
val testInterchangeMy = interchange ([12, 5, 9, 6], 1, 1) = [12, 5, 9, 6]

(* Задание 11. shuffleList *)
(* ТЕСТЫ НЕ ТРЕБУЮТСЯ *)

(* Задание 12. allRankColors *)
val testAllRankColors1 = allRankColors WILD = [(BLACK, WILD)]
val testAllRankColors2 = allRankColors (NUM 0) =
  [(RED, NUM 0), (GREEN, NUM 0), (BLUE, NUM 0), (YELLOW, NUM 0)]
val testAllRankColors3 = allRankColors SKIP =
  [(RED, SKIP), (GREEN, SKIP), (BLUE, SKIP), (YELLOW, SKIP)]
val testAllRankColorsMy = allRankColors WILD_DRAW_FOUR =
  [(BLACK, WILD_DRAW_FOUR)]

(* Задание 13. copyCardNTimes *)
val testCopyCardNTimes1 = 
      copyCardNTimes (RED, NUM 0) = [(RED, NUM 0)]
val testCopyCardNTimes2 = 
      copyCardNTimes (BLACK, WILD) =
        [(BLACK, WILD), (BLACK, WILD), (BLACK, WILD), (BLACK, WILD)]
val testCopyCardNTimes3 = 
      copyCardNTimes (YELLOW, REVERSE) = [(YELLOW, REVERSE), (YELLOW, REVERSE)]
val testCopyCardNTimes4 = 
      copyCardNTimes (BLUE, NUM 8) = [(BLUE, NUM 8), (BLUE, NUM 8)]
val testCopyCardNTimesMy = 
      copyCardNTimes (BLUE, SKIP) = [(BLUE, SKIP), (BLUE, SKIP)]

(* Задание 14. deck *)
val testDeck =
  deck = [ (RED,NUM 0),(GREEN,NUM 0),(BLUE,NUM 0),(YELLOW,NUM 0)
          ,(RED,NUM 1),(RED,NUM 1),(GREEN,NUM 1),(GREEN,NUM 1)
          ,(BLUE,NUM 1),(BLUE,NUM 1),(YELLOW,NUM 1),(YELLOW,NUM 1)
          ,(RED,NUM 2),(RED,NUM 2),(GREEN,NUM 2),(GREEN,NUM 2)
          ,(BLUE,NUM 2),(BLUE,NUM 2),(YELLOW,NUM 2),(YELLOW,NUM 2)
          ,(RED,NUM 3),(RED,NUM 3),(GREEN,NUM 3),(GREEN,NUM 3)
          ,(BLUE,NUM 3),(BLUE,NUM 3),(YELLOW,NUM 3),(YELLOW,NUM 3)
          ,(RED,NUM 4),(RED,NUM 4),(GREEN,NUM 4),(GREEN,NUM 4)
          ,(BLUE,NUM 4),(BLUE,NUM 4),(YELLOW,NUM 4),(YELLOW,NUM 4)
          ,(RED,NUM 5),(RED,NUM 5),(GREEN,NUM 5),(GREEN,NUM 5)
          ,(BLUE,NUM 5),(BLUE,NUM 5),(YELLOW,NUM 5),(YELLOW,NUM 5)
          ,(RED,NUM 6),(RED,NUM 6),(GREEN,NUM 6),(GREEN,NUM 6)
          ,(BLUE,NUM 6),(BLUE,NUM 6),(YELLOW,NUM 6),(YELLOW, NUM 6)
          ,(RED,NUM 7),(RED,NUM 7),(GREEN,NUM 7),(GREEN,NUM 7)
          ,(BLUE,NUM 7),(BLUE,NUM 7),(YELLOW,NUM 7),(YELLOW,NUM 7)
          ,(RED,NUM 8),(RED,NUM 8),(GREEN,NUM 8),(GREEN,NUM 8)
          ,(BLUE,NUM 8),(BLUE,NUM 8),(YELLOW,NUM 8),(YELLOW,NUM 8)
          ,(RED,NUM 9),(RED,NUM 9),(GREEN,NUM 9),(GREEN,NUM 9)
          ,(BLUE,NUM 9),(BLUE,NUM 9),(YELLOW,NUM 9),(YELLOW,NUM 9)
          ,(RED,SKIP),(RED,SKIP),(GREEN,SKIP),(GREEN,SKIP)
          ,(BLUE,SKIP),(BLUE,SKIP),(YELLOW,SKIP),(YELLOW,SKIP)
          ,(RED,DRAW_TWO),(RED,DRAW_TWO),(GREEN,DRAW_TWO),(GREEN,DRAW_TWO)
          ,(BLUE,DRAW_TWO),(BLUE,DRAW_TWO),(YELLOW,DRAW_TWO),(YELLOW,DRAW_TWO)
          ,(RED,REVERSE),(RED,REVERSE),(GREEN,REVERSE),(GREEN,REVERSE)
          ,(BLUE,REVERSE),(BLUE,REVERSE),(YELLOW,REVERSE),(YELLOW,REVERSE)
          ,(BLACK,WILD),(BLACK,WILD),(BLACK,WILD),(BLACK,WILD)
          ,(BLACK,WILD_DRAW_FOUR),(BLACK,WILD_DRAW_FOUR)
          ,(BLACK,WILD_DRAW_FOUR),(BLACK,WILD_DRAW_FOUR) ]

(* Задание 15. getSameRank *)
val testGetSameRank1 = 
      getSameRank (WILD, [(BLACK, WILD), (GREEN, NUM 0)]) = [(BLACK, WILD)]
val testGetSameRank2 = 
      getSameRank (NUM 0, [(BLACK, WILD), (GREEN, NUM 0), 
                           (YELLOW, NUM 0), (GREEN, NUM 1)]) 
                        = [(GREEN, NUM 0), (YELLOW, NUM 0)]
val testGetSameRank3 = 
      getSameRank (DRAW_TWO, [(BLACK, WILD), (RED, REVERSE), 
                              (YELLOW, NUM 0), (BLUE, DRAW_TWO),
                              (RED, DRAW_TWO), (BLACK, WILD_DRAW_FOUR)]) 
                           = [(BLUE, DRAW_TWO), (RED, DRAW_TWO)]
val testGetSameRank4 = 
      getSameRank (NUM 5, [(RED, SKIP), (YELLOW, REVERSE), 
                           (BLUE, NUM 0), (GREEN, DRAW_TWO),
                           (YELLOW, NUM 7), (BLACK, WILD)]) = []
val testGetSameRankMy = 
      getSameRank (SKIP, [(RED, SKIP), (YELLOW, REVERSE), 
                           (BLUE, NUM 0), (GREEN, DRAW_TWO),
                           (YELLOW, NUM 7), (BLACK, WILD)]) = [(RED, SKIP)]

(* Задание 16. getSameColor *)
val testGetSameColor1 = 
      getSameColor (BLACK, [(BLACK, WILD), (GREEN, NUM 0)]) = [(BLACK, WILD)]
val testGetSameColor2 = 
      getSameColor (GREEN, [(BLACK, WILD), (GREEN, NUM 0), 
                            (YELLOW, NUM 0), (GREEN, NUM 1)]) 
                         = [(GREEN, NUM 0), (GREEN, NUM 1)]
val testGetSameColor3 = 
      getSameColor (YELLOW, [(BLACK, WILD), (BLUE, NUM 0), 
                             (RED, NUM 0), (GREEN, NUM 1)]) = []

(* Задание 17. hasRank *)
val testHasRank1 = 
      hasRank (WILD, [(BLACK, WILD), (GREEN, NUM 0)]) = true
val testHasRank2 = 
      hasRank (NUM 5, [(BLACK, WILD), (GREEN, NUM 0)]) = false
val testHasRank3 = 
      hasRank (SKIP, []) = false
val testHasRank4 = 
      hasRank (REVERSE, [(YELLOW, REVERSE), (BLACK, WILD)]) = true
val testHasRankMy = 
      hasRank (WILD, [(YELLOW, REVERSE), (BLACK, WILD_DRAW_FOUR)]) = false

(* Задание 18. hasColor *)
val testHasColor1 = 
      hasColor (BLACK, [(BLACK, WILD), (GREEN, NUM 0)]) = true
val testHasColor2 = 
      hasColor (RED, [(BLACK, WILD), (GREEN, NUM 0)]) = false
val testHasColor3 = 
      hasColor (YELLOW, []) = false
val testHasColor4 = 
      hasColor (GREEN, [(YELLOW, REVERSE), (GREEN, NUM 8)]) = true
val testHasColorMy = 
      hasColor (BLACK, [(YELLOW, REVERSE), (GREEN, NUM 8)]) = false

(* Задание 19. hasCard *)
val testHasCard1 = 
      hasCard ((BLACK, WILD), [(BLACK, WILD), (GREEN, NUM 0)]) = true
val testHasCard2 = 
      hasCard ((RED, NUM 5), [(BLACK, WILD), (GREEN, NUM 0)]) = false
val testHasCard3 = 
      hasCard ((BLUE, DRAW_TWO), []) = false
val testHasCard4 = 
      hasCard ((YELLOW, SKIP), [(YELLOW, SKIP), (BLUE, REVERSE)]) = true
val testHasCardMy1 = 
      hasCard ((GREEN, SKIP), [(YELLOW, SKIP), (BLUE, REVERSE)]) = false
val testHasCardMy2 = 
      hasCard ((YELLOW, DRAW_TWO), [(YELLOW, SKIP), (BLUE, REVERSE)]) = false

(* Задание 20. countColor *)
val testCountColor1 = 
      countColor (BLACK, [(RED, NUM 5), (BLACK, WILD), (GREEN, NUM 0)]) = 1
val testCountColor2 = 
      countColor (GREEN, []) = 0
val testCountColor3 = 
      countColor (RED, [(RED, NUM 5), (BLACK, WILD), (RED, NUM 0)]) = 2

(* Задание 21. maxColor *)
val testMaxColor1 = 
      maxColor [(GREEN, NUM 5), (BLACK, WILD), (GREEN, NUM 0)] = GREEN
val testMaxColor2 = 
      maxColor [(BLACK, WILD_DRAW_FOUR), (BLACK, WILD), (RED, SKIP)] = RED
val testMaxColor3 = 
      maxColor [(GREEN, REVERSE), (BLUE, SKIP), (YELLOW, NUM 7)] = GREEN

(* Задание 22. deal *)
(* ТЕСТЫ НЕ ТРЕБУЮТСЯ *)

(* Вспомогательная функция для сравнения двух игроков 
 * в элементе типа player присутствует функция, а функции 
 * на равенство не сравниваются, поэтому сравнивать на равенство 
 * двух игроков напрямую нельзя,
 * нужно сравнивать только сравнимые элементы *)
fun isSamePlayer ( { name = n1, cards = cs1, ...} : player
                 , { name = n2, cards = cs2, ...} : player ) =
      n1 = n2 andalso cs1 = cs2

(* Вспомогательная функция для тестирования
 * выдает true, когда элемент a присутствует в списке l 
 * иначе выдает false *)
fun member (_, []) = false
  | member (a, c :: cs) = (a = c) orelse member (a, cs)


(* Задание 23. getPlayersFirst *)
val testGetPlayersFirst1 = 
  let 
    val tmp = getPlayersFirst { players = [ { name = "Anton"
                                            , cards = []
                                            , strat = falseStrategy 
                                            }
                                          , { name = "Andrew"
                                            , cards = []
                                            , strat = falseStrategy 
                                            }
                                          ]
                              , pile = []
                              , deck = []
                              , state = PROCEED
                              }
  in
    isSamePlayer (tmp, {name = "Anton", cards = [], strat = falseStrategy})
  end
val testGetPlayersFirst2 = 
  let 
    val tmp = getPlayersFirst { players = [ { name = "Anna"
                                            , cards = [ (BLACK, WILD)
                                                      , (YELLOW, NUM 3) ]
                                            , strat = falseStrategy 
                                            }
                                          , { name = "Katerina"
                                            , cards = [ (BLUE, SKIP)
                                                      , (BLACK, WILD) ]
                                            , strat = falseStrategy 
                                            }
                                          ]
                              , pile = []
                              , deck = []
                              , state = PROCEED
                              }
  in
    isSamePlayer ( tmp, { name = "Anna"
                        , cards = [(BLACK, WILD), (YELLOW, NUM 3)]
                        , strat = falseStrategy } )
  end
val testGetPlayersFirstMy = 
  let 
    val tmp = getPlayersFirst { players = [ { name = "Loneboy"
                                            , cards = [ (BLACK, WILD)
                                                      , (YELLOW, NUM 3) ]
                                            , strat = falseStrategy 
                                            }
                                          ]
                              , pile = []
                              , deck = []
                              , state = PROCEED
                              }
  in
    isSamePlayer ( tmp, { name = "Loneboy"
                        , cards = [(BLACK, WILD), (YELLOW, NUM 3)]
                        , strat = falseStrategy } )
  end

(* Задание 24. getPileTop *)
val testGetPileTop1 = 
      getPileTop { players = []
                 , pile = [(BLACK, WILD), (RED, NUM 0)]
                 , deck = []
                 , state = PROCEED
                 }
      = (BLACK, WILD)
val testGetPileTop2 = 
      getPileTop { players = []
                 , pile = [(GREEN, NUM 8), (YELLOW, SKIP)]
                 , deck = []
                 , state = PROCEED
                 }
      = (GREEN, NUM 8)
val testGetPileTop3 = 
      getPileTop { players = [ { name = "Alexey"
                               , cards = []
                               , strat = falseStrategy 
                               }
                             ]
                 , pile = [(BLUE, DRAW_TWO), (BLACK, WILD_DRAW_FOUR)]
                 , deck = []
                 , state = EXECUTE
                 }
      = (BLUE, DRAW_TWO)
val testGetPileTopMy = 
      getPileTop { players = [ { name = "Ryan"
                               , cards = [(BLUE, SKIP)]
                               , strat = falseStrategy 
                               }
                             ]
                 , pile = [(BLUE, DRAW_TWO), (BLACK, WILD_DRAW_FOUR)]
                 , deck = []
                 , state = EXECUTE
                 }
      = (BLUE, DRAW_TWO)

(* Задание 25. nextPlayer *)
val testNextPlayer1 = 
  let 
    val tmp = nextPlayer { players = [ { name = "Anton"
                                       , cards = []
                                       , strat = falseStrategy 
                                       }
                                     , { name = "Andrew"
                                       , cards = []
                                       , strat = falseStrategy 
                                       }
                                     ]
                         , pile = []
                         , deck = []
                         , state = PROCEED
                         }
    val tmp1 = getPlayersFirst tmp
  in
    isSamePlayer (tmp1, {name = "Andrew", cards = [], strat = falseStrategy})
  end
val testNextPlayer2 = 
  let 
    val tmp = nextPlayer { players = [ { name = "Anna"
                                       , cards = [ (BLACK, WILD)
                                                 , (YELLOW, NUM 3) ]
                                       , strat = falseStrategy 
                                       }
                                     , { name = "Katerina"
                                       , cards = [ (BLUE, SKIP)
                                                 , (BLACK, WILD) ]
                                       , strat = falseStrategy 
                                       }
                                     ]
                         , pile = []
                         , deck = []
                         , state = PROCEED
                         }
    val tmp1 = getPlayersFirst tmp
  in
    isSamePlayer ( tmp1, { name = "Katerina"
                         , cards = [(BLUE, SKIP), (BLACK, WILD)]
                         , strat = falseStrategy } )
  end

(* Задание 26. changeDirection *)
val testChangeDirection1 = 
  let 
    val tmp = changeDirection { players = [ { name = "Anton"
                                            , cards = []
                                            , strat = falseStrategy 
                                            }
                                          , { name = "Andrew"
                                            , cards = []
                                            , strat = falseStrategy 
                                            }
                                          , { name = "Alexey"
                                            , cards = []
                                            , strat = falseStrategy 
                                            }
                                          ]
                              , pile = []
                              , deck = []
                              , state = PROCEED
                              }
    val tmp1 = nextPlayer tmp
    val tmp1player = getPlayersFirst tmp1
    val tmp2 = nextPlayer tmp1
    val tmp2player = getPlayersFirst tmp2
  in
    isSamePlayer ( tmp1player
                 , {name = "Alexey", cards = [], strat = falseStrategy} )
    andalso
    isSamePlayer ( tmp2player
                 , {name = "Andrew", cards = [], strat = falseStrategy})
  end
val testChangeDirection2 = 
  let 
    val tmp = changeDirection { players = [ { name = "Katerina"
                                            , cards = [(BLACK, WILD)]
                                            , strat = falseStrategy 
                                            }
                                          , { name = "Anna"
                                            , cards = [(RED, SKIP)]
                                            , strat = falseStrategy 
                                            }
                                          , { name = "Anton"
                                            , cards = [(GREEN, REVERSE)]
                                            , strat = falseStrategy 
                                            }
                                          ]
                              , pile = [(YELLOW, DRAW_TWO)]
                              , deck = []
                              , state = EXECUTE
                              }
    val tmp1 = nextPlayer tmp
    val tmp1player = getPlayersFirst tmp1
    val tmp2 = nextPlayer tmp1
    val tmp2player = getPlayersFirst tmp2
  in
    isSamePlayer ( tmp1player
                 , {name = "Anton", cards = [(GREEN, REVERSE)], strat = falseStrategy} )
    andalso
    isSamePlayer ( tmp2player
                 , {name = "Anna", cards = [(RED, SKIP)], strat = falseStrategy})
  end
val testChangeDirection3 =
  let
    val tmp = changeDirection { players = [ { name = "Anton"
                                            , cards = []
                                            , strat = falseStrategy
                                            }
                                          , { name = "Andrew"
                                            , cards = []
                                            , strat = falseStrategy
                                            }
                                          , { name = "Alexey"
                                            , cards = []
                                            , strat = falseStrategy
                                            }
                                          , { name = "Maks"
                                            , cards = []
                                            , strat = falseStrategy
                                            }
                                          ]
                              , pile = []
                              , deck = []
                              , state = PROCEED
                              }
    val tmp0player = getPlayersFirst tmp
    val tmp1 = nextPlayer tmp
    val tmp1player = getPlayersFirst tmp1
    val tmp2 = nextPlayer tmp1
    val tmp2player = getPlayersFirst tmp2
  in
    isSamePlayer ( tmp0player
                 , {name = "Anton", cards = [], strat = falseStrategy} )
    andalso
    isSamePlayer ( tmp1player
                 , {name = "Maks", cards = [], strat = falseStrategy} )
    andalso
    isSamePlayer ( tmp2player
                 , {name = "Alexey", cards = [], strat = falseStrategy} )
  end

(* Задание 27. start *)
(* ДЛЯ СЛУЧАЯ, когда первая карта в колоде pile 
 * - черная карта, ТЕСТЫ НЕ ТРЕБУЮТСЯ *)
val testStart1 =
  let 
    val tmp = start { players = [ { name = "Anton"
                                  , cards = []
                                  , strat = falseStrategy 
                                  }
                                , { name = "Andrew"
                                  , cards = []
                                  , strat = falseStrategy 
                                  }
                                , { name = "Alexey"
                                  , cards = []
                                  , strat = falseStrategy 
                                  }
                                ]
                    , pile = [(RED, REVERSE)]
                    , deck = []
                    , state = PROCEED
                    }
    val tmp1 = nextPlayer tmp
    val tmp1player = getPlayersFirst tmp1
    val tmp2 = nextPlayer tmp1
    val tmp2player = getPlayersFirst tmp2
  in
    isSamePlayer ( tmp1player
                 , {name = "Alexey", cards = [], strat = falseStrategy} )
    andalso
    isSamePlayer ( tmp2player
                 , {name = "Andrew", cards = [], strat = falseStrategy})
  end
val testStart2 =
  let 
    val tmp = start { players = [ { name = "Katerina"
                                  , cards = []
                                  , strat = falseStrategy 
                                  }
                                , { name = "Maks"
                                  , cards = []
                                  , strat = falseStrategy 
                                  }
                                , { name = "Anna"
                                  , cards = []
                                  , strat = falseStrategy 
                                  }
                                , { name = "Alexey"
                                  , cards = []
                                  , strat = falseStrategy 
                                  }
                                ]
                    , pile = [(BLUE, SKIP)]
                    , deck = []
                    , state = EXECUTE
                    }
    val tmp1 = nextPlayer tmp
    val tmp1player = getPlayersFirst tmp1
    val tmp2 = nextPlayer tmp1
    val tmp2player = getPlayersFirst tmp2
  in
    isSamePlayer ( tmp1player
                 , {name = "Anna", cards = [], strat = falseStrategy} )
    andalso
    isSamePlayer ( tmp2player
                 , {name = "Alexey", cards = [], strat = falseStrategy})
  end 
val testStartMy =
  let 
    val tmp = start { players = [ { name = "Anton"
                                  , cards = []
                                  , strat = falseStrategy 
                                  }
                                , { name = "Andrew"
                                  , cards = []
                                  , strat = falseStrategy 
                                  }
                                , { name = "Hanzo"
                                  , cards = []
                                  , strat = falseStrategy 
                                  }
                                ]
                    , pile = [(BLACK, WILD)]
                    , deck = [(RED, NUM 0), (RED, NUM 0)]
                    , state = PROCEED
                    }
    val tmp1 = nextPlayer tmp
    val tmp1player = getPlayersFirst tmp1
    val tmp2 = nextPlayer tmp1
    val tmp2player = getPlayersFirst tmp2
  in
    isSamePlayer ( tmp1player
                 , {name = "Hanzo", cards = [], strat = falseStrategy} )
    andalso
    isSamePlayer ( tmp2player
                 , {name = "Anton", cards = [], strat = falseStrategy})
  end
(* Задание 28. take1 *)
val testTake11 =
  let 
    val tmp = take_1 { players = [ { name = "Anton"
                                   , cards = []
                                   , strat = falseStrategy 
                                   }
                                 , { name = "Andrew"
                                   , cards = []
                                   , strat = falseStrategy 
                                   }
                                 , { name = "Alexey"
                                   , cards = []
                                   , strat = falseStrategy 
                                   }
                                 ]
                     , pile = [(RED, REVERSE)]
                     , deck = [(BLACK, WILD)]
                     , state = PROCEED
                     }
    val tmpplayer = getPlayersFirst tmp
    val tmpdeck = getDeskDeck tmp
  in
    isSamePlayer ( tmpplayer
                 , { name = "Anton"
                   , cards = [(BLACK, WILD)]
                   , strat = falseStrategy } )
    andalso null tmpdeck
  end
val testTake12 =
  let 
    val tmp = take_1 { players = [ { name = "Anna"
                                   , cards = []
                                   , strat = falseStrategy 
                                   }
                                 , { name = "Katerina"
                                   , cards = []
                                   , strat = falseStrategy 
                                   }
                                 , { name = "Maks"
                                   , cards = []
                                   , strat = falseStrategy 
                                   }
                                 ]
                     , pile = [(RED, REVERSE), (BLUE, NUM 6)]
                     , deck = []
                     , state = PROCEED
                     }
    val tmpplayer = getPlayersFirst tmp
    val tmpdeck = getDeskDeck tmp
  in
    isSamePlayer ( tmpplayer
                 , { name = "Anna"
                   , cards = [(BLUE,NUM 6)]
                   , strat = falseStrategy } )
    andalso null tmpdeck
  end

(* Задание 29. take2 *)
val testTake21 =
  let 
    val tmp = take_2 { players = [ { name = "Anton"
                                   , cards = []
                                   , strat = falseStrategy 
                                   }
                                 , { name = "Andrew"
                                   , cards = []
                                   , strat = falseStrategy 
                                   }
                                 , { name = "Alexey"
                                   , cards = []
                                   , strat = falseStrategy 
                                   }
                                 ]
                     , pile = [(RED, REVERSE)]
                     , deck = [(BLACK, WILD), (RED, NUM 5), (GREEN, DRAW_TWO)]
                     , state = PROCEED
                     }
    val tmpplayer = getPlayersFirst tmp
    val tmpdeck = getDeskDeck tmp    
  in
    isSamePlayer ( tmpplayer
                  , { name = "Anton"
                    , cards = [(RED, NUM 5), (BLACK, WILD)]
                    , strat = falseStrategy } )
    andalso tmpdeck = [(GREEN, DRAW_TWO)]
  end
val testTake22 =
  let 
    val tmp = take_2 { players = [ { name = "Anna"
                                   , cards = []
                                   , strat = falseStrategy 
                                   }
                                 , { name = "Anton"
                                   , cards = []
                                   , strat = falseStrategy 
                                   }
                                 , { name = "Katerina"
                                   , cards = []
                                   , strat = falseStrategy 
                                   }
                                 ]
                     , pile = [(GREEN, SKIP)]
                     , deck = [(YELLOW, NUM 3), (BLACK, WILD), (RED, REVERSE)]
                     , state = EXECUTE
                     }
    val tmpplayer = getPlayersFirst tmp
    val tmpdeck = getDeskDeck tmp    
  in
    isSamePlayer ( tmpplayer
                  , { name = "Anna"
                    , cards = [(BLACK,WILD), (YELLOW,NUM 3)]
                    , strat = falseStrategy } )
    andalso tmpdeck = [(RED, REVERSE)]
  end

(* Задание 30. take4 *)
val testTake41 =
  let 
    val tmp = take_4 { players = [ { name = "Anton"
                                   , cards = []
                                   , strat = falseStrategy 
                                   }
                                 , { name = "Andrew"
                                   , cards = []
                                   , strat = falseStrategy 
                                   }
                                 , { name = "Alexey"
                                   , cards = []
                                   , strat = falseStrategy 
                                   }
                                 ]
                     , pile = [(RED, REVERSE)]
                     , deck = [ (BLACK, WILD), (RED, NUM 5), (GREEN, DRAW_TWO)
                              , (RED, NUM 7), (BLUE, SKIP) ]
                     , state = PROCEED
                     }
    val tmpplayer = getPlayersFirst tmp
    val tmpdeck = getDeskDeck tmp    
  in
    isSamePlayer ( tmpplayer
                 , { name = "Anton"
                   , cards = [ (RED, NUM 7), (GREEN, DRAW_TWO), (RED, NUM 5)
                             , (BLACK, WILD)]
                   , strat = falseStrategy } )
    andalso tmpdeck = [(BLUE, SKIP)]
  end
val testTake42 =
  let 
    val tmp = take_4 { players = [ { name = "Maks"
                                   , cards = []
                                   , strat = falseStrategy 
                                   }
                                 , { name = "Alexey"
                                   , cards = []
                                   , strat = falseStrategy 
                                   }
                                 , { name = "Victoria"
                                   , cards = []
                                   , strat = falseStrategy 
                                   }
                                 ]
                     , pile = [(YELLOW, DRAW_TWO)]
                     , deck = [ (BLUE, DRAW_TWO), (GREEN, NUM 8), (BLUE, SKIP)
                              , (RED, NUM 1), (BLACK, WILD_DRAW_FOUR) ]
                     , state = EXECUTE
                     }
    val tmpplayer = getPlayersFirst tmp
    val tmpdeck = getDeskDeck tmp  
  in
    isSamePlayer ( tmpplayer
                 , { name = "Maks"
                   , cards = [ (RED,NUM 1), (BLUE,SKIP), (GREEN,NUM 8)
                             , (BLUE, DRAW_TWO)]
                   , strat = falseStrategy } )
    andalso tmpdeck = [(BLACK, WILD_DRAW_FOUR)]
  end

(* Задание 31. pass *)
val testPass1 =
  let 
    val tmp = pass { players = [ { name = "Anton"
                                 , cards = []
                                 , strat = falseStrategy 
                                 }
                               , { name = "Andrew"
                                 , cards = []
                                 , strat = falseStrategy 
                                 }
                               , { name = "Alexey"
                                 , cards = []
                                 , strat = falseStrategy 
                                 }
                               ]
                   , pile = [(RED, REVERSE)]
                   , deck = []
                   , state = PROCEED
                   }
    val tmpplayer = getPlayersFirst tmp
    val tmp1 = nextPlayer tmp
    val tmp1player = getPlayersFirst tmp1
    val tmp2 = nextPlayer tmp1
    val tmp2player = getPlayersFirst tmp2
  in
    isSamePlayer ( tmpplayer
                 , {name = "Andrew", cards = [], strat = falseStrategy} )
    andalso
    isSamePlayer ( tmp1player
                 , {name = "Alexey", cards = [], strat = falseStrategy})
    andalso
    isSamePlayer ( tmp2player
                 , {name = "Anton", cards = [], strat = falseStrategy})    
  end
val testPass2 =
  let 
    val tmp = pass { players = [ { name = "Victoria"
                                 , cards = []
                                 , strat = falseStrategy 
                                 }
                               , { name = "Anton"
                                 , cards = []
                                 , strat = falseStrategy 
                                 }
                               , { name = "Maks"
                                 , cards = []
                                 , strat = falseStrategy 
                                 }
                               ]
                   , pile = [(BLUE, NUM 4)]
                   , deck = []
                   , state = PROCEED
                   }
    val tmpplayer = getPlayersFirst tmp
    val tmp1 = nextPlayer tmp
    val tmp1player = getPlayersFirst tmp1
    val tmp2 = nextPlayer tmp1
    val tmp2player = getPlayersFirst tmp2
  in
    isSamePlayer ( tmpplayer
                 , {name = "Anton", cards = [], strat = falseStrategy} )
    andalso
    isSamePlayer ( tmp1player
                 , {name = "Maks", cards = [], strat = falseStrategy})
    andalso
    isSamePlayer ( tmp2player
                 , {name = "Victoria", cards = [], strat = falseStrategy}) 
  end
val testPassMy =
  let 
    val tmp = pass { players = [ { name = "Anton"
                                 , cards = []
                                 , strat = falseStrategy 
                                 }
                               , { name = "Andrew"
                                 , cards = []
                                 , strat = falseStrategy 
                                 }
                               , { name = "Alexey"
                                 , cards = []
                                 , strat = falseStrategy 
                                 }
                               ]
                   , pile = [(RED, DRAW_TWO)]
                   , deck = [(RED, NUM 0), (RED, NUM 0)]
                   , state = EXECUTE
                   }
    val tmpplayer = getPlayersFirst tmp
    val tmp1 = nextPlayer tmp
    val tmp1player = getPlayersFirst tmp1
    val tmp2 = nextPlayer tmp1
    val tmp2player = getPlayersFirst tmp2
  in
    isSamePlayer ( tmpplayer
                 , {name = "Andrew", cards = [], strat = falseStrategy} )
    andalso
    isSamePlayer ( tmp1player
                 , {name = "Alexey", cards = [], strat = falseStrategy})
    andalso
    isSamePlayer ( tmp2player
                 , {name = "Anton", cards = [(RED, NUM 0), (RED, NUM 0)]
                 , strat = falseStrategy})    
  end
(* Задание 32. requiredColor *)
val testRequiredColor1 = requiredColor { players = []
                                       , pile = [(RED, REVERSE)]
                                       , deck = []
                                       , state = PROCEED
                                       }
                         = RED
val testRequiredColor2 = requiredColor { players = []
                                       , pile = [(BLACK, WILD)]
                                       , deck = []
                                       , state = GIVE YELLOW
                                       }
                         = YELLOW
val testRequiredColor3 = requiredColor { players = []
                                       , pile = [(RED, DRAW_TWO)]
                                       , deck = []
                                       , state = EXECUTE
                                       }
                         = RED
val testRequiredColor4 = requiredColor { players = []
                                       , pile = [(BLUE, NUM 0)]
                                       , deck = []
                                       , state = PROCEED
                                       }
                         = BLUE
val testRequiredColorMy = requiredColor { players = []
                                       , pile = [(BLACK, WILD_DRAW_FOUR)]
                                       , deck = []
                                       , state = GIVE RED
                                       }
                         = RED

(* Задание 33. playableCards *)
val testPlayableCards1 =
  let 
    val tmp = playableCards { players = [ { name = "Anton"
                                          , cards = [ (BLACK, WILD)
                                                    , (RED, NUM 5)
                                                    , (GREEN, DRAW_TWO)
                                                    , (RED, NUM 7)
                                                    , (BLUE, SKIP) ]
                                          , strat = falseStrategy 
                                          }
                                        ]
                            , pile = [(RED, REVERSE)]
                            , deck = []
                            , state = PROCEED
                            }
  in
    member ((BLACK, WILD), tmp)
    andalso member ((RED, NUM 5), tmp)
    andalso member ((RED, NUM 7), tmp)
    andalso length tmp = 3
  end
val testPlayableCards2 =
  let 
    val tmp = playableCards { players = [ { name = "Katerina"
                                          , cards = [ (BLUE, SKIP)
                                                    , (YELLOW, NUM 1)
                                                    , (BLACK, WILD_DRAW_FOUR)
                                                    , (GREEN, NUM 9)
                                                    , (RED, SKIP) ]
                                          , strat = falseStrategy 
                                          }
                                        ]
                            , pile = [(YELLOW, NUM 5)]
                            , deck = []
                            , state = PROCEED
                            }
  in
    member ((YELLOW,NUM 1), tmp)
    andalso member ((BLACK,WILD_DRAW_FOUR), tmp)
    andalso length tmp = 2
  end
val testPlayableCards3 =
  let 
    val tmp = playableCards { players = [ { name = "Victoria"
                                          , cards = [ (RED, REVERSE)
                                                    , (BLACK, WILD)
                                                    , (BLACK, WILD_DRAW_FOUR)
                                                    , (GREEN, NUM 9)
                                                    , (RED, SKIP) ]
                                          , strat = falseStrategy 
                                          }
                                        ]
                            , pile = [(GREEN, REVERSE)]
                            , deck = []
                            , state = PROCEED
                            }
  in
    member ((RED,REVERSE), tmp)
    andalso member ((BLACK,WILD), tmp)
    andalso member ((BLACK,WILD_DRAW_FOUR), tmp)
    andalso member ((GREEN,NUM 9), tmp)
    andalso length tmp = 4
  end
val testPlayableCards4 =
  let 
    val tmp = playableCards { players = [ { name = "Anna"
                                          , cards = [ (YELLOW, SKIP)
                                                    , (BLACK, WILD)
                                                    , (BLUE, NUM 6)
                                                    , (GREEN, DRAW_TWO)
                                                    , (RED, REVERSE) ]
                                          , strat = falseStrategy 
                                          }
                                        ]
                            , pile = [(BLUE, DRAW_TWO)]
                            , deck = []
                            , state = EXECUTE
                            }
  in
    member ((GREEN,DRAW_TWO), tmp)
  end
val testPlayableCardsMy =
  let 
    val tmp = playableCards { players = [ { name = "Anton"
                                          , cards = [ (BLACK, WILD)
                                                    , (RED, NUM 5)
                                                    , (GREEN, DRAW_TWO)
                                                    , (RED, NUM 7)
                                                    , (BLUE, SKIP) ]
                                          , strat = falseStrategy 
                                          }
                                        ]
                            , pile = [(RED, REVERSE)]
                            , deck = []
                            , state = PROCEED
                            }
  in
    member ((BLACK, WILD), tmp)
    andalso member ((RED, NUM 5), tmp)
    andalso member ((RED, NUM 7), tmp)
    andalso length tmp = 3
  end

(* Задание 34. countCards *)
val testCountCards1 =
  countCards { players = [ { name = "Anton"
                           , cards = []
                           , strat = falseStrategy 
                           }
                         , { name = "Andrew"
                           , cards = [ (BLACK, WILD)
                                     , (RED, NUM 5)
                                     , (GREEN, DRAW_TWO)
                                     , (RED, NUM 7)
                                     , (BLUE, SKIP) ]
                           , strat = falseStrategy 
                           }
                         , { name = "Alexey"
                           , cards = [ (BLACK, WILD)
                                     , (RED, NUM 5) ]
                           , strat = falseStrategy 
                           }
                         ]
             , pile = []
             , deck = []
             , state = PROCEED
             }
  = [0, 5, 2]
val testCountCards2 =
   countCards { players = []
             , pile = []
             , deck = []
             , state = PROCEED
             }
  = []
val testCountCards3 =
  countCards { players = [ { name = "Katerina"
                           , cards = [ (YELLOW, DRAW_TWO)
                                     , (BLUE, NUM 3)
                                     , (GREEN, REVERSE)
                                     , (YELLOW, NUM 0) ]
                           , strat = falseStrategy 
                           }
                         , { name = "Victoria"
                           , cards = [ (BLACK, WILD)
                                     , (RED, NUM 9)
                                     , (GREEN, SKIP)
                                     , (BLACK, WILD_DRAW_FOUR)
                                     , (BLUE, SKIP) ]
                           , strat = falseStrategy 
                           }
                         , { name = "Anna"
                           , cards = [ (BLUE, NUM 8)
                                     , (YELLOW, REVERSE) ]
                           , strat = falseStrategy 
                           }
                         ]
             , pile = []
             , deck = []
             , state = EXECUTE
             }
  = [4, 5, 2]
val testCountCardsMy =
  countCards { players = [ { name = "Anton"
                           , cards = []
                           , strat = falseStrategy 
                           }
                         , { name = "Andrew"
                           , cards = [ (BLACK, WILD)
                                     , (RED, NUM 5)
                                     , (GREEN, DRAW_TWO)
                                     , (RED, NUM 7)
                                     , (BLUE, SKIP) ]
                           , strat = falseStrategy 
                           }
                         , { name = "Alexey"
                           , cards = [ (BLACK, WILD)
                                     , (RED, NUM 5) ]
                           , strat = falseStrategy 
                           }
                         ]
             , pile = []
             , deck = []
             , state = PROCEED
             }
  = [0, 5, 2]

(* Задание 35. hasNoCards *)
val testHasNoCards1 =
  hasNoCards {name = "Anton", cards = [], strat = falseStrategy} = true
val testHasNoCards2 = hasNoCards { name = "Alexey"
                                 , cards = [ (BLACK, WILD)
                                           , (RED, NUM 5) ]
                                 , strat = falseStrategy 
                                 } = false
val testHasNoCards3 = hasNoCards { name = "Maks"
                                 , cards = [ (BLUE, DRAW_TWO)
                                           , (YELLOW, NUM 0) ]
                                 , strat = falseStrategy 
                                 } = false
val testHasNoCards4 =
  hasNoCards {name = "Victoria", cards = [], strat = falseStrategy} = true
val testHasNoCardsMy = hasNoCards { name = "Alexey"
                                 , cards = [ (BLACK, WILD)
                                           , (RED, NUM 5) ]
                                 , strat = falseStrategy 
                                 } = false

(* Задание 36. countLoss *)
val testCountLoss1 =
  countLoss [ { name = "Anton"
              , cards = []
              , strat = falseStrategy 
              }
            , { name = "Andrew"
              , cards = [ (BLACK, WILD)
                        , (RED, NUM 5)
                        , (GREEN, DRAW_TWO)
                        , (RED, NUM 7)
                        , (BLUE, SKIP) ]
              , strat = falseStrategy 
              }
            , { name = "Alexey"
              , cards = [ (BLACK, WILD)
                        , (RED, NUM 5) ]
              , strat = falseStrategy 
              }
            ]
  = [("Anton", 0), ("Andrew", 102), ("Alexey", 55)]
val testCountLoss2 =
   countLoss [ { name = "Anna"
              , cards = [(RED, NUM 7), (BLACK, WILD_DRAW_FOUR)]
              , strat = falseStrategy 
              }
            , { name = "Katerina"
              , cards = [ (YELLOW, NUM 0)
                        , (GREEN, SKIP)
                        , (GREEN, REVERSE)
                        , (BLUE, SKIP) ]
              , strat = falseStrategy 
              }
            , { name = "Victoria"
              , cards = [ (YELLOW, DRAW_TWO)
                        , (YELLOW, NUM 3) ]
              , strat = falseStrategy 
              }
            ] = [("Anna",57),("Katerina",60),("Victoria",23)]
val testCountLoss4 =
   countLoss [ { name = "Maks"
              , cards = []
              , strat = falseStrategy 
              }
            , { name = "Anton"
              , cards = []
              , strat = falseStrategy 
              }
            , { name = "Anna"
              , cards = []
              , strat = falseStrategy 
              }
            ] = [("Maks",0),("Anton",0),("Anna",0)]
val testCountLoss5 =
   countLoss [] = []
val testCountLossMy =
  countLoss [ { name = "Anton"
              , cards = []
              , strat = falseStrategy 
              }
            , { name = "Andrew"
              , cards = [ (BLACK, WILD)
                        , (RED, NUM 5)
                        , (GREEN, DRAW_TWO)
                        , (RED, NUM 7)
                        , (BLUE, SKIP) ]
              , strat = falseStrategy 
              }
            , { name = "Alexey"
              , cards = [ (BLACK, WILD)
                        , (RED, NUM 5) ]
              , strat = falseStrategy 
              }
            ]
  = [("Anton", 0), ("Andrew", 102), ("Alexey", 55)]

(* Задание 37. naiveStrategy *)
val testNaiveStrategy1 = naiveStrategy ( EXECUTE
                                       , [ (BLACK, WILD)
                                         , (RED, NUM 5)
                                         , (GREEN, DRAW_TWO)
                                         , (RED, NUM 7)
                                         , (BLUE, SKIP) ]
                                       , (RED, SKIP)
                                       , [] )
                         = ((BLUE, SKIP), RED)
val testNaiveStrategy2 = 
  let 
    val tmp = naiveStrategy ( GIVE RED
                            , [ (BLACK, WILD)
                              , (RED, NUM 5)
                              , (GREEN, DRAW_TWO)
                              , (RED, NUM 7)
                              , (BLUE, SKIP) ]
                            , (BLACK, WILD_DRAW_FOUR)
                            , [] )
  in #1 tmp = (RED, NUM 7)
  end
val testNaiveStrategy3 = 
  let 
    val tmp = naiveStrategy ( PROCEED
                            , [ (BLACK, WILD)
                              , (RED, NUM 5)
                              , (GREEN, DRAW_TWO)
                              , (RED, NUM 7)
                              , (BLUE, SKIP) ]
                            , (RED, NUM 1)
                            , [] )
  in #1 tmp = (RED, NUM 7)
  end
val testNaiveStrategy4 = 
  let 
    val tmp = naiveStrategy ( GIVE GREEN
                            , [ (BLACK, WILD)
                              , (BLUE, NUM 0)
                              , (BLUE, DRAW_TWO)
                              , (RED, NUM 7)
                              , (YELLOW, REVERSE) ]
                            , (BLACK, WILD_DRAW_FOUR)
                            , [] )
  in #1 tmp = (BLACK,WILD)
  end
val testNaiveStrategyMy = naiveStrategy ( EXECUTE
                                       , [ (BLACK, WILD)
                                         , (RED, NUM 5)
                                         , (GREEN, DRAW_TWO)
                                         , (RED, NUM 7)
                                         , (BLUE, SKIP) ]
                                       , (RED, SKIP)
                                       , [] )
                         = ((BLUE, SKIP), RED)

(* Задание 38. play *)
val testPlay1 =
  let 
    val dsk = { players = [ { name = "Anton"
                            , cards = [(GREEN, NUM 5)]
                            , strat = falseStrategy 
                            }
                          , { name = "Andrew"
                            , cards = []
                            , strat = falseStrategy 
                            }
                          , { name = "Alexey"
                            , cards = []
                            , strat = falseStrategy 
                            }
                          ]
              , pile = [(GREEN, NUM 9)]
              , deck = [(BLUE, NUM 4)]
              , state = PROCEED
              }
    val playcards = playableCards dsk
    val tmp = play (dsk, playcards)
    val tmpplayer = getPlayersFirst tmp
    val tmppile = getDeskPile tmp
    val tmpstate = getDeskState tmp
  in 
    isSamePlayer (tmpplayer, { name = "Andrew"
                             , cards = []
                             , strat = falseStrategy })
    andalso tmppile = [(GREEN, NUM 5), (GREEN, NUM 9)]
    andalso tmpstate = PROCEED
  end
val testPlay2 =
  let 
    val dsk = { players = [ { name = "Anton"
                            , cards = [(GREEN, NUM 5)]
                            , strat = falseStrategy 
                            }
                          , { name = "Andrew"
                            , cards = []
                            , strat = falseStrategy 
                            }
                          , { name = "Alexey"
                            , cards = []
                            , strat = falseStrategy 
                            }
                          ]
              , pile = [(BLUE, NUM 9)]
              , deck = [(BLUE, NUM 4)]
              , state = PROCEED
              }
    val playcards = playableCards dsk
    val tmp = play (dsk, playcards)
  in 
    false
  end
  handle IllegalMove "Anton" => true
val testPlay3 =
  let 
    val dsk = { players = [ { name = "Katerina"
                            , cards = [(BLACK, WILD)]
                            , strat = falseStrategy 
                            }
                          , { name = "Anna"
                            , cards = []
                            , strat = falseStrategy 
                            }
                          , { name = "Alexey"
                            , cards = []
                            , strat = falseStrategy 
                            }
                          ]
              , pile = [(YELLOW, NUM 2)]
              , deck = [(RED, REVERSE)]
              , state = PROCEED
              }
    val playcards = playableCards dsk
    val tmp = play (dsk, playcards)
    val tmpplayer = getPlayersFirst tmp
    val tmppile = getDeskPile tmp
    val tmpstate = getDeskState tmp
  in 
    isSamePlayer (tmpplayer, { name = "Anna"
                             , cards = []
                             , strat = falseStrategy })
    andalso tmppile = [(BLACK,WILD), (YELLOW,NUM 2)]
    andalso tmpstate = GIVE GREEN
  end
val testPlayMy =
  let 
    val dsk = { players = [ { name = "Anton"
                            , cards = [(GREEN, NUM 5)]
                            , strat = falseStrategy 
                            }
                          , { name = "Andrew"
                            , cards = []
                            , strat = falseStrategy 
                            }
                          , { name = "Alexey"
                            , cards = []
                            , strat = falseStrategy 
                            }
                          ]
              , pile = [(GREEN, NUM 9)]
              , deck = [(BLUE, NUM 4)]
              , state = PROCEED
              }
    val playcards = playableCards dsk
    val tmp = play (dsk, playcards)
    val tmpplayer = getPlayersFirst tmp
    val tmppile = getDeskPile tmp
    val tmpstate = getDeskState tmp
  in 
    isSamePlayer (tmpplayer, { name = "Andrew"
                             , cards = []
                             , strat = falseStrategy })
    andalso tmppile = [(GREEN, NUM 5), (GREEN, NUM 9)]
    andalso tmpstate = PROCEED
  end

(* Задание 39. gameStep *)
val testGameStep1 =
  let 
    val dsk = { players = [ { name = "Anton"
                            , cards = [(GREEN, NUM 5)]
                            , strat = falseStrategy 
                            }
                          , { name = "Andrew"
                            , cards = []
                            , strat = falseStrategy 
                            }
                          , { name = "Alexey"
                            , cards = []
                            , strat = falseStrategy 
                            }
                          ]
              , pile = [(GREEN, NUM 9)]
              , deck = [(BLUE, NUM 4)]
              , state = PROCEED
              }
    val tmp = gameStep dsk
    val tmpplayer = getPlayersFirst tmp
    val tmppile = getDeskPile tmp
    val tmpstate = getDeskState tmp
  in 
    isSamePlayer (tmpplayer, { name = "Andrew"
                             , cards = []
                             , strat = falseStrategy })
    andalso tmppile = [(GREEN, NUM 5), (GREEN, NUM 9)]
    andalso tmpstate = PROCEED
  end
val testGameStep2 =
  let 
    val dsk = { players = [ { name = "Katerina"
                            , cards = []
                            , strat = falseStrategy 
                            }
                          , { name = "Anna"
                            , cards = [(YELLOW, NUM 2)]
                            , strat = falseStrategy 
                            }
                          , { name = "Victoria"
                            , cards = []
                            , strat = falseStrategy 
                            }
                          ]
              , pile = [(BLUE, REVERSE)]
              , deck = [(YELLOW, NUM 4)]
              , state = PROCEED
              }
    val tmp = gameStep dsk
    val tmpplayer = getPlayersFirst tmp
    val tmppile = getDeskPile tmp
    val tmpstate = getDeskState tmp
  in 
    isSamePlayer (tmpplayer, { name = "Anna"
                             , cards = [(YELLOW,NUM 2)]
                             , strat = falseStrategy })
    andalso tmppile = [(BLUE,REVERSE)]
    andalso tmpstate = PROCEED
  end

(* Задание 40. game *)
val testGame1 =
  let 
    val dsk = { players = [ { name = "Alexey"
                            , cards = [ (BLACK, WILD)
                                      , (RED, NUM 5) ]
                            , strat = falseStrategy 
                            }
                          , { name = "Anton"
                            , cards = [(GREEN, NUM 5)]
                            , strat = falseStrategy 
                            }
                          , { name = "Andrew"
                            , cards = [ (BLACK, WILD)
                                      , (RED, NUM 5)
                                      , (GREEN, DRAW_TWO)
                                      , (RED, NUM 7)
                                      , (BLUE, SKIP) ]
                            , strat = falseStrategy 
                            }
                          ]
              , pile = [(GREEN, NUM 9)]
              , deck = [(BLUE, NUM 4)]
              , state = PROCEED
              }
    val tmp = game dsk
  in 
    tmp = ("Anton", [("Andrew", 102), ("Alexey", 55), ("Anton", 0)])
  end
val testGame2 =
  let 
    val dsk = { players = [ { name = "Anton"
                            , cards = [(GREEN, NUM 5)]
                            , strat = falseStrategy 
                            }
                          , { name = "Andrew"
                            , cards = [ (BLACK, WILD)
                                      , (RED, NUM 5)
                                      , (GREEN, DRAW_TWO)
                                      , (RED, NUM 7)
                                      , (BLUE, SKIP) ]
                            , strat = falseStrategy 
                            }
                          , { name = "Alexey"
                            , cards = [ (BLACK, WILD)
                                      , (RED, NUM 5) ]
                            , strat = falseStrategy 
                            }
                          ]
              , pile = [(GREEN, REVERSE)]
              , deck = [(BLUE, NUM 4)]
              , state = PROCEED
              }
    val tmp = game dsk
  in 
    tmp = ("Anton", [("Alexey", 55), ("Andrew", 102), ("Anton", 0)])
  end 
val testGameMy =
  let
    val dsk = { players = [ { name = "Alexey"
                            , cards = [ (GREEN, NUM 0) ]
                            , strat = falseStrategy
                            }
                          , { name = "Anton"
                            , cards = [ (BLACK, WILD_DRAW_FOUR) ]
                            , strat = naiveStrategy
                            }
                          , { name = "Andrew"
                            , cards = [ (BLACK, WILD)
                            , (RED, NUM 5)
                            , (GREEN, DRAW_TWO)
                            , (RED, NUM 7)
                            , (BLUE, SKIP) ]
                            , strat = naiveStrategy
                            }
                          ]
              , pile = [(GREEN, NUM 9)]
              , deck = [ (BLUE, NUM 4), (BLUE, NUM 4)
                       , (BLACK, WILD), (BLACK, WILD), (RED, NUM 0)]
              , state = PROCEED
              }
    val tmp = game dsk
  in
    tmp = ("Anton",[("Alexey",0),("Anton",0),("Andrew",210)])
  end