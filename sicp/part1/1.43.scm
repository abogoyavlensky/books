(define (square x) (* x x))

(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (id x) x)

(define (repeated f n)
  (define (try i result)
    (if (= i n)
        result
        (try (+ i 1) (compose f result))))
  (try 0 id))


(print ((repeated square 0) 5))  ; =5
(print ((repeated square 1) 5))  ; =25
(print ((repeated square 2) 5))  ; =625
(print ((repeated square 3) 5))  ; =360625
