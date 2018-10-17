(* Задание 1 *)
val testIsLeapYear1 = isLeapYear 2000 = true
val testIsLeapYear2 = isLeapYear 2015 = false
val testIsLeapYear3 = isLeapYear 2016 = true
val testIsLeapYear4 = isLeapYear 2014 = false
val testIsLeapYear5 = isLeapYear 2012 = true

(* Задание 2 *)
val testIsCorrectDate1 = isCorrectDate (1,9,2016) = true
val testIsCorrectDate2 = isCorrectDate (21,13,1900) = false
val testIsCorrectDate3 = isCorrectDate (~12,3,1857) = false
val testIsCorrectDate4 = isCorrectDate (29,2,1857) = false
val testIsCorrectDate5 = isCorrectDate (29,2,1816) = true
val testIsCorrectDate6 = isCorrectDate (5,10,~1050) = false
val testIsCorrectDate7 = isCorrectDate (1,2,~5) = false

(* Задание 3 *)
val testNewStyleCorrection1 = newStyleCorrection (1,3,2016) = 13
val testNewStyleCorrection2 = newStyleCorrection (28,2,2016) = 13
val testNewStyleCorrection3 = newStyleCorrection (28,2,1700) = 10
val testNewStyleCorrection4 = newStyleCorrection (8,5,2204) = 15

(* Задание 4 *)
val testGetNthInt1 =
  let val tmp = getNthInt ([25, ~615, 834, ~38, 0], 3)
  in tmp = ~38
  end
val testGetNthInt2 =
  let val tmp = getNthInt ([2, 14, ~5, 16, 27, 8, ~22, 18], 4)
  in tmp = 27
  end
val testGetNthInt3 =
  let val tmp = getNthInt ([~9, 15, 1024, 308, ~17], 0)
  in tmp = ~9
  end

(* Задание 5 *)
val testGetNthStr1 =
  getNthStr (["hi", "there", "how", "are", "you"], 2) = "how"
val testGetNthStr2 =
  getNthStr (["this", "is", "just", "my", "improvisation"], 0) = "this"
val testGetNthStr3 =
  getNthStr (["actually", "coffee", "is", "not"
             , "so", "tasty", "as", "chocolate"], 1) = "coffee"
val testGetNthStr4 =
  getNthStr (["communication", "helps", "to", "calm", "down"], 1) = "helps"
val testGetNthStr5 =
  getNthStr (["dresses", "are", "not", "comfortable", "for", "me"], 5) = "me"
val testGetNthStr6 =
  getNthStr (["watermelon", "is", "not", "a", "fruit"], 2) = "not"
val testGetNthStr7 = 
  getNthStr (["I", "want", "to", "relax"
             , "and", "play", "the", "guitar"], 2) = "to"
val testGetNthStr8 =
  getNthStr (["although", "I", "more"
             , "want", "to", "sleep", "to", "be", "honest"], 5) = "sleep"

(* Задание 6 *)
val testLastSmaller1 = lastSmaller (3654, [0, 25, 834, 3800]) = 834
val testLastSmaller2 = lastSmaller (500, [5, 150, 700, 1000]) = 150
val testLastSmaller3 = lastSmaller (2, [5, 7, 10, 20]) = 0
val testLastSmaller4 = lastSmaller (50, [14, 45, 347, 651]) = 45
val testLastSmaller5 =
  lastSmaller (17000, [130, 504, 2500, 3840, 16000]) = 16000

(* Задание 7 *)
val testFirstNewMoonInt1 = firstNewMoonInt (1, 9, 2016) = SOME 170823
val testFirstNewMoonInt2 = firstNewMoonInt (14, 2, 2016) = SOME 823882
val testFirstNewMoonInt3 = firstNewMoonInt (3, 5, 2001) = SOME 2243882
val testFirstNewMoonInt4 = firstNewMoonInt (13, 2, 1997) = SOME 760823
val testFirstNewMoonInt5 = firstNewMoonInt (1, 2, 203) = SOME 2890000
val testFirstNewMoonInt6 = firstNewMoonInt (1, 2, 211) = NONE
val testFirstNewMoonInt2009 = firstNewMoonInt (1, 12, 2009) = SOME 1683882
val testFirstNewMoonInt2010 = firstNewMoonInt (1, 1, 2010) = SOME 1543882


