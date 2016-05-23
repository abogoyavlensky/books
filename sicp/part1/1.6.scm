(load "common/sqrt.scm")

(define (newif p t e)
  (cond (p t)
        (else e)))

(define (sqrt_iter guess x)
  (newif (good_enough? guess x 0.0001)
      guess
      (sqrt_iter (improve guess x) x)))

(define (sqrt x)
  (sqrt_iter 1.0 x))

(print (sqrt 2))

;Вычислить занчение с newif не получится, так как функции в scheme вычисляются
;в аппликативном порядке. Это значит, что на момент запуска функции newif
;должны быть известны все переданные значения, а это невозможно потому что
;последним значением  e (else) передается рекурсивный запуск функции sqrt_iter.
