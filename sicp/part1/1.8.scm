;Вычисление кубического корня методом Ньютона.
(load "common/math.scm")

(define (good_enough? guess x precise)
  (>= precise
      (abs (- x
              (cube guess)))))

(define (improve guess x)
  (/ (+ (/ x
            (square guess))
         (* 2 guess))
      3))

(define (sqrt3_iter guess x)
  (if (good_enough? guess x 0.0001)
      guess
      (sqrt3_iter (improve guess x) x)))

(define (sqrt3 x)
  (sqrt3_iter 1.0 x))


(print (sqrt3 27))