(* Задание 8 *)
val testFirstNewMoon1  = firstNewMoon (1, 9, 2016) = SOME (1,9,2016)
val testFirstNewMoon2 = firstNewMoon (14, 2, 2016) = SOME (8,2,2016)
val testFirstNewMoon3 = firstNewMoon (3, 5, 2001) = SOME (22,5,2001)
val testFirstNewMoon4 = firstNewMoon (13, 2, 1997) = SOME (7,2,1997)
val testFirstNewMoon5 = firstNewMoon (1, 2, 203) = SOME (28,2,203)
val testFirstNewMoon6 = firstNewMoon (1, 2, 211) = NONE
val testFirstNewMoon2009 = firstNewMoon (1, 12, 2009) = SOME (16,12,2009)
val testFirstNewMoon2010 = firstNewMoon (1, 1, 2010) = SOME (15,1,2010)

(* Задание 9 *)
val testDateToString1 = dateToString (5, 5, 1980) = "May 5, 1980"
val testDateToString2 = dateToString (1, 9, 2016) = "September 1, 2016"
val testDateToString3 = dateToString (4, 7, 2014) = "July 4, 2014"
val testDateToString4 = dateToString (24, 2, 1999) = "February 24, 1999"

(* Задание 10 *)
val testIsOlder1 = isOlder ((1,2,3), (2,3,4)) = true
val testIsOlder2 = isOlder ((2,3,4), (1,2,3)) = false
val testIsOlder3 = isOlder ((30,12,17), (31,12,17)) = true
val testIsOlder4 = isOlder ((5,3,8), (5,2,8)) = false

(* Задание 11 *)
val testWinterSolstice1 = winterSolstice 0 = 22
val testWinterSolstice2 = winterSolstice 3 = 23
val testWinterSolstice3 = winterSolstice 2014 = 22
val testWinterSolstice4 = winterSolstice 1546 = 22
val testWinterSolstice5 = winterSolstice 19 = 23
val testWinterSolstice6 = winterSolstice 6381 = 20
val testWinterSolstice7 = winterSolstice 1924 = 22
val testWinterSolstice8 = winterSolstice 1925 = 22
val testWinterSolstice9 = winterSolstice 1926 = 22
val testWinterSolstice10 = winterSolstice 1927 = 23
val testWinterSolstice11 = winterSolstice 1928 = 22
val testWinterSolstice12 = winterSolstice 1929 = 22
val testWinterSolstice2009 = winterSolstice 2009 = 22
val testWinterSolstice2010 = winterSolstice 2010 = 22
val testWinterSolstice2011 = winterSolstice 2011 = 22
val testWinterSolstice2012 = winterSolstice 2012 = 21
val testWinterSolstice2013 = winterSolstice 2013 = 22
val testWinterSolstice2014 = winterSolstice 2014 = 22
val testWinterSolstice2015 = winterSolstice 2015 = 22
val testWinterSolstice2016 = winterSolstice 2016 = 21
val testWinterSolstice2017 = winterSolstice 2017 = 22
val testWinterSolstice2018 = winterSolstice 2018 = 22
val testWinterSolstice2019 = winterSolstice 2019 = 22
val testWinterSolstice2020 = winterSolstice 2020 = 21
val testWinterSolstice2021 = winterSolstice 2021 = 21
val testWinterSolstice2022 = winterSolstice 2022 = 22
val testWinterSolstice2023 = winterSolstice 2023 = 22
val testWinterSolstice2024 = winterSolstice 2024 = 21
val testWinterSolstice2025 = winterSolstice 2025 = 21

