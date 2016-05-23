;Вычисление факториала методом линейной рекурсии.
(load "common/math.scm")

(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))

(print (factorial 6))
