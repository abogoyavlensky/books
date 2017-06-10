(define x (list 1 (list 2 (list 3 4))))

; Древовидная диаграмма
;                 (1 (2 (3 4)))
;                 /        \
;                1      (2 (3 4))
;                       /     \
;                      2     (3 4)
;                            /  \
;                           3   4

; Стрелочная диграмма
;   (1 (2 (3 4)))-->((2 (3 4)) nil)-->nil
;    |                |
;    1             (2 (3 4))-->((3 4) nil)-->nil
;                   |            |
;                   2          (3 4)-->(4 nil)-->nil
;                               |       |
;                              3       4


(print x)  ; =(1 (2 (3 4)))