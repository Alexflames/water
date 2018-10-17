;;; ������ ��� ���������� ������� ������������ ������ �5 
;;; ��� ����������� ����������� � ������ ����� ������ �������� �� ����� ������
;;; ������ ������������ ������� �����-���� ����� ������� �����
;;; ������� ������� ������ ���� ������� � ���������� ��� ����� ������� 

;;; ��������������� ����������� 
;;; ������ ������� ��������� � ��������� ����
;; ���������� �������������� (�.�. �������������� �������������
;; �������� �������� � ����� �������������� �� ������������� 
;; ����������� �������)
(declaim (sb-ext:muffle-conditions style-warning))

;; ������������ ���������� on-unknown-expression
;; ������� �������������� ��������� ��� ��������� 
;; ������������ ���������
(define-condition on-unknown-expression (error)
   ((message :initarg :message :reader message))
)

;;; ������� ������� 

;; ������� 1. ��������� ��� ���������
;; 0? 
(defun 0? (x) (cond ((numberp x) (eq x 0))))
;; 1?
(defun 1? (x) (cond ((numberp x) (eq x 1))))
;; +?
(defun +? (x)
  (cond ((listp x) (and (> (length x) 0) (equal (car x) '+)))))
;; -?
(defun -? (x)
  (cond ((listp x) (and (> (length x) 1) (equal (car x) '-)))))
;; *?
(defun *? (x)
  (cond ((listp x) (and (> (length x) 0) (equal (car x) '*)))))
;; /?
(defun /? (x)
  (cond ((listp x) (and (> (length x) 1) (equal (car x) '/)))))
;; expt?
(defun expt? (x)
  (cond ((listp x) (and (eq (length x) 3) (equal (car x) 'expt)))))
;; sqrt?
(defun sqrt? (x)
  (cond ((listp x) (and (eq (length x) 2) (equal (car x) 'sqrt)))))
;; sin?
(defun sin? (x)
  (cond ((listp x) (and (eq (length x) 2) (equal (car x) 'sin)))))
;; cos?
(defun cos? (x)
  (cond ((listp x) (and (eq (length x) 2) (equal (car x) 'cos)))))
;; tan?
(defun tan? (x)
  (cond ((listp x) (and (eq (length x) 2) (equal (car x) 'tan)))))
;; asin?
(defun asin? (x)
  (cond ((listp x) (and (eq (length x) 2) (equal (car x) 'asin)))))
;; acos?
(defun acos? (x)
  (cond ((listp x) (and (eq (length x) 2) (equal (car x) 'acos)))))
;; atan?
(defun atan? (x)
  (cond ((listp x) (and (eq (length x) 2) (equal (car x) 'atan)))))
;; exp?
(defun exp? (x)
  (cond ((listp x) (and (eq (length x) 2) (equal (car x) 'exp)))))
;; log?
(defun log? (x)
  (cond ((listp x) (and (or (eq (length x) 2)
                            (eq (length x) 3))
                        (equal (car x) 'log)))))

;; ������� 2. ������������ ��� ���������
;; make+
(defun make+ (&rest x) (append '(+) x))
;; make-
(defun make- (x1 &rest xs) (append (list '- x1) xs))
;; make*
(defun make* (&rest x) (append '(*) x))
;; make/
(defun make/ (x1 &rest xs) (append (list '/ x1) xs))
;; makeexpt
(defun makeexpt (x1 x2) (list 'expt x1 x2))
;; makesqrt
(defun makesqrt (x) (list 'sqrt x))
;; makesin
(defun makesin (x) (list 'sin x))
;; makecos
(defun makecos (x) (list 'cos x))
;; maketan
(defun maketan (x) (list 'tan x))
;; makeasin
(defun makeasin (x) (list 'asin x))
;; makeacos
(defun makeacos (x) (list 'acos x))
;; makeatan
(defun makeatan (x) (list 'atan x))
;; makeexp
(defun makeexp (x) (list 'exp x))
;; makelog
(defun makelog (x1 &optional x2)
  (if (eq x2 NIL)
      (list 'log x1)
      (list 'log x1 x2)))

;; ������� 3. ������������ ���������
;; ��������� ������� ������ �������� ��� ���������
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
  (let ((e1 (normalize (cadr expr)))
        (len (length expr)))
    (cond
      ((eq len 1) 0)
      ((eq len 2) e1)
      ((eq len 3) (make+ e1 (normalize (caddr expr))))
      (T (make+ e1 (normalize (append '(+) (cddr expr))))))))
;; --normalize
(defun --normalize (expr)
  (let ((e1 (normalize (cadr expr))))
    (cond
      ((eq (length expr) 2) (make* -1 e1))
      (T (make+ e1
               (make* -1
                     (normalize (append '(+) (cddr expr)))))))))
;; *-normalize
(defun *-normalize (expr)
  (let ((e1 (normalize (cadr expr)))
        (len (length expr)))
    (cond
      ((eq len 1) 1)
      ((eq len 2) e1)
      ((eq len 3) (make* e1 (normalize (caddr expr))))
      (T (make* e1 (normalize (append '(*) (cddr expr))))))))
;; /-normalize
(defun /-normalize (expr)
  (let ((e1 (normalize (cadr expr))))
    (cond
      ((eq (length expr) 2) (make/ e1))
      (T (make* e1
                (make/ (normalize (append '(*) (cddr expr)))))))))
;; expt-normalize
(defun expt-normalize (expr)
  (makeexpt
    (normalize (cadr expr))
    (normalize (caddr expr))))
;; sqrt-normalize
(defun sqrt-normalize (expr)
  (makeexpt
    (normalize (cadr expr))
    1/2))
;; sin-normalize
(defun sin-normalize (expr)
  (makesin
    (normalize (cadr expr))))
;; cos-normalize
(defun cos-normalize (expr)
  (makecos
    (normalize (cadr expr))))
;; tan-normalize
(defun tan-normalize (expr)
  (let ((e (normalize (cadr expr))))
    (make*
      (makesin e)
      (make/ (makecos e)))))
;; asin-normalize
(defun asin-normalize (expr)
  (makeasin
    (normalize (cadr expr))))
;; acos-normalize
(defun acos-normalize (expr)
  (makeacos
    (normalize (cadr expr))))
;; atan-normalize
(defun atan-normalize (expr)
  (makeatan
    (normalize (cadr expr))))
;; exp-normalize
(defun exp-normalize (expr)
  (makeexp
    (normalize (cadr expr))))
;; log-normalize
(defun log-normalize (expr)
  (let ((e1 (normalize (cadr expr))))
    (cond
      ((eq (length expr) 2) (makelog e1))
      (T (make*
           (makelog e1)
             (make/
               (makelog
                 (normalize (caddr expr)))))))))
;; ��������� ���������
;; ��������� ������� ������ �������� ��� ���������
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

;; ������� 4. ��������� ��������
;; simplify+
(defun simplify+ (expr)
  (let ((e1 (simplify (cadr expr)))
        (e2 (simplify (caddr expr))))
    (cond
      ((numberp e1) 
        (if (= e1 0)
            e2
            (simplify+-aux1 e2 e1)))
      ((numberp e2)
        (if (= e2 0)
            e1
            (simplify+-aux1 e1 e2)))
      ((+? e1) (simplify+-aux2 e2 e1))
      ((+? e2) (simplify+-aux2 e1 e2))
      (T (make+ e1 e2)))))
;; simplify+-aux1
(defun simplify+-aux1 (expr n)
  (cond
    ((numberp expr) (+ expr n))
    ((+? expr)
      (let ((e1 (cadr expr)))
        (if (numberp e1)
            (append (make+ (+ n e1)) (cddr expr))
            (append (make+ n) (cdr expr)))))
    (T (make+ n expr))
    )
  )
;; simplify+-aux2
(defun simplify+-aux2 (expr +expr)
  (cond
    ((numberp expr) (simplify+-aux1 +expr expr))
    ((+? expr)
      (let ((e1 (cadr expr))
            (+e1 (cadr +expr)))
      (cond
        ((numberp e1) (simplify+-aux1
                        (append +expr (cddr expr))
                        e1))
        ((numberp +e1) (simplify+-aux1
                         (append expr (cddr +expr))
                         +e1))
        (T (append '(+) (cdr expr) (cdr +expr))))))
    (T (append +expr (list expr)))))
;; ������� 5. ��������� ���������
;; simplify*
(defun simplify* (expr)
  (let ((e1 (simplify (cadr expr)))
        (e2 (simplify (caddr expr))))
    (cond
      ((numberp e1)
        (cond
          ((= e1 0) 0)
          ((= e1 1) e2)
          (T (simplify*-aux1 e2 e1))))
      ((numberp e2)
        (cond
          ((= e2 0) 0)
          ((= e2 1) e1)
          (T (simplify*-aux1 e1 e2))))
      ((*? e1) (simplify*-aux2 e2 e1))
      ((*? e2) (simplify*-aux2 e1 e2))
      ((and (/? e1)
            (eq (cadr e1) e2))
         1)
      ((and (/? e2)
            (eq (cadr e2) e1))
         1)
      ((+? e1)
        (simplify (append '(+)
                          (simplify*-through+ (cdr e1) e2))))
      ((+? e2)
        (simplify (append '(+)
                          (simplify*-through+ (cdr e2) e1))))
      (T (make* e1 e2)))))
;; simplify*-through+
(defun simplify*-through+ (exprs n)
  (if (= (length exprs) 1)
      (list (make* n (car exprs)))
      (append
        (list (make* n (car exprs)))
        (simplify*-through+ (cdr exprs) n))))
;; simplify*-aux1
(defun simplify*-aux1 (expr n)
  (cond
    ((numberp expr) (* expr n))
    ((*? expr) 
      (let ((e1 (cadr expr)))
        (if (numberp e1)
            (append (make* (* n e1)) (cddr expr))
            (append (make* n) (cdr expr)))))
    ((+? expr)
      (simplify (append '(+)
                        (simplify*-through+ (cdr expr) n))))
    (T (make* n expr))
    ))
;; simplify*-aux2
(defun simplify*-aux2 (expr *expr)
  (cond
    ((numberp expr) (simplify*-aux1 *expr expr))
    ((*? expr)
      (let ((e1 (cadr expr))
            (*e1 (cadr *expr)))
        (cond
          ((numberp e1) (simplify*-aux1
                        (append *expr (cddr expr))
                        e1))
          ((numberp *e1) (simplify*-aux1
                         (append expr (cddr *expr))
                         *e1))
          (T (append '(*) (cdr expr) (cdr *expr))))))
    ((+? expr)
      (simplify (append '(+)
                (simplify*-through+ (cdr expr) *expr))))
    (T (append *expr (list expr)))))
;; ������� 6. ��������� ��������� �������� (�������� �������)
;; simplify/

;; simplify/-through*

;; ������� 7. ��������� ���������� � �������
;; simplifyexpt

;; ������� 8. ��������� ��������� �������
;; simplify-fun-1

;; simplifyexp

;; simplifylog

;; ����������� ���������
;; ��������� ������� ������ �������� ��� ���������
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

;; ������� 9. ����������� ����� 
;; +-deriv

;; ������� 10. ����������� ������������
;; *-deriv

;; ������� 11. ����������� ��������� ��������
;; /-deriv

;; ������� 12. ����������� ��������� �������
;; expt-deriv

;; ������� 13. ����������� ������������������ �������
;; sin-deriv

;; cos-deriv

;; ������� 14. ����������� �������� ������������������ �������
;; asin-deriv

;; acos-deriv

;; atan-deriv

;; ������� 15. ����������� ���������� � ������������ ���������
;; exp-deriv

;; log-deriv
