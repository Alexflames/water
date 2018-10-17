(defmacro while-less (e1 &body e2)
  ;; генерируем два вспомогательных идентитфикатора. Один сохраняем
  ;; в переменной func-name, второй - в переменной param-name. 
  ;; Первый идентификатор будем использовать как имя нашей рекурсивной 
  ;; функции для цикла, а второй - как имя формального параметра этой функции
  (let ((func-name (gensym))
        (param-name (gensym)))
    ;; определяем тело самой макроподстановки с указанными параметрами.
    ;; Заменяем вызов макроса на определение локальной функции
    ;; (с помощью labels) с дальнейшим вызовом этой функции.
    ;; Дальнейшие комментарии касаются ее функционирования.
    ;; Параметр локальной функции - значение выражения e1 
    `(labels ((,func-name (,param-name) 
                ;; вычисляем  последовательно все выражения, входящие в e2
                ;; Для этого  поместим все элементы из e2 в тело выражения 
                ;; progn. Вычисление такого progn выдаст нам значение 
                ;; последнего выражения из e2. Полученное значение
                ;; сохраняем в переменной new-e2 
                ;; после этого вычисления нет обращения к параметрам макроса 
                ;; напрямую, поэтому использование new-e2 не приведет к 
                ;; появлению протечек
                (let ((new-e2 (progn ,@e2)))
                  ;; сравниваем полученное значение с параметром функции
                  (if (< new-e2 ,param-name) 
                      ;; если условие цикла выполняется, то вызываем функцию
                      ;; рекурсивно
                      (,func-name ,param-name)
                      ;; иначе выдаем вычисленный результат 
                      new-e2))))
       (,func-name ,e1)))) ; начальный вызов функции от выражения, 
                           ; переданного в качестве e1. Выражение
                           ; вычислится только один раз - перед передачей 
                           ; его значения в качестве фыактического
                           ; параметра 
(defmacro sum-range ((parameter start-value end-value) &body body)
  (let ((func-name (gensym))
        (param-val (gensym)))
    `(labels ((,func-name (,param-val)
                (let (( )))
                  (if (< ,param-val ,end-value)
                      (progn (eval ,@body)
                             (,func-name (1+ ,param-val)))
                             (eval ,@body)))
       (,func-name ,start-value))))

;; Решение для примера задания 3
(defun y (n)
  (let ((i 1)   ; параметр суммы
        j       ; параметр произведения (декларация)
        (sum 0) ; аккумулятор для суммы
        prod    ; аккумулятор для произведения (декларация)
        ;; функция для выражения, вычисляемого в цикле
        (func-ij (lambda (i j) (+ (/ i j) (* i i 1/2))))
        (max-n (+ 1 n))) ; для того, чтобы не повторять выражение (+ n 1)
    ;; т.к. while-less вычисляет второе выражение минимум один раз, то нужна
    ;; следующая проверка, на случай n = 0, когда нет ни одного слагаемого
    (if (< i max-n) ; if без ветви else
        (while-less max-n
          ;; не делаем проверку (< j max-n), т.к. начальное значение j
          ;; не больше начального i, а i уже сравнивали с max-n
          (setq j 1)
          (setq prod 1)
          (while-less max-n
            (setq prod (* prod (funcall func-ij i j)))
            (incf j)) 
          (incf sum prod)
          (incf i)))                      
    sum)) ; возвращаем значение переменной sum как результат let

;; примеры запуска
; (print (y 5))
; (print (y 7))
; (print (y 15))