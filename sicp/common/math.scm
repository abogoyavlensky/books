(define (square x) (* x x))

(define (cube x) (* x x x))

(define (>= x y) (or (> x y) (= x y)))

(define (abs x) (if (> x 0) x (- x)))
