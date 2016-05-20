(define (square x) (* x x))
(define (sum x y) (+ (square x) (square y)))
(define (gte x y) (or (> x y) (= x y)))


  (define (max x y z) (cond
                          ((gte x y) (if (gte x z) (if (gte y z) (sum x y)(sum x z)) (sum x z)))
                          (else (if (gte y z) (if (gte x z) (sum y x) (sum y z)) (sum y z)))
                          ))

(define (main) (max 5 6 9))

(load "display.scm")