(* Задание 12 *)
val testChineseNewYear1 = chineseNewYear 2016 = (8,2,2016)
val testChineseNewYear2 = chineseNewYear 1723 = (5,2,1723)
val testChineseNewYear3 = chineseNewYear 2002 = (12,2,2002)
val testChineseNewYear4 = chineseNewYear 1997 = (7,2,1997)
val testChineseNewYear5 = chineseNewYear 211 = (31,1,211)
val testChineseNewYear6 = chineseNewYear 239 = (20,2,239)
val testChineseNewYear7 = chineseNewYear 1924 = (5,2,1924)
val testChineseNewYear8 = chineseNewYear 1925 = (24,1,1925)
val testChineseNewYear9 = chineseNewYear 1926 = (12,2,1926)
val testChineseNewYear10 = chineseNewYear 1927 = (2,2,1927)
val testChineseNewYear11 = chineseNewYear 1928 = (21,2,1928)
val testChineseNewYear12 = chineseNewYear 1929 = (9,2,1929)
val testChineseNewYear13 = chineseNewYear 1930 = (29,1,1930)
val testChineseNewYear14 = chineseNewYear 1931 = (17,2,1931)
val testChineseNewYear15 = chineseNewYear 1932 = (6,2,1932)
val testChineseNewYear16 = chineseNewYear 1933 = (26,1,1933)
val testChineseNewYear17 = chineseNewYear 1934 = (14,2,1934)
val testChineseNewYear18 = chineseNewYear 1935 = (3,2,1935)
val testChineseNewYear19 = chineseNewYear 1936 = (23,1,1936)
val testChineseNewYear20 = chineseNewYear 1937 = (10,2,1937)
val testChineseNewYear21 = chineseNewYear 1938 = (31,1,1938)
val testChineseNewYear22 = chineseNewYear 1939 = (19,2,1939)
val testChineseNewYear23 = chineseNewYear 1940 = (8,2,1940)
val testChineseNewYear24 = chineseNewYear 1941 = (27,1,1941)
val testChineseNewYear25 = chineseNewYear 1942 = (15,2,1942)
val testChineseNewYear26 = chineseNewYear 1943 = (5,2,1943)
val testChineseNewYear27 = chineseNewYear 1944 = (25,1,1944)
val testChineseNewYear28 = chineseNewYear 1945 = (12,2,1945)
val testChineseNewYear29 = chineseNewYear 1946 = (1,2,1946)
val testChineseNewYear30 = chineseNewYear 1947 = (22,1,1947)
val testChineseNewYear31 = chineseNewYear 1948 = (10,2,1948)
val testChineseNewYear32 = chineseNewYear 1949 = (29,1,1949)
val testChineseNewYear33 = chineseNewYear 1950 = (17,2,1950)
val testChineseNewYear34 = chineseNewYear 1951 = (6,2,1951)
val testChineseNewYear35 = chineseNewYear 1952 = (26,1,1952)
val testChineseNewYear36 = chineseNewYear 1953 = (13,2,1953)
val testChineseNewYear37 = chineseNewYear 1954 = (3,2,1954)
val testChineseNewYear38 = chineseNewYear 1955 = (23,1,1955)
val testChineseNewYear39 = chineseNewYear 1956 = (11,2,1956)
val testChineseNewYear40 = chineseNewYear 1957 = (30,1,1957)
val testChineseNewYear41 = chineseNewYear 1958 = (18,2,1958)
val testChineseNewYear42 = chineseNewYear 1959 = (8,2,1959)
val testChineseNewYear43 = chineseNewYear 1960 = (28,1,1960)
val testChineseNewYear44 = chineseNewYear 1961 = (15,2,1961)
val testChineseNewYear45 = chineseNewYear 1962 = (4,2,1962)
val testChineseNewYear46 = chineseNewYear 1963 = (25,1,1963)
val testChineseNewYear47 = chineseNewYear 1964 = (13,2,1964)
val testChineseNewYear48 = chineseNewYear 1965 = (1,2,1965)
val testChineseNewYear49 = chineseNewYear 1966 = (21,1,1966)
val testChineseNewYear50 = chineseNewYear 1967 = (9,2,1967)
val testChineseNewYear51 = chineseNewYear 1968 = (30,1,1968)
val testChineseNewYear52 = chineseNewYear 1969 = (16,2,1969)
val testChineseNewYear53 = chineseNewYear 1970 = (6,2,1970)
val testChineseNewYear54 = chineseNewYear 1971 = (26,1,1971)
val testChineseNewYear55 = chineseNewYear 1972 = (14,2,1972)
val testChineseNewYear56 = chineseNewYear 1973 = (3,2,1973)
val testChineseNewYear57 = chineseNewYear 1974 = (23,1,1974)
val testChineseNewYear58 = chineseNewYear 1975 = (11,2,1975)
val testChineseNewYear59 = chineseNewYear 1976 = (31,1,1976)
val testChineseNewYear60 = chineseNewYear 1977 = (18,2,1977)
val testChineseNewYear61 = chineseNewYear 1978 = (7,2,1978)
val testChineseNewYear62 = chineseNewYear 1979 = (28,1,1979)
val testChineseNewYear63 = chineseNewYear 1980 = (16,2,1980)
val testChineseNewYear64 = chineseNewYear 1981 = (4,2,1981)
val testChineseNewYear65 = chineseNewYear 1982 = (24,1,1982)
val testChineseNewYear66 = chineseNewYear 1983 = (12,2,1983)
val testChineseNewYear2007 = chineseNewYear 2007 = (17,2,2007)
val testChineseNewYear2008 = chineseNewYear 2008 = (6,2,2008)
val testChineseNewYear2009 = chineseNewYear 2009 = (26,1,2009)
val testChineseNewYear2010 = chineseNewYear 2010 = (13,2,2010)
val testChineseNewYear2011 = chineseNewYear 2011 = (3,2,2011)
val testChineseNewYear2012 = chineseNewYear 2012 = (23,1,2012)
val testChineseNewYear2013 = chineseNewYear 2013 = (10,2,2013)
val testChineseNewYear2014 = chineseNewYear 2014 = (30,1,2014)
val testChineseNewYear2015 = chineseNewYear 2015 = (18,2,2015)
val testChineseNewYear2016 = chineseNewYear 2016 = (8,2,2016)
val testChineseNewYear2017 = chineseNewYear 2017 = (27,1,2017)
val testChineseNewYear2018 = chineseNewYear 2018 = (15,2,2018)
val testChineseNewYear2019 = chineseNewYear 2019 = (4,2,2019)
val testChineseNewYear2020 = chineseNewYear 2020 = (25,1,2020)
val testChineseNewYear2021 = chineseNewYear 2021 = (12,2,2021)
val testChineseNewYear2022 = chineseNewYear 2022 = (1,2,2022)
val testChineseNewYear2023 = chineseNewYear 2023 = (21,1,2023)
val testChineseNewYear2024 = chineseNewYear 2024 = (9,2,2024)
val testChineseNewYear2025 = chineseNewYear 2025 = (29,1,2025)

