;Вычисление квадратного корня методом Ньютона.
(load "common/math.scm")

(define (good_enough? guess x precise)
  (>= precise
      (abs (- x 
              (square guess)))))

(define (improve guess x)
  (/ (+ (/ x
           guess)
        guess)
     2))

(define (sqrt_iter guess x)
  (if (good_enough? guess x 0.0001)
      guess
      (sqrt_iter (improve guess x) x)))

(define (sqrt x)
  (sqrt_iter 1.0 x))
