;;; ПЕРВОНАЧАЛЬНЫЙ НАБОР ТЕСТОВ ДЛЯ ЛАБОРАТОРНОЙ РАБОТЫ №5
;;; по мере реализации решений заданий пополняйте их своими тестами

;;; ВСЕ КОММЕНТАРИИ ПРИВЕДЕННЫЕ В ДАННОМ ФАЙЛЕ 
;;; И ВЕСЬ ПЕРВОНАЧАЛЬНЫЙ НАБОР ТЕСТОВ ДОЛЖНЫ ОСТАТЬСЯ НА СВОИХ МЕСТАХ
;;; НЕЛЬЗЯ ПЕРЕСТАВЛЯТЬ МЕСТАМИ КАКИЕ-ЛИБО БЛОКИ ДАННОГО ФАЙЛА
;;; дополнительные тесты должны продолжать отведенные для них блоки
;;; тесов соответствующих функций
;;; вызовы (line) и (starline), выводящие разделительные линии для
;;; блоков тестов, должны остаться на своих местах 

;;; Для проведения тестов запустите этот файл 
;;; Файл может быть запущен даже при отсутствии реализации тестируемых функций

(load "lab-5.lsp")

;;; ВСПОМОГАТЕЛЬНЫЕ ОПРЕДЕЛЕНИЯ

;; макрос для проведения теста, в результате которого не должно быть 
;; сообщений об ошибках
;; fun - имя тестируемой функции
;; num - номер теста
;; test-expr - тестовое выражение (результатом которого должно быть T)
(defmacro result-test (fun num test-expr)
  `(progn
    (format T "function: ~A ~30,2Ttest: ~A ~Tresult: ~A~%" 
            ',fun ,num
            (handler-case 
               ,test-expr
             (T () NIL)))))

;; макрос для проведения теста результатом которого должно быть 
;; сообщение об ошибке error-type
;; fun - имя тестируемой функции
;; num - номер теста
;; error-type - имя исключения (T - если любое)
;; test-expr - тестовое выражение (результатом которого должно быть сообщение 
;;             о соответствующей ошибке)
(defmacro error-test (fun num error-type test-expr)
  `(progn
    (format T "function: ~A ~30,2Ttest: ~A ~Tresult: ~A~%" 
            ',fun ,num
            (handler-case 
               ,test-expr
             (,error-type () T)
             (T () NIL)))))

;; функция вывода разделительной линии
(defun line ()
  (format T "~V@{~a~:*~}~%" 50 "-"))
(defun starline ()
  (format T "~V@{~a~:*~}~%" 50 "*"))


;;; ТЕСТЫ
;; Каждый тест должен описывается как вызов макроса
;;
;; (result-test f N expr)
;;
;; в котором f - имя тестируемой функции
;;           N - номер теста для функции f
;;        expr - тестовое выражение, которое проверяет правильность
;;               функции f на каких-то тестовых данных; выражение должно 
;;               выдавать T в случае успешной проверки 
;;
;; или, если тестируется аварийный останов выполнения функции,
;; вызов макроса
;;
;; (error-test f N err expr)
;;
;; где f, N, expr - то же, что и в предыдущем случае, но 
;; проверяется, что выполнение expr прервется с ошибкой err
;; err может быть равным T, если ошибка любая
(line)
(starline)

;; Задание 1. Предикаты для выражений
;; 0? 
(result-test 0? 1 
  (eq (0? 0) T))

(result-test 0? 2
  (eq (0? 1) NIL))

