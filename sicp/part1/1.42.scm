(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (square x) (* x x))
(define (inc x) (+ x 1))

(print ((compose square inc) 6))  ; =49
