(define (deep-reverse items)
  (define (iter tail result)
    (cond ((null? tail) result)
          ((pair? (car tail))
           (iter (cdr tail)
                 (cons (iter (car tail) '()) result)))
          (else (iter (cdr tail) (cons (car tail) result)))))
  (iter items '()))


(define x (list (list 1 2) (list 3 4)))
(define y (list (list 1 2 3 (list 5 6)) (list 3 4 5)))

(print (deep-reverse x))
(print (deep-reverse y))
