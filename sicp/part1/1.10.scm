;Функция Аккермана.
(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))

(print (A 1 10)) ;1024
(print (A 2 4)) ;65536
(print (A 3 3)) ;65536

(define (f n) (A 0 n)) ;f(n) = n * 2
(define (g n) (A 1 n)) ;?
(define (h n) (A 2 n)) ;?

(print (f 3))
(print (g 3))
(print (h 3))