(* Задание 13 *)
val testChineseYear1 =
  chineseYear 1980 = ("Geng-Shen","White","Monkey","Metal")
val testChineseYear2 =
  chineseYear 2015 = ("Yi-Wei","Green","Sheep","Cut timber")
val testChineseYear3 =
  chineseYear 2018 = ("Wu-Xu","Brown","Dog","Earth")
val testChineseYear4 =
  chineseYear 1999 = ("Ji-Mao","Brown","Rabbit","Earthenware")
val testChineseYear5 =
  chineseYear 1996 = ("Bing-Zi","Red","Rat","Natural fire")
val testChineseYear6 =
  chineseYear 1998 = ("Wu-Yin","Brown","Tiger","Earth")

(* Задание 14 *)
val testDateToChineseYear1 =
  dateToChineseYear (1,9,1980) = ("Geng-Shen","White","Monkey","Metal")
val testDateToChineseYear2 =
  dateToChineseYear (1,9,2016) = ("Bing-Shen","Red","Monkey","Natural fire")
val testDateToChineseYear3 =
  dateToChineseYear (8,5,2010) = ("Geng-Yin","White","Tiger","Metal")
val testDateToChineseYear4 =
  dateToChineseYear (25,11,1955) = ("Yi-Wei","Green","Sheep","Cut timber")
