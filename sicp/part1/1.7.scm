(load "common/math.scm")

(define (improve guess x)
  (/ (+ (/ x guess) guess) 2))

(define (good_enough?2 guess pre_guess precise)
  (>= precise (abs (- pre_guess guess))))

(define (sqrt_iter2 guess pre_guess x)
  (if (good_enough?2 guess pre_guess 0.0001)
      guess
      (sqrt_iter2 (improve guess x) guess x)))

(define (sqrt2 x)
  (sqrt_iter2 1.0 0.0 x))

(print (sqrt2 2893123434634))
(print (sqrt2 0.0028732))

;Измерял время утилитой time. Прирост в производительности есть но совсем
;не большой и не стабильный, порядка 0.001 секунды.
