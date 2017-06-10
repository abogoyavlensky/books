; Процедура работает, так как на каждом шаге для map есть своя локальная s,
; которая редуцируется в конструкции let. При первом проходе все исходное
; множество разбирается по одному элементу на каждом уровне рекурсии. А когда
; достигает пустого списка, начинает собираться в подмножества.
; Это объяснение не полное и несколько туманное, так как не вполне есть
; понимание используещегося механизма. Обяснение необходимо уточнить
; и доплнить.

(define (map proc items)
  (if (null? items)
      '()
      (cons (proc (car items))
            (map proc (cdr items)))))

(define (subsets s)
  (if (null? s)
      (list '())
      (let ((rest (subsets (cdr s))))
        (append rest
                (map (lambda (x) (cons (car s) x))
                     rest)))))


(define set (list 1 2 3))
(print set)  ; =(1 2 3)
(print (subsets set))  ; =(() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))
