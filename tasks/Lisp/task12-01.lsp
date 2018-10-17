;; ��������� ������� ���������. ����� ������������� ��������������� 
;; �������� ������. �� ������ ���� ��������� ������� ���������������������, 
;; ���������� � ������ � �������. ��� ��������� ��������� ����� ����������� �
;; ��������. 
;; ���� ����������� ������, �� ���������� ��������� �������� ������ ������,
;; �������� ����� ��������, � �������� ������� ����������� ������, � ����� ��� 
;; ����� ������������������ ������� ��� ���������� ������� ����.
;; � ������� ������������� DFS, ������� ��������� ��������� ����������� ����. 
;; ������� - ������� �� ���� ����������, �� ����� �� ���������� 
;; ��������������� �������, ��������� �������������� 
;; �������������� ���������
;; l - ������������ �������� - �������� ������
;; seq - ������������ �������� - ������, ��������� �������� ����� ������
;; ��������� ��������� ��������������
;; tempseq - ������������������, "����������" ���������� �� ��������� 
;; �������� "������"
;; ans - ������ ������� ������ ���������, � ������� ���������� ��������� seq
;; i - ����� �������� - ���� ����� �������� - ������, ���� ��� �����, �������
;; �� �������� ����� �������� ������ ����� �������� ����� ��������, � ��������
;; ���������� ����������� ���������

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
               ;; ��������� �������� ���������� ������ ������. ��������� �������
               ;; i. ����� ���������� "���������" ��������� � �������. 
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
                                ;; ��� ��� i ������������ �� ������ ����, � ���
                                ;; ����� ������ ������� ���������������������,
                                ;; �� �������� � �����, ����������� �� 1.
                                ;; ��������� ����������� � ������
                                (append ans 
                                        (cons (- (+ (car i) 1) 
                                                 (length seq))
                                              (cdr i)))
                                ;; �� ������ ���� ���������� ���������� i �� 1.
                                ;; ������ ������������������ ����� �������������
                                ;; ����� ����� ��������� �� ��������� �������
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
         ;; ����������� �������� + ���������� ������� ������. ��������� ��������
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