val testDateToChineseYear5 =
  dateToChineseYear (31, 1, 211) = ("Xin-Mao","White","Rabbit","Wrought metal")

(* Задание 15 *)
val testDateToAnimal1 = dateToAnimal (1,9,1980) = "Monkey"
val testDateToAnimal2 = dateToAnimal (1,9,2016) = "Monkey"
val testDateToAnimal3 = dateToAnimal (12,9,2017) = "Chicken"
val testDateToAnimal4 = dateToAnimal (5,6,2018) = "Dog"
val testDateToAnimal5 = dateToAnimal (31, 1, 211) = "Rabbit"

(* Задание 16 *)
val testAnimal1 = 
  animal ("Ivan", (1,9,1980)) = "Monkey"
val testAnimal2 = 
  animal ("Svetlana", (1,9,2016)) = "Monkey"
val testAnimal3 = 
  animal ("Katerina", (8,5,1995)) = "Pig"
val testAnimal4 = 
  animal ("Anton", (23,10,2002)) = "Horse"
val testAnimal5 = 
  animal ("Ivan", (31, 1, 211)) = "Rabbit"

(* Вспомогательная функция для тестирования заданий 17 и 18
 * выдает true, когда элемент a присутствует в списке l 
 * иначе выдает false *)
fun member ( a : string * (int * int * int)
           , l : (string * (int * int * int)) list
           ) : bool =
  if null l then false
  else a = hd l orelse member (a, tl l)

(* Задание 17 *)
val testExtractAnimal1 = 
  extractAnimal ( [ ("Ivan", (1,9,1980))
                   , ("Svetlana", (1,9,2015)) ]
                 , "Monkey" ) 
  = [("Ivan", (1, 9, 1980))]
val testExtractAnimal2 = 
  let val tmp = extractAnimal ( [ ("Ivan", (1,9,1980))
                                 , ("Svetlana", (1,9,2015))
                                 , ("Alex", (1,9,1955)) 
                                 ]
                               , "Sheep" )
  in
    member (("Svetlana", (1,9,2015)), tmp)
    andalso member (("Alex", (1,9,1955)), tmp)
    andalso length tmp = 2
  end
val testExtractAnimal3 = 
  extractAnimal ( [ ("Katerina", (6,7,1992))
                   , ("Alex", (12,5,1998)),
                     ("Anton", (4,2,2013)) ]
                 , "Tiger" ) 
  = [("Alex", (12,5,1998))]
val testExtractAnimal4 = 
  let val tmp = extractAnimal ( [ ("Anna", (7,12,1987))
                                 , ("Victoria", (5,9,1999))
                                 , ("Klara", (8,10,2102)) 
                                 ]
                               , "Rabbit" )
  in
    member (("Anna", (7,12,1987)), tmp)
    andalso member (("Victoria", (5,9,1999)), tmp)
    andalso length tmp = 2
  end
val testExtractAnimal5 = 
  extractAnimal ( [ ("Ivan", (31, 1, 211))
                   , ("Svetlana", (1, 9, 2015))
                   , ("Alex", (1, 9, 1996))
                   , ("Anton", (31, 8, 1995)) ]
                 , "Rabbit" )
  = [("Ivan", (31, 1, 211))]

(* Задание 18 *)
val testExtractAnimals1 = 
  extractAnimals ( [ ("Ivan", (1,9,1980))
                    , ("Svetlana", (1,9,2015)) ]
                  , ["Monkey"] ) 
  = [("Ivan", (1,9,1980))]
