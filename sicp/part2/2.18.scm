(define (reverse l)
  (define (iter tail result)
    (if (null? tail)
        result
        (iter (cdr tail) (cons (car tail) result))))
  (iter l '()))

(print (reverse (list 1 4 9 16 25)))
