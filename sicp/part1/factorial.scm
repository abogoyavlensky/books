;Вычисление факториала методом линейной рекурсии.
(load "common/math.scm")

(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))


(define (factorial2 n)
  (define (fact_iter result count)
    (if (> count n)
        result
        (fact_iter (* count result)
                   (+ count 1))))

  (fact_iter 1 1))

(print (factorial 6))
(print (factorial2 6))