val testExtractAnimals2 = 
  let val tmp = extractAnimals ( [ ("Ivan", (1,9,1980))
                                  , ("Svetlana", (1,9,2015)) 
                                  , ("Alex", (1,9,1955)) 
                                  ]
                                , ["Monkey", "Sheep"] )
  in
    member (("Svetlana", (1,9,2015)), tmp)
    andalso member (("Alex", (1,9,1955)), tmp)
    andalso member (("Ivan", (1,9,1980)), tmp)
    andalso length tmp = 3
  end
val testExtractAnimals3 = 
  let val tmp = extractAnimals ( [ ("Anna", (21,4,1840))
                                  , ("Svetlana", (12,8,2007))
                                  , ("Alex", (23,10,1975))
                                  , ("Victoria", (2,8,2016))
                                  ]
                                , ["Monkey", "Pig"] )
  in
    member (("Svetlana", (12,8,2007)), tmp)
    andalso member (("Victoria", (2,8,2016)), tmp)
    andalso length tmp = 2
  end
val testExtractAnimals4 = 
  let val tmp = extractAnimals ( [ ("Anastasia", (16,6,1952))
                                  , ("Anton", (25,9,2000))
                                  , ("Ivan", (3,10,1898))
                                  , ("Victoria", (19,2,1458))
                                  ]
                                , ["Dragon", "Tiger", "Horse"] )
  in
    member (("Anastasia", (16,6,1952)), tmp)
    andalso member (("Anton", (25,9,2000)), tmp)
    andalso member (("Victoria", (19,2,1458)), tmp)
    andalso length tmp = 3
  end
val testExtractAnimals5 = 
  extractAnimal ( [ ("Ivan", (31, 1, 211))
                   , ("Svetlana", (1, 9, 2015))
                   , ("Alex", (1, 9, 1996))
                   , ("Anton", (31, 8, 1995)) ]
                 , "Rabbit" )
  = [("Ivan", (31, 1, 211))]

(* Задание 19 *)
val testOldest1 = 
  oldest [ ("Ivan", (1,9,1980))
         , ("Svetlana", (1,9,2015))
         , ("Alex", (1,9,1955)) ] = SOME "Alex"
val testOldest2 = 
  oldest [ ("Victoria", (2,9,2001))
         , ("Svetlana", (1,9,2001))
         , ("Anton", (14,7,2004)) ] = SOME "Svetlana"
val testOldest3 = 
  oldest [ ("Katerina", (28,11,1483))
         , ("Anastasia", (26,8,1947))
         , ("Anna", (19,6,2648)) ] = SOME "Katerina"

(* Задание 20 *)
val testOldestFromAnimals1 = 
  oldestFromAnimals ( [ ("Ivan", (1,9,1980))
                        , ("Svetlana", (1,9,2015)) 
                        , ("Alex", (1,9,1955)) 
                        ]
                      , ["Monkey", "Sheep"] ) = SOME "Alex"
val testOldestFromAnimals2 = 
  oldestFromAnimals ( [ ("Anton", (7,12,1743))
                        , ("Anastasia", (15,3,1824)) 
                        , ("Katerina", (22,8,1956)) 
                        ]
                      , ["Monkey", "Pig"] ) = SOME "Anton"
val testOldestFromAnimals3 = 
  oldestFromAnimals ( [ ("Anna", (24,10,2090))
                        , ("Svetlana", (17,2,1986)) 
                        , ("Victoria", (1,7,1925)) 
                        ]
                      , ["Cow", "Tiger", "Dog"] ) = SOME "Victoria"
val testOldestFromAnimals4 = 
  oldestFromAnimals ( [ ("Ivan", (31, 1, 211))
                        , ("Alexei", (3, 10, 2001))
                        , ("Victor", (3, 10, 2001))
                        ]
                      , ["Rabbit"] ) = SOME "Ivan"