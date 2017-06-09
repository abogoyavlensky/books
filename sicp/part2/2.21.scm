(define (map items proc)
  (if (null? items)
      '()
      (cons (proc (car items))
            (map (cdr items) proc))))

(define (square x) (* x x))

(define (square-list items)
  (if (null? items)
      '()
      (cons (square (car items))
            (square-list (cdr items)))))

(define (square-list-map items)
  (map items square))

(define items (list 1 2 3 4))
(print (square-list items))  ; =(1 4 9 16)
(print (square-list-map items))  ; =(1 4 9 16)