(result-test 0? 3
  (eq (0? '()) NIL))

(result-test 0? 4
  (eq (0? -1) NIL))

(line)
;; 1?
(result-test 1? 1 
  (eq (1? 1) T))

(result-test 1? 2 
  (eq (1? 2) NIL))

(result-test 1? 3 
  (eq (1? 0) NIL))

(result-test 1? 4
  (eq (1? '()) NIL))

(line)
;; +?
(result-test +? 1 
  (eq (+? '(+ 1 2)) T))

(result-test +? 2 
  (eq (+? 2) NIL))

(result-test +? 3 
  (eq (+? '(- 1 2)) NIL))

(line)
;; -?
(result-test -? 1 
  (eq (-? '(- 1 2)) T))

(result-test -? 2 
  (eq (-? 2) NIL))

(result-test -? 3 
  (eq (-? '(+ 1 2)) NIL))

(result-test -? 4
  (eq (-? '(-)) NIL))


(line)
;; *?
(result-test *? 1 
  (eq (*? '(* 1 2)) T))

(result-test *? 2 
  (eq (*? 2) NIL))

(result-test *? 3 
  (eq (*? '(+ 1 2)) NIL))

(line)
;; /?
(result-test /? 1 
  (eq (/? '(/ 1 2)) T))

(result-test /? 2 
  (eq (/? 2) NIL))

(result-test /? 3 
  (eq (/? '(+ 1 2)) NIL))

(result-test -? 4
  (eq (-? '(/)) NIL))

(line)
;; expt?
(result-test expt? 1 
  (eq (expt? '(expt 1 2)) T))

(result-test expt? 2 
  (eq (expt? 2) NIL))

(result-test expt? 3 
  (eq (expt? '(+ 1 2)) NIL))

(result-test expt? 4
  (eq (expt? '(expt 10)) NIL))

(result-test expt? 5
  (eq (expt? '(expt 1 2 3)) NIL))

(line)
;; sqrt?
(result-test sqrt? 1 
  (eq (sqrt? '(sqrt 1)) T))

(result-test sqrt? 2 
  (eq (sqrt? 2) NIL))

(result-test sqrt? 3 
  (eq (sqrt? '(+ 1 2)) NIL))

(result-test sqrt? 4 
  (eq (sqrt? '(sqrt 1 2)) NIL))

(line)
;; sin?
(result-test sin? 1 
  (eq (sin? '(sin 1)) T))

(result-test sin? 2 
  (eq (sin? 2) NIL))

(result-test sin? 3 
  (eq (sin? '(+ 1 2)) NIL))

(result-test sin? 4 
  (eq (sin? '(sin 1 2)) NIL))

(line)
;; cos?
(result-test cos? 1 
  (eq (cos? '(cos 1)) T))

(result-test cos? 2 
  (eq (cos? 2) NIL))

(result-test cos? 3 
  (eq (cos? '(+ 1 2)) NIL))

(result-test cos? 4 
  (eq (cos? '(cos 1 2)) NIL))

(line)
;; tan?
(result-test tan? 1 
  (eq (tan? '(tan 1)) T))

(result-test tan? 2 
  (eq (tan? 2) NIL))

(result-test tan? 3 
  (eq (tan? '(+ 1 2)) NIL))

(result-test tan? 4 
  (eq (tan? '(tan 1 2)) NIL))

(line)
;; asin?
(result-test asin? 1 
  (eq (asin? '(asin 1)) T))

(result-test asin? 2 
  (eq (asin? 2) NIL))

(result-test asin? 3 
  (eq (asin? '(+ 1 2)) NIL))

(result-test asin? 4 
  (eq (asin? '(asin 1 2)) NIL))

(line)
;; acos?
(result-test acos? 1
  (eq (acos? '()) NIL))
(result-test acos? 2
  (eq (acos? '(acos)) NIL))
(result-test acos? 3
  (eq (acos? '(acos 45)) T))
(result-test acos? 4
  (eq (acos? '(acos 45 19)) NIL))
(result-test acos? 5 
  (eq (acos? 2) NIL))

(line)
;; atan?
(result-test atan? 1 
  (eq (atan? '(atan 1)) T))

(result-test atan? 2 
  (eq (atan? 2) NIL))

(result-test atan? 3 
  (eq (atan? '(+ 1 2)) NIL))

(result-test atan? 4 
  (eq (atan? '(atan 1 2)) NIL))

(line)
;; exp?
(result-test exp? 1 
  (eq (exp? '(exp 1)) T))

(result-test exp? 2 
  (eq (exp? 2) NIL))

(result-test exp? 3 
  (eq (exp? '(+ 1 2)) NIL))

(result-test exp? 4 
  (eq (exp? '(exp 1 2)) NIL))

(line)
;; log?
(result-test log? 1 
  (eq (log? '(log 2 3)) T))

(result-test log? 2 
  (eq (log? 2) NIL))

(result-test log? 3 
  (eq (log? '(+ 1 2)) NIL))

(result-test log? 4 
  (eq (log? '(log 1 2 3)) NIL))

(line)
(starline)
;; Задание 2. Конструкторы для выражений
;; make+
(result-test make+ 1
  (equal (make+ 2 3 4) '(+ 2 3 4)))

(result-test make+ 'lowargs
  (equal (make+) '(+)))

(line)
;; make-
(result-test make- 1
  (equal (make- 2 3 4) '(- 2 3 4)))

(error-test make- 2 T
  (equal (make-) '(- 2 3 4)))

(line)
;; make*
(result-test make* 1
  (equal (make* 2 3 4) '(* 2 3 4)))

(result-test make* 'lowargs
  (equal (make*) '(*)))

(line)
;; make/
(result-test make/ 1
  (equal (make/ 2 3 4) '(/ 2 3 4)))

(error-test make/ 'lowargs T
  (equal (make/) '(/ 2 3 4)))

(line)
;; makeexpt
(result-test makeexpt 1
  (equal (makeexpt 2 3) '(expt 2 3)))

(error-test makeexpt 'lowargs T
  (equal (makeexpt) '(- 2 3 4)))

(error-test makeexpt 'manyargs T
  (equal (makeexpt 2 3 4) '(- 2 3 4)))

(line)
;; makesqrt
(result-test makesqrt 1
  (equal (makesqrt 2) '(sqrt 2)))

(error-test makesqrt 'lowargs T
  (equal (makesqrt) '(- 2 3 4)))

(error-test makesqrt 'manyargs T
  (equal (makesqrt 2 3) '(- 2 3 4)))

(line)
;; makesin
(result-test makesin 1
  (equal (makesin 1) '(sin 1)))

(error-test makesin 'lowargs T
  (equal (makesin) '(- 2 3 4)))

(error-test makesin 'manyargs T
  (equal (makesin 2 3) '(- 2 3 4)))

(line)
;; makecos
(result-test makecos 1
  (equal (makecos 1) '(cos 1)))

(error-test makecos 'lowargs T
  (equal (makecos) '(- 2 3 4)))

(error-test makecos 'manyargs T
  (equal (makecos 2 3) '(- 2 3 4)))

(line)
;; maketan
(result-test maketan 1
  (equal (maketan 1) '(tan 1)))

(error-test maketan 'lowargs T
  (equal (maketan) '(- 2 3 4)))

(error-test maketan 'manyargs T
  (equal (maketan 2 3) '(- 2 3 4)))

(line)
;; makeasin
(result-test makeasin 1
  (equal (makeasin 1) '(asin 1)))

(error-test makesin 'lowargs T
  (equal (makesin) '(- 2 3 4)))

(error-test maketan 'manyargs T
  (equal (maketan 2 3) '(- 2 3 4)))

(line)
;; makeacos
(result-test makeacos 1
  (equal (makeacos 1) '(acos 1)))

(error-test makeacos 'lowargs T
  (equal (makeacos) '(- 2 3 4)))

(error-test makeacos 'manyargs T
  (equal (makeacos 2 3) '(- 2 3 4)))

(line)
;; makeatan
(result-test makeatan 1
  (equal (makeatan 1) '(atan 1)))

(error-test makeatan 'lowargs T
  (equal (makeatan) '(- 2 3 4)))

(error-test makeatan 'manyargs T
  (equal (makeatan 2 3) '(- 2 3 4)))

(line)
;; makeexp
(result-test makeexp 1
  (equal (makeexp 1) '(exp 1)))

(error-test makeexp 'lowargs T
  (equal (makeexp) '(- 2 3 4)))

(error-test makeexp 'manyargs T
  (equal (makeexp 2 3) '(- 2 3 4)))

(line)
;; makelog
(result-test makelog 1
  (equal (makelog 1 2) '(log 1 2)))

(error-test makelog 'lowargs T
  (equal (makelog) '(- 2 3 4)))

(error-test makelog 'manyargs T
  (equal (makelog 2 3 4) '(- 2 3 4)))

(result-test makelog 4
  (equal (makelog 1) '(log 1)))

(line)
(starline)
;; Задание 3. НОРМАЛИЗАЦИЯ ВЫРАЖЕНИЙ
;; +-normalize
(result-test +-normalize 1
  (equal (normalize '(+)) 0)) 

(result-test +-normalize 2
  (equal (normalize '(+ 1 2 3 4 5 6))
         '(+ 1 (+ 2 (+ 3 (+ 4 (+ 5 6))))))) 

(result-test +-normalize 3
  (equal (normalize '(+ 2 4 (+ X 3) 5 6))
         '(+ 2 (+ 4 (+ (+ X 3) (+ 5 6)))))) 

(line)
;; --normalize
(result-test --normalize 1
  (equal (normalize '(- 1 2 3 4))
         '(+ 1 (* -1 (+ 2 (+ 3 4))))))

(result-test --normalize 2
  (equal (normalize '(- 1 (- 2 3) 4))
         '(+ 1 (* -1 (+ (+ 2 (* -1 3)) 4)))))

(line)
;; *-normalize
(result-test *-normalize 1
  (equal (normalize '(*)) 1)) 

(result-test *-normalize 2
  (equal (normalize '(* 3 5 6 7)) 
         '(* 3 (* 5 (* 6 7))))) 

(line)
;; /-normalize
(error-test /-normalize 1 on-unknown-expression
  (equal (normalize '(/)) 1)) 

(result-test /-normalize 2
  (equal (normalize '(/ 3 5 6 7)) 
         '(* 3 (/ (* 5 (* 6 7)))))) 

(line)
;; expt-normalize
(result-test expt-normalize 1 
  (equal (normalize '(expt 2 1)) '(expt 2 1))) 

(error-test expt-normalize 'o-u-e on-unknown-expression
  (equal (normalize '(expt (2 4) (5 6))) 1)) 

(line)
;; sqrt-normalize
(result-test sqrt-normalize 1 
  (equal (normalize '(sqrt 4)) '(expt 4 1/2))) 

(error-test sqrt-normalize 'o-u-e on-unknown-expression
  (equal (normalize '(sqrt (2 4))) 1)) 

(line)
;; sin-normalize
(result-test sin-normalize 1 
  (equal (normalize '(sin x)) '(sin x))) 

(error-test sin-normalize 'o-u-e on-unknown-expression
  (equal (normalize '(sin (2 4))) 1)) 

(line)
;; cos-normalize
(result-test cos-normalize 1 
  (equal (normalize '(cos x)) '(cos x))) 

(error-test cos-normalize 'o-u-e on-unknown-expression
  (equal (normalize '(cos (2 4))) 1))

(line)
;; tan-normalize
(result-test tan-normalize 1 
  (equal (normalize '(tan x)) '(* (sin x) (/ (cos x))))) 

(line)
;; asin-normalize
(result-test asin-normalize 1 
  (equal (normalize '(asin x)) '(asin x)))

(error-test asin-normalize 'o-u-e on-unknown-expression
  (equal (normalize '(asin (2 4))) 1))

(line)
;; acos-normalize
(result-test acos-normalize 1 
  (equal (normalize '(acos x)) '(acos x))) 

(error-test acos-normalize 'o-u-e on-unknown-expression
  (equal (normalize '(acos (2 4))) 1))

(line)
;; atan-normalize
(result-test atan-normalize 1 
  (equal (normalize '(atan x)) '(atan x))) 

(error-test atan-normalize 'o-u-e on-unknown-expression
  (equal (normalize '(atan (2 4))) 1))

(line)
;; exp-normalize
(result-test exp-normalize 1 
  (equal (normalize '(exp x)) '(exp x))) 

(error-test exp-normalize 'o-u-e on-unknown-expression
  (equal (normalize '(exp (2 4))) 1))

(line)
;; log-normalize
(result-test log-normalize 1 
  (equal (normalize '(log x y)) '(* (log x) (/ (log y))))) 

(error-test log-normalize 'o-u-e on-unknown-expression
  (equal (normalize '(log (2 4))) 1))

(line)
;; общие тесты normalize
(result-test normalize 1 
  (equal (normalize '(+ x (- y 1 3))) '(+ x (+ y (* -1 (+ 1 3))))))

(error-test normalize 'o-u-e on-unknown-expression
  (equal (normalize '(2 4)) 1))

(line)
(starline)
;; УПРОЩЕНИЕ ВЫРАЖЕНИЙ
;; Задание 4. Упрощение сложения
;; simplify+
(result-test simplify+ 1 
  (= (simplify '(+ 3 8)) 11)) 

(result-test simplify+ 2
  (equal (SIMPLIFY '(+ 1 X 1 Y 4 Z 6 5 E R 8 9 6 7))
         '(+ 47 R E Z Y X)))

(line)
;; simplify+-aux1
(result-test simplify+-aux1 1 
  (= (simplify+-aux1 2 3) 5)) 

(result-test simplify+-aux1 2
  (equal (SIMPLIFY+-AUX1 '(+ X Y Z) 3) '(+ 3 X Y Z)))

(line)
;; simplify+-aux2
(result-test simplify+-aux2 1 
  (equal (simplify+-aux2 '3 '(+ 5 y)) '(+ 8 y))) 

(result-test simplify+-aux2 2
  (equal (SIMPLIFY+-AUX2 '(+ 3 X) '(+ 5 Y)) '(+ 8 Y X)))

(result-test simplify+-aux2 3
  (equal (SIMPLIFY+-AUX2 '(* Z Y) '(+ X Y)) '(+ X Y (* Z Y))))

(result-test simplify+-aux2 4
  (equal (SIMPLIFY+-AUX2 '(+ X Y) '(+ Z V)) '(+ X Y Z V)))

;; Задание 5. Упрощение умножения
(line)
;; simplify*
(result-test simplify* 1 
  (= (simplify '(* 3 8)) 24)) 

(result-test simplify* 2
  (equal (SIMPLIFY '(* (+ X 9) (+ Y 8))) '(+ 72 (* 9 Y) (* 8 X) (* X Y))))
(line)

(result-test simplify* 3
  (equal (SIMPLIFY '(* 5 Y U 7 9)) '(* 315 U Y)))

(result-test simplify* 4
  (equal (SIMPLIFY '(* (+ 2 3 X Z) Y U 5))
         '(+ (* 5 U Y X) (* 5 U Y Z) (* 25 U Y))))

;; simplify*-through+
(result-test simplify*-through+ 1 
  (equal (simplify*-through+ '(4 (+ 4 x) (* 5 y) (- x)) 3) 
         '((* 3 4) (* 3 (+ 4 x)) (* 3 (* 5 y)) (* 3 (- x))))) 

(line)
;; simplify*-aux1
(result-test simplify*-aux1 1 
  (= (simplify*-aux1 2 3) 6)) 

(result-test simplify*-aux1 2
  (equal (SIMPLIFY*-AUX1 '(+ (LOG X) (+ X Y)) 3)
         '(+ (* 3 X) (* 3 Y) (* 3 (LOG X)))))

(line)
;; simplify*-aux2
(result-test simplify*-aux2 1 
  (equal (simplify*-aux2 3 '(* 5 y)) '(* 15 y))) 

(result-test simplify*-aux2 2
  (equal (SIMPLIFY*-AUX2 '(* 3 Y) '(* 5 Y)) '(* 15 Y Y)))

(result-test simplify*-aux2 3
  (equal (SIMPLIFY*-AUX2 '(EXPT Z Y) '(* X Y)) '(* X Y (EXPT Z Y))))

(result-test simplify*-aux2 4
  (equal (SIMPLIFY*-AUX2 '(* U V) '(* 2 (+ X Y))) '(* 2 (+ X Y) * U V)))

;; Задание 6. Упрощение обратного элемента (унарного деления)
(line)
;; simplify/
(result-test simplify/ 1 
  (equal (simplify '(/ (/ (/ (/ x))))) 'x)) 

(result-test simplify/ 2
  (equal (SIMPLIFY/ '(/ (* X (* Y (* Z F)))))
         '(* (/ Y) (/ X) (/ F) (/ Z))))

(line)
;; simplify/-through*
(result-test simplify/-through* 1 
  (equal (simplify/-through* '(4 (+ 4 x) (* 5 y) (/ x))) 
         '((/ 4) (/ (+ 4 x)) (/ (* 5 y)) (/ (/ x)))))

(result-test simplify/-through* 2
  (equal (simplify/-through* '((* 4 x) 2))
         '((/ (* 4 X)) (/ 2))))

;; Задание 7. Упрощение возведения в степень
(line)
;; simplifyexpt
(result-test simplifyexpt 1 
  (equal (simplify '(expt x 1)) 'x)) 

(result-test simplifyexpt 2
  (= (SIMPLIFY '(EXPT 5 2)) 25))

(result-test simplifyexpt 3
  (= (SIMPLIFYEXPT '(EXPT 0 0)) 1))

;; Задание 8. Упрощение остальных функций
(line)
;; simplify-fun-1
(result-test simplify-fun-1 1 
  (= (simplify '(cos (sin 0))) 1)) 

(result-test simplify-fun-1 2
  (equal (SIMPLIFY-FUN-1 '(SIN (+ 3 (+ X Y))))
         '(SIN (+ 3 X Y))))
(line)
;; simplifyexp
(result-test simplifyexp 1 
  (= (simplify '(exp 0)) 1)) 

(result-test simplifyexp 2
  (= (simplify '(exp (log 2))) 2))

(line)
;; simplifylog
(result-test simplifylog 1 
  (eq (simplify '(log (exp x))) 'x)) 

(result-test simplifylog 2 
  (= (simplify '(log 1)) 0)) 

(result-test simplifylog 3
  (equal (SIMPLIFYLOG '(LOG (EXPT X Y))) '(* Y (LOG X))))

(result-test simplifylog 4
  (equal (SIMPLIFY '(LOG (+ X 5 Y))) '(LOG (+ 5 Y X))))

(line)
;; общие simplify
(result-test simplify 1 
  (equal (simplify '(- (+ (- (log (exp x)) 2)) 1)) '(+ -3 X))) 

(error-test simplify 2 on-unknown-expression 
  (equal (simplify '(- (+ (- (sinh (exp x)) 2)) 1)) '(+ -3 X))) 

(result-test simplify 3
  (equal (SIMPLIFY '(- (+ (- (EXPT (EXPT X 5) 5) X)) 1)) 
         '(+ -1 (EXPT X 25) (* -1 X))))


(line)
(starline)
;; ПРОИЗВОДНАЯ ВЫРАЖЕНИЯ
;; Задание 9. Производная суммы и разности
;; +-deriv
(result-test +-deriv 1 
  (= (simplify 
       (deriv (normalize '(+ x y (+ x y 5) 25 x)) 
              'x)) 
     3)) 
(result-test +-deriv 2
  (= (simplify (deriv (normalize '(+ (* 2 x) x)) 'x)) 3))

(line)
;; --deriv
(result-test --deriv 1 
  (= (simplify 
       (deriv (normalize '(- (- (- (- x))))) 
              'x)) 
     1)) 

(result-test +-deriv 2
  (= (simplify (deriv (normalize '(- (* 2 x) x)) 'x)) 1))

;; Задание 10. Производная произведения
(line)
;; *-deriv
(result-test *-deriv 1 
  (= (let ((x 2) (y 3))
       (declare (special x y))
       (eval 
         (deriv (normalize '(* x 5 x y)) 
                'x))) 
     60))

(result-test *-deriv 2 
  (= (let ((x 2) (y 3))
       (declare (special x y))
       (eval 
         (deriv (normalize '(* x y)) 
                'x))) 
     3))

;; Задание 11. Производная обратного элемента
(line)
;; /-deriv
(result-test /-deriv 1 
  (= (let ((x 2) (y 3))
       (declare (special x y))
       (eval 
         (deriv (normalize '(/ x 5 x y)) 
                'x))) 
     0))

(result-test /-deriv 1 
  (= (let ((x 2) (y 3))
       (declare (special x y))
       (eval 
         (deriv (normalize '(/ (* 3 x) y)) 
                'x))) 
     1))

;; Задание 12. Производная степенной функции
(line)
;; expt-deriv
(result-test expt-deriv 1 
  (= (let ((x 1))
       (declare (special x))
       (eval 
         (deriv '(expt x x) 'x))) 
     1.0))

(result-test expt-deriv 2 
  (= (let ((x 2))
       (declare (special x))
       (eval 
         (deriv '(expt x 3) 'x))) 
     12.0))

;; Задание 13. Производные тригонометрических функций
(line)
;; sin-deriv
(result-test sin-deriv 1 
  (let ((x (/ pi 4)))
    (declare (special x))
    (= (eval 
         (deriv '(sin x) 'x))
       (cos x))))

(result-test sin-deriv 2 
  (let ((x (/ pi 6)))
    (declare (special x))
    (= (eval 
         (deriv '(sin (+ x x)) 'x))
       (* (+ 1 1) (COS (+ X X))))))

(line)
;; cos-deriv
(result-test cos-deriv 1 
  (let ((x (/ pi 4)))
    (declare (special x))
    (= (eval 
         (deriv '(cos x) 'x))
       (- (sin x)))))

(result-test cos-deriv 2 
  (let ((x (/ pi 6)))
    (declare (special x))
    (= (eval 
         (deriv '(cos (+ x x)) 'x))
       (* -1 (+ 1 1) (SIN (+ X X))))))

;; Задание 14. Производные обратных тригонометрических функций
(line)
;; asin-deriv
(result-test asin-deriv 1 
  (let ((x 0))
    (declare (special x))
    (= (eval 
         (deriv '(asin x) 'x))
       1.0)))

(result-test asin-deriv 2 
  (let ((x 0))
    (declare (special x))
    (= (eval 
         (deriv '(asin (* 2 x)) 'x))
       2.0)))

(line)
;; acos-deriv
(result-test acos-deriv 1 
  (let ((x 0))
    (declare (special x))
    (= (eval 
         (deriv '(acos x) 'x))
       -1.0)))

(result-test acos-deriv 2 
  (let ((x 0))
    (declare (special x))
    (= (eval 
         (deriv '(acos (* 2 x)) 'x))
       -2.0)))

(line)
;; atan-deriv
(result-test atan-deriv 1 
  (let ((x 0))
    (declare (special x))
    (= (eval 
         (deriv '(atan x) 'x))
       1.0)))

(result-test atan-deriv 2 
  (let ((x 0))
    (declare (special x))
    (= (eval 
         (deriv '(atan (* 2 x)) 'x))
       2.0)))

;; Задание 15. Производные экспоненты и натурального логарифма
(line)
;; exp-deriv
(result-test exp-deriv 1 
  (equal (simplify (deriv '(exp x) 'x))
         '(exp x)))

(result-test exp-deriv 2
  (equal (simplify (deriv '(exp (* 2 x)) 'x))
         '(* 2 (EXP (* 2 X)))))

(line)
;; log-deriv
(result-test log-deriv 1 
  (equal (simplify (deriv '(log x) 'x))
         '(/ x)))

(result-test log-deriv 2
  (equal (simplify (deriv '(log (* 2 x)) 'x))
         '(* 1 (/ x))))
(line)
;; Производные произвольных выражений
(result-test deriv 1 
  (let ((expr '(+ (* x x) 
                  (sqrt (* x x))
                  (* x y)
                  (* 2 x x)))
        (x 2) (y 3))
    (declare (special x y))
    (= (eval (deriv (normalize expr) 'x))
       16)))

(error-test deriv 2 on-unknown-expression
  (eq (deriv '(sqrt x) 'x) NIL))

(result-test deriv 3 
  (let ((expr '(+ (* 2 (* x x) 
                  (sqrt (* x x))
                  (* x y x)
                  (* 2 x x x))))
        (x 2) (y 3))
    (declare (special x y))
    (= (eval (deriv (normalize expr) 'x))
       12288)))

(line)
(starline)