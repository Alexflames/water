;; ��������� ������� ���������. ����� ������������� �������� ������ 
;; �� �������: ������� ��� ��������� ������� ������, ����� ��� �������� 
;; ������� � �. �. �������� ���������� ������ ����� �������� 
;; ��������� ��� ��������-������ �������� ������.
;; ������� - ������� �� ���� ����������, �� ����� �� ���������� 
;; ��������������� �������, ��������� �������������� 
;; �������������� ���������
;; l - ������������ �������� - �������� ������
;; seq - ������������ �������� - ������, ��������� �������� ����� ������
;; ��������� ��������� ��������������
;; new-l - ������ ��������� ���������� ������
;; cur-depth - ����� �������� ������; ������������� ����� 1
;; cnt - ���������� ��������� �������� ������, ���������� ��������
;; tempseq - ������������������, "����������" ���������� �� ��������� 
;; �������� ������
;; ans - ������ ������� ������ ���������, � ������� ���������� ��������� seq
;; i - ����� ��������, ����������� ������������� ��������� �� ������� ������;
;; ������������� ����� 1

(defun find-list-part (seq 
                       l 
                       &optional new-l 
                       (cur-depth 1) 
                       (cnt 0) 
                       (tempseq '()) 
                       (ans '())
                       (i 1))
  (if (null l)          ; ���� ������ l ���� ������ 
      (if (= cnt 0) ans ; � �� ������� ������ �� ���� ����������, 
                        ; ������ ������� ���������
          ; ���� �� ��������� ����, �� ���� ��� ���� �������, �������� ��������
          ; ���������� ������ new-l, �� �������� ���������� ��������� �������
          (find-list-part seq new-l () (+ cur-depth 1) 0 () ans 1))
      ; ���� ������ l ���� �� ������, �� � ��� ���� ������ �������, 
      ; ��������� ��� el
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
          ((listp el) ; ���� el - ������, �� ��� �������� ���������  
            (find-list-part seq 
                            (cdr l)
                            (append el new-l)
                            cur-depth 
                            (+ 1 cnt)
                            tempseq
                            ans
                            i))
          ; � ��������� ������ ������ ���������� ������� el
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
