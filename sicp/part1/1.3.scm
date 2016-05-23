(define (square x) (* x x))
(define (sum x y) (+ (square x) (square y)))
(define (>= x y) (or (> x y) (= x y)))


  (define (max x y z)
    (cond ((>= x y) (if (and (> x z) (>= y z))
                        (sum x y)
                        (sum x z)))
          (else (if (and (>= y z) (>= x z))
                    (sum y x)
                    (sum y z)))))

(define (main) (max 4 6 3))

(load "common/display.scm")
