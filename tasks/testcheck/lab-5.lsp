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
(defun makeexpt (a b) (list 'expt a b))
;; makesqrt
(defun makesqrt (a) (list 'sqrt a))
;; makesin
(defun makesin (a) (list 'sin a))
;; makecos
(defun makecos (a) (list 'cos a))
;; maketan
(defun maketan (a) (list 'tan a))
;; makeasin
(defun makeasin (a) (list 'asin a))
;; makeacos
(defun makeacos (a) (list 'acos a))
;; makeatan
(defun makeatan (a) (list 'atan a))
;; makeexp
(defun makeexp (a) (list 'exp a))
;; makelog
(defun makelog (a &optional b) 
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
      (make* -1 (normalize (car tl))) 
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
      (make/ (normalize (car tl))) 
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
        (makelog (normalize (car tl)))
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
                                   (apply 'make+ n (cdr expr)))))
    (T (make+ n expr))))
;; simplify+-aux2
(defun simplify+-aux2 (expr +expr)
  (cond
    ((numberp expr) (simplify+-aux1 +expr expr))
    ((+? expr) 
      (if (numberp (cadr expr))
          (simplify+-aux1 (apply 'make+ (append (cdr +expr) (cddr expr)))
                          (cadr expr))
          (if (numberp (cadr +expr))
              (simplify+-aux1 (apply 'make+ 
                                (append (cddr +expr) (cdr expr))) (cadr +expr))
              (apply 'make+ (append (cdr expr) (list (cdr +expr)))))))
    (T (append +expr (list expr)))))
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
      ((and (/? fst) (equal (cadr fst) scnd)) 1)
      ((and (/? scnd) (equal (cadr scnd) fst)) 1)
      ((+? fst) (simplify (apply 'make+ (simplify*-through+ (cdr fst) scnd))))
      ((+? scnd) (simplify (apply 'make+ (simplify*-through+ (cdr scnd) fst))))
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
                                   (apply 'make* n (cdr expr)))))
    ((+? expr) (simplify (apply 'make+ (simplify*-through+ (cdr expr) n))))
    (T (make* n expr))))
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
    ((+? expr) (simplify (apply 'make+ (simplify*-through+ (cdr expr) *expr))))
    (T (append *expr (list expr)))))
;; Задание 6. Упрощение обратного элемента (унарного деления)
;; simplify/
(defun simplify/ (expr)
  (let ((tlel (simplify (cadr expr))))
    (cond
      ((numberp tlel) (/ 1 tlel))
      ((/? tlel) (cadr tlel))
      ((*? tlel) (simplify (apply 'make* (simplify/-through* (cdr tlel)))))
      (T (make/ tlel)))))
;; simplify/-through*
(defun simplify/-through* (exprs)
  (let ((tl (cdr exprs)))
    (if (null tl) (cons (make/ (car exprs)) ()) 
                  (cons (make/ (car exprs)) (simplify/-through* tl)))))
;; Задание 7. Упрощение возведения в степень
;; simplifyexpt
(defun simplifyexpt (expr)
  (let* ((tl (cdr expr)) 
         (fst (simplify (car tl))) 
         (scnd (simplify (cadr tl))))
    (cond
      ((0? fst) 0)
      ((0? scnd) 1)
      ((1? fst) 1)
      ((1? scnd) fst)
      ((and (numberp fst) (numberp scnd)) (eval expr))
      ((expt? fst) 
        (let ((ab (cdr fst))) 
          (simplify (makeexpt (car ab) (make* (cadr ab) scnd)))))
      ((exp? fst) (simplify (makeexp (make* (cadr fst) scnd))))
      (T (makeexpt fst scnd)))))
;; Задание 8. Упрощение остальных функций
;; simplify-fun-1
(defun simplify-fun-1 (expr)
  (let* ((tl (simplify (cadr expr))) (newe (cons (car expr) (cons tl ()))))
    (if (numberp tl) (eval newe) newe)))
;; simplifyexp
(defun simplifyexp (expr)
  (let* ((tl (simplify (cadr expr))) (newe (cons (car expr) (cons tl ()))))
    (cond
      ((numberp tl) (eval newe))
      ((log? tl) (cadr tl))
      (T newe))))
;; simplifylog
(defun simplifylog (expr)
  (let ((tlel (simplify (cadr expr))))
    (cond
      ((numberp tlel) (log tlel))
      ((exp? tlel) (cadr tlel))
      ((expt? tlel) 
        (let ((ab (cdr tlel))) 
          (simplify (apply 'make* (cadr ab) (list (makelog (car ab)))))))
      (T (makelog tlel)))))
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
(defun +-deriv (expr x)
  (let ((uv (cdr expr)))
    (make+ (deriv (car uv) x) (deriv (cadr uv) x))))
;; Задание 10. Производная произведения
;; *-deriv
(defun *-deriv (expr x)
  (let* ((uv (cdr expr)) 
         (u (car uv)) 
         (v (cadr uv)))
    (make+ (make* (deriv u x) v)
           (make* (deriv v x) u))))
;; Задание 11. Производная обратного элемента
;; /-deriv
(defun /-deriv (expr x)
  (let* ((u (cadr expr))
         (delu (make/ u)))
    (make* -1 delu delu (deriv u x))))
;; Задание 12. Производная степенной функции
;; expt-deriv
(defun expt-deriv (expr x)
  (let* ((uv (cdr expr))
         (u (car uv))
         (v (cadr uv)))
    (make+ (make* v 
                  (makeexpt u (make- v 1)) 
                  (deriv u x))
           (make* (makeexpt u v) (deriv v x) (makelog u)))))
;; Задание 13. Производные тригонометрических функций
;; sin-deriv
(defun sin-deriv (expr x)
  (let ((u (cadr expr)))
    (make* (deriv u x)
           (makecos u))))
;; cos-deriv
(defun cos-deriv (expr x)
  (let ((u (cadr expr)))
    (make* -1
           (deriv u x)
           (makesin u))))
;; Задание 14. Производные обратных тригонометрических функций
;; asin-deriv
(defun asin-deriv (expr x)
  (let ((u (cadr expr)))
    (make/ (deriv u x)
           (makesqrt (make- 1 
                            (make* u u))))))
;; acos-deriv
(defun acos-deriv (expr x)
  (let ((u (cadr expr)))
    (make* -1 (make/ (deriv u x)
                     (makesqrt (make- 1 
                                      (make* u u)))))))
;; atan-deriv
(defun atan-deriv (expr x)
  (let ((u (cadr expr)))
    (make/ (deriv u x)
           (makesqrt (make+ 1 
                            (make* u u))))))
;; Задание 15. Производные экспоненты и натурального логарифма
;; exp-deriv
(defun exp-deriv (expr x)
  (let ((u (cadr expr)))
    (make* (makeexp u) (deriv u x))))
;; log-deriv
(defun log-deriv (expr x)
  (let ((u (cadr expr)))
    (make* (make/ u) (deriv u x))))