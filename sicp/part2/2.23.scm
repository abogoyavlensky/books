(define (for items proc)
  (cond ((null? items) #t)
        (else
          (proc (car items))
          (for (cdr items) proc))))

(for (list 1 2 3 4 5) print)
