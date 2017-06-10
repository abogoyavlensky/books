(define (fringe items)
  (cond
        ((not (pair? items)) items)
        ((= (length items) 1) (fringe (car items)))
        (else (append (let ((a (fringe (car items))))
                        (if (list? a)
                            a
                            (list a)))
                      (let ((b (fringe (cdr items))))
                        (if (list? b)
                            b
                            (list b)))))))


(define x (list 1 2 3 4 5))
(define y (list (list 1 2) (list 3 4)))
(define z (list (list 1 2 3 (list 5 6)) (list 3 4 5)))

(print x)
(print (fringe x))
(print (list x x))
(print (fringe (list x x)))
(print y)
(print (fringe y))
(print z)
(print (fringe z))
