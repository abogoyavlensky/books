(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op initial (cdr sequence)))))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

(define (reverse-r sequence)
  (fold-right (lambda (x y) () '() sequence)))

(define (reverse-l sequence)
  (fold-left (lambda (x y) (cons y x)) '() sequence))


(print (reverse-r (list 1 4 9 16 25)))
(print (reverse-l (list 1 4 9 16 25)))
