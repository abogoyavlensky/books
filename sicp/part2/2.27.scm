(define (reverse-i items)
  (define (iter tail result)
    (if (null? tail)
        result
        (iter (cdr tail) (cons (car tail) result))))
  (iter items '()))

(define (reverse items)
  (if (null? items)
      '()
      (append (reverse (cdr items))
              (list (car items)))))

;(define (deep-reverse items)
;  (cond
;        ((not (pair? items)) items)
;        ((= (length items) 1) (deep-reverse (car items)))
;        (else (list (deep-reverse (cdr items))
;                    (deep-reverse (car items))))))

(define (deep-reverse items)
  (cond
        ((not (pair? items)) items)
        ((= (length items) 1) (deep-reverse (car items)))
        (else (append (let ((a (deep-reverse (cdr items))))
                        (if (list? a)
                            a
                            (list a)))
                      (let ((b (deep-reverse (car items))))
                        (if (list? b)
                            b
                            (list b)))))))


(define x (list 1 2 3 4 5))
(define y (list (list 1 2) (list 3 4)))
(define z (list (list 1 2 3 (list 5 6)) (list 3 4 5)))


(print x)  ; =((1 2) (3 4))
(print (reverse x))
(print (deep-reverse x))
(print (deep-reverse y))
(print (deep-reverse z))
