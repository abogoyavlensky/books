;Древовидно рекурсивный процесс.
(define (f_rec n)
  (if (< n 3)
      n
      (+ (f_rec (- n 1)) (f_rec (- n 2)) (f_rec (- n 3)))))


;Итеративный про
(define (f n)
  (define (iter a b c count)
    (if (< count 3)
        a
        (iter (+ a b c) a b (- count 1))))
  (iter 2 1 0 n))


(print (f_rec 10))
(print (f 10))
