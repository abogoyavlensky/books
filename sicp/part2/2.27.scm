(define (reverse items)
  (define (iter tail result)
    (if (null? tail)
        result
        (iter (cdr tail) (cons (car tail) result))))
  (iter items '()))

(define (deep-reverse items)
  (cond ((null? items) items)
        ((not (pair? items)) items)
        ((= (length items) 1) (deep-reverse (car items)))
        (else (list (deep-reverse (cdr items))
                    (deep-reverse (car items))))))

(define x (list (list 1 2) (list 3 4)))


(print x)  ; =((1 2) (3 4))
(print (reverse x))  ; =((3 4) (1 2
(print (deep-reverse x))  ; =((4 3) (2 1))
