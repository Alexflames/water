;;; Шаблон для выполнения заданий Лабораторной работы №5 
;;; ВСЕ КОММЕНТАРИИ ПРИВЕДЕННЫЕ В ДАННОМ ФАЙЛЕ ДОЛЖНЫ ОСТАТЬСЯ НА СВОИХ МЕСТАХ
;;; НЕЛЬЗЯ ПЕРЕСТАВЛЯТЬ МЕСТАМИ КАКИЕ-ЛИБО БЛОКИ ДАННОГО ФАЙЛА
;;; решения заданий должны быть вписаны в отведенные для этого позиции 

;;; ВСПОМОГАТЕЛЬНЫЕ ОПРЕДЕЛЕНИЯ 
;;; Нельзя вносить изменения в следующий блок
;; отключение предупреждений (т.к. предполагается использование
;; взаимной рекурсии и будут предупреждения об использовании 
;; неописанных функций)
(declaim (sb-ext:muffle-conditions style-warning))

;; определяется исключение on-unknown-expression
;; которое предполагается поднимать при получении 
;; неизвестного выражения
(define-condition on-unknown-expression (error)
   ((message :initarg :message :reader message))
)

;;; РЕШЕНИЕ ЗАДАНИЙ 

;; Задание 1. Предикаты для выражений 
;; 0? 
(defun 0? (f) (and (numberp f) (zerop f)))
;; 1?
(defun 1? (f) (and (numberp f) (zerop (- f 1))))
;; +?
(defun +? (f) (and (listp f) (eq (car f) '+)))
;; -?
(defun -? (f) (and (and (listp f) (eq (car f) '-)
                   (not (null (cdr f))))))
;; *?
(defun *? (f) (and (listp f) (eq (car f) '*)))
;; /?
(defun /? (f) (and (and (listp f) (eq (car f) '/)
                   (not (null (cdr f))))))
;; expt?
(defun expt? (f) (and (and (listp f) (eq (car f) 'expt))
                      (and (null (cdddr f)) (not (null (caddr f))))))
;; sqrt?
(defun sqrt? (f) (and (and (listp f) (eq (car f) 'sqrt))
                      (and (null (cddr f)) (not (null (cadr f))))))
;; sin?
(defun sin? (f) (and (and (listp f) (eq (car f) 'sin))
                     (and (null (cddr f)) (not (null (cadr f))))))
;; cos?
(defun cos? (f) (and (and (listp f) (eq (car f) 'cos))
                     (and (null (cddr f)) (not (null (cadr f))))))
;; tan?
(defun tan? (f) (and (and (listp f) (eq (car f) 'tan))
                     (and (null (cddr f)) (not (null (cadr f))))))
;; asin?
(defun asin? (f) (and (and (listp f) (eq (car f) 'asin))
                      (and (null (cddr f)) (not (null (cadr f))))))
;; acos?
(defun acos? (f) (and (and (listp f) (eq (car f) 'acos))
                      (and (null (cddr f)) (not (null (cadr f))))))
;; atan?
(defun atan? (f) (and (and (listp f) (eq (car f) 'atan))
                      (and (null (cddr f)) (not (null (cadr f))))))
;; exp?
(defun exp? (f) (and (and (listp f) (eq (car f) 'exp))
                     (and (null (cddr f)) (not (null (cadr f))))))
;; log?
(defun log? (f) (and (and (listp f) (eq (car f) 'log)
                     (and (null (cdddr f)) (not (null (cadr f)))))))
                         

;; Задание 2. Конструкторы для выражений
;; make+
(defun make+ (&rest args) (cons '+ args))
;; make-
(defun make- (a &rest args) (cons '- (cons a args)))
;; make*
(defun make* (&rest args) (cons '* args))
;; make/
(defun make/ (a &rest args) (cons '/ (cons a args)))
;; makeexpt
(defun makeexpt (a b &rest args) (list 'expt a b))
;; makesqrt
(defun makesqrt (a &rest args) (list 'sqrt a))
;; makesin
(defun makesin (a &rest args) (list 'sin a))
;; makecos
(defun makecos (a &rest args) (list 'cos a))
;; maketan
(defun maketan (a &rest args) (list 'tan a))
;; makeasin
(defun makeasin (a &rest args) (list 'asin a))
;; makeacos
(defun makeacos (a &rest args) (list 'acos a))
;; makeatan
(defun makeatan (a &rest args) (list 'atan a))
;; makeexp
(defun makeexp (a &rest args) (list 'exp a))
;; makelog
(defun makelog (a &optional b &rest args) 
  (if (null b) (list 'log a) (list 'log a b)))

;; Задание 3. НОРМАЛИЗАЦИЯ ВЫРАЖЕНИЙ
;; Следующая функция должна остаться без изменений
(defun normalize (expr)
  (cond 
    ((atom expr) expr)  
    ((+? expr) (+-normalize expr))
    ((-? expr) (--normalize expr))
    ((*? expr) (*-normalize expr))
    ((/? expr) (/-normalize expr))
    ((expt? expr) (expt-normalize expr))
    ((sqrt? expr) (sqrt-normalize expr))
    ((sin? expr) (sin-normalize expr))
    ((cos? expr) (cos-normalize expr))
    ((tan? expr) (tan-normalize expr))
    ((asin? expr) (asin-normalize expr))
    ((acos? expr) (acos-normalize expr))
    ((atan? expr) (atan-normalize expr))
    ((exp? expr) (exp-normalize expr))
    ((log? expr) (log-normalize expr))
    (T (error 'on-unknown-expression))))

;; +-normalize
(defun +-normalize (expr)
  (let* ((tl (cdr expr)) 
         (ttl (cdr tl)))
  (if (null tl) 0
    (if (null ttl) 
      (normalize (car tl)) 
      (make+ (normalize (car tl)) (+-normalize (cons '+ ttl)))))))

;; --normalize
(defun --normalize (expr)
  (let* ((tl (cdr expr)) 
         (ttl (cdr tl)))
    (if (null ttl) 
      (make* (cons -1 (cons (normalize (car tl)) ()))) 
      (make+ 
        (normalize (car tl)) 
        (cons '* (cons -1 (cons (+-normalize (cons '+ ttl)) ())))))))

;; *-normalize
(defun *-normalize (expr)
  (let* ((tl (cdr expr)) 
         (ttl (cdr tl)))
    (if (null tl) 1
      (if (null ttl) 
        (normalize (car tl)) 
        (make* (normalize (car tl)) (*-normalize (cons '* ttl)))))))
;; /-normalize
(defun /-normalize (expr)
  (let* ((tl (cdr expr)) 
         (ttl (cdr tl)))
    (if (null ttl) 
      (make/ (cons (normalize (car tl)) ())) 
      (make* (normalize (car tl)) 
        (cons '/ (cons (*-normalize (cons '* ttl)) ()))))))
;; expt-normalize
(defun expt-normalize (expr) 
  (makeexpt (normalize (cadr expr)) (normalize (caddr expr))))

;; sqrt-normalize
(defun sqrt-normalize (expr)
  (makeexpt (normalize (cadr expr)) 1/2))

;; sin-normalize
(defun sin-normalize (expr) (makesin (normalize (cadr expr))))
;; cos-normalize
(defun cos-normalize (expr) (makecos (normalize (cadr expr))))
;; tan-normalize
(defun tan-normalize (expr)
  (let ((tlel (normalize (cadr expr))))
    (make* (makesin tlel) (make/ (makecos tlel)))))
;; asin-normalize
(defun asin-normalize (expr) (makeasin (normalize (cadr expr))))
;; acos-normalize
(defun acos-normalize (expr) (makeacos (normalize (cadr expr))))
;; atan-normalize
(defun atan-normalize (expr) (makeatan (normalize (cadr expr))))
;; exp-normalize
(defun exp-normalize (expr) (makeexp (normalize (cadr expr))))
;; log-normalize
(defun log-normalize (expr) 
  (let* ((tl (cdr expr)) (ttl (cdr tl)))
      (if (null ttl) 
        (normalize (car tl))
        (make* 
          (makelog (normalize (car tl)))
          (make/ (makelog (normalize (car ttl))))))))

;; УПРОЩЕНИЕ ВЫРАЖЕНИЙ
;; Следующая функция должна остаться без изменений
(defun simplify (expr)
  (let ((expr (normalize expr)))
    (cond 
      ((atom expr) expr)
      ((+? expr) (simplify+ expr))
      ((*? expr) (simplify* expr))
      ((/? expr) (simplify/ expr))
      ((expt? expr) (simplifyexpt expr))
      ((sin? expr) (simplify-fun-1 expr))
      ((cos? expr) (simplify-fun-1 expr))
      ((asin? expr) (simplify-fun-1 expr))
      ((acos? expr) (simplify-fun-1 expr))
      ((atan? expr) (simplify-fun-1 expr))
      ((exp? expr) (simplifyexp expr))
      ((log? expr) (simplifylog expr))
      (T (error 'on-unknown-expression)))))

;; Задание 4. Упрощение сложения
;; simplify+
(defun simplify+ (expr)
  (let* ((tl (cdr expr)) 
         (fst (simplify (car tl))) 
         (scnd (simplify (cadr tl))))
    (cond
      ((0? fst) scnd)
      ((0? scnd) fst)
      ((numberp fst) (simplify+-aux1 scnd fst))
      ((numberp scnd) (simplify+-aux1 fst scnd))
      ((+? fst) (simplify+-aux2 scnd fst))
      ((+? scnd) (simplify+-aux2 fst scnd))
      (T (make+ fst scnd)))))
;; simplify+-aux1
(defun simplify+-aux1 (expr n)
  (cond
    ((numberp expr) (+ expr n))
    ((+? expr) (let ((fst (cadr expr))) 
                 (if (numberp fst) (apply 'make+ (+ fst n) (cddr expr))
                                   (make+ n expr))))
    (T (make+ expr n))))
;; simplify+-aux2
(defun simplify+-aux2 (expr +expr)
  (cond
    ((numberp expr) (simplify+-aux1 +expr expr))
    ((+? expr) 
      (if (numberp (cadr expr))
          (simplify+-aux1 (apply 'make+ (append (cdr +expr) (cddr expr)))
                          (cadr expr))
          (if (numberp (cadr +expr))
              (simplify+-aux1 (append (cddr +expr) expr) (cadr +expr))
              (apply 'make+ (append (cdr expr) (cdr +expr))))))
    (T (append +expr expr))))
;; Задание 5. Упрощение умножения
;; simplify*
(defun simplify* (expr)
  (let* ((tl (cdr expr)) 
         (fst (simplify (car tl))) 
         (scnd (simplify (cadr tl))))
    (cond
      ((0? fst) 0)
      ((0? scnd) 0)
      ((1? fst) scnd)
      ((1? scnd) fst)
      ((numberp fst) (simplify*-aux1 scnd fst))
      ((numberp scnd) (simplify*-aux1 fst scnd))
      ((*? fst) (simplify*-aux2 scnd fst))
      ((*? scnd) (simplify*-aux2 fst scnd))
      ((and (/? fst) (equal (cadr fst) (scnd))) 1)
      ((and (/? scnd) (equal (cadr scnd) (fst))) 1)
      ((+? fst) (simplify*-through+ fst scnd))
      ((+? scnd) (simplify*-through+ scnd fst))
      (T (make* fst scnd)))))
;; simplify*-through+
(defun simplify*-through+ (exprs n)
  (let ((tl (cdr exprs)))
    (if (null tl) (cons (make* n (car exprs)) ()) 
                  (cons (make* n (car exprs)) (simplify*-through+ tl n)))))
;; simplify*-aux1
(defun simplify*-aux1 (expr n)
  (cond
    ((numberp expr) (* expr n))
    ((*? expr) (let ((fst (cadr expr))) 
                 (if (numberp fst) (apply 'make* (* fst n) (cddr expr))
                                   (make* n expr))))
    ((+? expr) (simplify*-through+ expr n))
    (T (make* expr n))))
;; simplify*-aux2
(defun simplify*-aux2 (expr *expr)
  (cond
    ((numberp expr) (simplify*-aux1 *expr expr))
    ((*? expr) 
      (if (numberp (cadr expr))
          (simplify*-aux1 (apply 'make* (append (cdr *expr) (cddr expr)))
                          (cadr expr))
          (if (numberp (cadr *expr))
              (simplify*-aux1 (append (cddr *expr) expr) (cadr *expr))
              (apply 'make* (append (cdr expr) (cdr *expr))))))
    ((+? expr) (simplify*-through+ expr *expr))
    (T (append *expr expr))))
;; Задание 6. Упрощение обратного элемента (унарного деления)
;; simplify/

;; simplify/-through*

;; Задание 7. Упрощение возведения в степень
;; simplifyexpt

;; Задание 8. Упрощение остальных функций
;; simplify-fun-1

;; simplifyexp

;; simplifylog

;; ПРОИЗВОДНАЯ ВЫРАЖЕНИЯ
;; Следующая функция должна остаться без изменений
(defun deriv (expr var) 
  (cond 
    ((atom expr) (if (eq expr var) 1 0))  
    ((+? expr) (+-deriv expr var))
    ((*? expr) (*-deriv expr var))
    ((/? expr) (/-deriv expr var))
    ((expt? expr) (expt-deriv expr var))
    ((sin? expr) (sin-deriv expr var))
    ((cos? expr) (cos-deriv expr var))
    ((asin? expr) (asin-deriv expr var))
    ((acos? expr) (acos-deriv expr var))
    ((atan? expr) (atan-deriv expr var))
    ((exp? expr) (exp-deriv expr var))
    ((log? expr) (log-deriv expr var))
    (T (error 'on-unknown-expression))))

;; Задание 9. Производная суммы 
;; +-deriv

;; Задание 10. Производная произведения
;; *-deriv

;; Задание 11. Производная обратного элемента
;; /-deriv

;; Задание 12. Производная степенной функции
;; expt-deriv

;; Задание 13. Производные тригонометрических функций
;; sin-deriv

;; cos-deriv

;; Задание 14. Производные обратных тригонометрических функций
;; asin-deriv

;; acos-deriv

;; atan-deriv

;; Задание 15. Производные экспоненты и натурального логарифма
;; exp-deriv

;; log-deriv
