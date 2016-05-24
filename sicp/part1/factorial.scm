;Вычисление факториала методом линейной рекурсии.
(load "common/math.scm")

(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))


;Вычисление факториала линейно итеративным методом с помощью
;рекурсивной процедуры.
(define (factorial2 n)
  (define (iter result count)
    (if (> count n)
        result
        (iter (* count result)
                   (+ count 1))))

  (iter 1 1))

(print (factorial 6))
(print (factorial2 6))
