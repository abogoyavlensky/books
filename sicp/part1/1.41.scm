; В итоге функция inc применится 16 раз к своему аргументу.

(define (inc x) (+ x 1))

(define (double f)
  (lambda (x)
    (f (f x))))


(print ((double inc) 5)) ; =7
(print (((double (double double)) inc) 5))  ; =21
