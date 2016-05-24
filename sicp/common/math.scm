(define (square x) (* x x))

(define (cube x) (* x x x))

(define (>= x y) (or (> x y) (= x y)))

(define (abs x) (if (> x 0) x (- x)))

(define (pow x power)
  (define (iter result x p)
    (if (< p 1)
        result
        (iter (* result x) x (- p 1))))
  (iter 1 x power))
