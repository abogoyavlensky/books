; Рекурсивный процесс
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate combiner null-value term (next a) next b))))

(define (id x) x)
(define (inc x) (+ x 1))

(define (sum term a next b)
  (accumulate + 0 term a next b))

(define (product term a next b)
  (accumulate * 1 term a next b))

(define (factorial n)
  (product id 1 inc n))

(print (factorial 5))  ; =120
(print (sum id 0 inc 10))  ; =55
