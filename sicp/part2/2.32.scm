; На каждом шаге комбинируем первый элемент множества со списком подмножеств
; остальной его части.

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
