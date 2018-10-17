;; —тратеги€ решени€ следующа€. Ѕудем просматривать элементы списка 
;; по уровн€м: сначала все эелементы первого уровн€, потом все элементы 
;; второго и т. д. Ёлементы следующего уровн€ можем получить 
;; объединив все элементы-списки текущего уровн€.
;; –ешение - функци€ от двух аргументов, но чтобы не определ€ть 
;; вспомогательной функции, определим дополнительные 
;; необ€зательные параметры
;; l - об€зательный параметр - заданный список
;; seq - об€зательный параметр - список, вхождение которого будем искать
;; остальные параметры необ€зательные
;; new-l - список элементов следующего уровн€
;; cur-depth - номер текущего уровн€; первоначально равен 1
;; cnt - количество элементов текущего уровн€, €вл€ющихс€ списками
;; tempseq - последовательность, "собираема€" постепенно из элементов 
;; текущего уровн€
;; ans - список номеров первых элементов, с которых начинаетс€ вхождение seq
;; i - номер элемента, начинающего потенциальное вхождение на текущем уровне;
;; первоначально равен 1

(defun find-list-part (seq 
                       l 
                       &optional new-l 
                       (cur-depth 1) 
                       (cnt 0) 
                       (tempseq '()) 
                       (ans '())
                       (i 1))
  (if (null l)          ; если список l стал пустым 
      (if (= cnt 0) ans ; и на текущем уровне не было подсписков, 
                        ; значит вернуть результат
          ; если же подсписки были, то есть еще один уровень, элементы которого
          ; составл€ют список new-l, от которого рекурсивно запускаем функцию
          (find-list-part seq new-l () (+ cur-depth 1) 0 () ans 1))
      ; если список l пока не пустой, то в нем есть первый элемент, 
      ; обозначим его el
      (let* ((el (car l)) 
            (tempseq (append tempseq (list el))))
        (cond 
          ((= (length seq) (length tempseq))
            (if (equal seq tempseq)
                (if (listp el)
                    (find-list-part seq 
                                    (cdr l)
                                    (append el new-l)
                                    cur-depth 
                                    (+ 1 cnt)
                                    (cdr tempseq)
                                    (cons (list i) ans)
                                    (1+ i))
                    (find-list-part seq
                                    (cdr l)
                                    new-l 
                                    cur-depth 
                                    cnt
                                    (cdr tempseq)
                                    (cons (list i) ans)
                                    (1+ i)))
                (if (listp el)
                    (find-list-part seq 
                                    (cdr l) 
                                    (append el new-l)
                                    cur-depth 
                                    (+ 1 cnt)
                                    (cdr tempseq)
                                    ans
                                    (1+ i))
                    (find-list-part seq 
                                    (cdr l)
                                    new-l 
                                    cur-depth 
                                    cnt
                                    (cdr tempseq)
                                    ans
                                    (1+ i)))))
          ((listp el) ; если el - список, то его элементы добавл€ем  
            (find-list-part seq 
                            (cdr l)
                            (append el new-l)
                            cur-depth 
                            (+ 1 cnt)
                            tempseq
                            ans
                            i))
          ; в противном случае просто игнорируем элемент el
          (T (find-list-part seq
                             (cdr l)
                             new-l 
                             cur-depth 
                             cnt
                             tempseq
                             ans
                             i))))))


(print 
  (find-list-part 
    '(a a (b) a)
    '(c a a (b) a a (b) a (a d a a (b a a (b a a (b) a z) a h a a (b) a) a))))

(print (find-list-part '(a a) '(a a b a b a a (a (a a)) b)))

(print (find-list-part '(a a) '(a a)))
