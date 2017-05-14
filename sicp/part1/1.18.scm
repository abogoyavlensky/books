(define (double x) (+ x x))
(define (halve x) (/ x 2))

(define (fast_mult a b)
  (define (iter r a b)
    (cond ((= b 0) r)
          ((even? b) (iter r (double a) (halve b)))
          (else (iter (+ r a) a (- b 1)))))
  (iter 0 a b))


(print (fast_mult 34 738))
