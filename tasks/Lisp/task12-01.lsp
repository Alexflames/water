;; Стратегия решения следующая. Будем просматривать последовательно 
;; элементы списка. На каждом шаге обновляем текущую подпоследовательности, 
;; сравниваем с данной в условии. При равенстве добавляем номер начинающего её
;; элемента. 
;; Если встречается список, то рекурсивно повторяем алгоритм внутри списка,
;; сохраняя номер элемента, с которого начался рекурсивный проход, и строя тем 
;; самым последовательность номеров для сохранения полного пути.
;; В решении использовался DFS, который позволяет сохранить целостность пути. 
;; Решение - функция от двух аргументов, но чтобы не определять 
;; вспомогательной функции, определим дополнительные 
;; необязательные параметры
;; l - обязательный параметр - заданный список
;; seq - обязательный параметр - список, вхождение которого будем искать
;; остальные параметры необязательные
;; tempseq - последовательность, "собираемая" постепенно из элементов 
;; текущего "уровня"
;; ans - список номеров первых элементов, с которых начинается вхождение seq
;; i - номер элемента - либо номер элемента - списка, либо тот номер, вычитая
;; из которого длину искомого списка можно получить номер элемента, с которого
;; начинается совпадающий подсписок

(defun find-list-part (seq 
                       l 
                       &optional (tempseq '()) 
                                 (ans '())
                                 (i '(1)))
  (cond
    ((null l) ans)
    ((listp (car l))
      (let* ((el (car l))
             (tempseq (append tempseq (list el)))
             (nans  
               ;; Запускаем алгоритм рекурсивно внутри списка. Сохраняем текущий
               ;; i. После выполнения "склеиваем" результат с текущим. 
               (append ans (find-list-part seq 
                                       el
                                       ()
                                       ()
                                       (append '(1) i)))))
        (if (= (length seq) (length tempseq))
            (if (equal seq tempseq)
                (find-list-part seq 
                                (cdr l)
                                (cdr tempseq)
                                ;; Так как i прибавляется на каждом шаге, а нам
                                ;; нужен первый элемент подпоследовательности,
                                ;; то вычитаем её длину, уменьшенную на 1.
                                ;; Результат добавляется к ответу
                                (append ans 
                                        (cons (- (+ (car i) 1) 
                                                 (length seq))
                                              (cdr i)))
                                ;; На каждом шаге увеличение последнего i на 1.
                                ;; Данная последовательность будет реверсирована
                                ;; когда среди элементов не останется списков
                                (cons (1+ (car i)) (cdr i)))
                (find-list-part seq
                                (cdr l)
                                (cdr tempseq)
                                nans
                                (cons (1+ (car i)) (cdr i))))
            (find-list-part seq
                            (cdr l)
                            tempseq
                            nans
                            (cons (1+ (car i)) (cdr i))))))
    (T (let* ((el (car l))
              (tempseq (append tempseq (list el))))
         ;; Аналогичные действия + добавление внешней скобки. Результат наоборот
         (if (= (length seq) (length tempseq))
             (if (equal seq tempseq)
                 (find-list-part seq 
                                 (cdr l)
                                 (cdr tempseq)
                                 (append 
                                   ans 
                                     (list (reverse (cons (- (+ (car i) 1) 
                                                             (length seq))
                                                          (cdr i)))))
                                   (cons (1+ (car i)) (cdr i)))
                 (find-list-part seq
                                 (cdr l)
                                 (cdr tempseq)
                                 ans
                                 (cons (1+ (car i)) (cdr i))))
             (find-list-part seq
                             (cdr l)
                             tempseq
                             ans
                             (cons (1+ (car i)) (cdr i))))))))


(print (find-list-part '(a a) '(a a)))

(print (find-list-part '(a a) '(a a a)))

(print (find-list-part '(a a) '(a a a a)))

(print (find-list-part '(a) '(b o o b o b)))

(print (find-list-part '(a a) '(a meme a meme a)))

(print (find-list-part '(a a) '(a (a a) a)))

(print (find-list-part '(a a) '(a (a a a (a (a a))) a a)))

(print (find-list-part '(a a) '(a)))

(print (find-list-part '(a a) '()))

(print (find-list-part '(a a) '(a a b a b a a (a (a a a)) b)))

(print 
  (find-list-part 
    '(a a (b) a)
    '(c a a (b) a a (b) a (a d a a (b a a (b a a (b) a z) a h a a (b) a) a))))