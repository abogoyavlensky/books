; Рекурсивный процесс
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate combiner null-value term (next a) next b))))

; Итеративный процесс
(define (accumulate-i combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner (term a) result))))
  (iter a null-value))


(define (id x) x)
(define (inc x) (+ x 1))

; Sum
(print (accumulate + 0 id 0 inc 10))  ; =55
(print (accumulate-i + 0 id 0 inc 10))  ; =55

; Product)
(print (accumulate * 1 id 1 inc 5))  ; =120
(print (accumulate-i * 1 id 1 inc 5))  ; =120
