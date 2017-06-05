(define (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda (p q) p)))

(define (cdr z)
  (z (lambda (p q) q)))


(define point (cons 1 2))
(print point)
(print (car point))
(print (cdr point))


; Попытка применить подстановочную модель
;(define point (cons 1 2))
;(define point (lambda (m) (m 1 2)))
;(car (lambda (m) (m 1 2)))
;((lambda (m) (m 1 2)) (lambda (p q) p))
;((lambda (lambda (p q) p) ((lambda (1 2) 1))))
;1
