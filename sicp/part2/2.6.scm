(define zero (lambda (f) (lambda (x) x)))
(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

; Подстановка one
(define one (add-1 zero))
;(add-1 zero)
;(add-1 (lambda (f) (lambda (x) x)))
;(lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) x)) f) x))))
;(lambda (f) (lambda (x) (f x)))  ; =one


; Подстановка two
(define two (add-1 one))
;(add-1 (lambda (f) (lambda (x) (f x))))
;(lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) (f x))) f) x))))
;(lambda (f) (lambda (x) (f ((lambda (x) (f x)) x))))
;(lambda (f) (lambda (x) (f (f x))))  ; =two


; Определение сложения
(define (add a b)
  (lambda (f) (lambda (x) ((a f) ((b f) x)))))

; Проверка
(define (inc n) (+ n 1))
(define three (add one two))
(define four (add two two))
(define seven (add three four))
(print ((three inc) 0))
(print ((four inc) 0))
(print ((seven inc) 0))
