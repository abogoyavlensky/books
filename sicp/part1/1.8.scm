;Вычисление кубического корня методом Ньютона.
(load "common/math.scm")

(define (improve guess x)
  ((/ x (square guess))))

(define (sqrt_iter guess x)
  (if (good_enough? guess x 0.0001)
      guess
      (sqrt_iter (improve guess x) x)))

(print (sqrt 27))
