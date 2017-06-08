(define (last-pair l)
  (define (iter tail last-head)
    (if (null? tail)
        (list last-head)
        (iter (cdr tail) (car tail))))
  (iter l nil))

(print (last-pair (list 23 72 149 34)))
