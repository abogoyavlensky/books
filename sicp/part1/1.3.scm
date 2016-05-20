(define (square x) (* x x))
(define (sum x y) (+ (square x) (square y)))
(define (=> x y) (or (> x y) (= x y)))


  (define (max x y z)
    (cond ((=> x y) (if (=> x z)
                        (if (=> y z)
                            (sum x y)
                            (sum x z))
                        (sum x z)))
          (else (if (=> y z)
                    (if (=> x z)
                        (sum y x) 
                        (sum y z))
                    (sum y z)))))

(define (main) (max 5 6 9))

(load "display.scm")
