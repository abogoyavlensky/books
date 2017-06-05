(define zero (lambda (f) (lambda (x) x)))
(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

; Подстановка one
(define one (add-1 zero))
(add-1 zero)
(add-1 (lambda (f) (lambda (x) x)))
(lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) x)) f) x))))
(lambda (f) (lambda (x) (f x)))  ; =one


; Подстановка two
(define two (add-1 one))
(add-1 (lambda (f) (lambda (x) (f x))))
(lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) (f x))) f) x))))
(lambda (f) (lambda (x) (f ((lambda (x) (f x)) x))))
(lambda (f) (lambda (x) (f (f x))))  ; =two

; Определение сложения
(define (add a b)
  (lambda (f) (lambda (x) (f ((b (a f)) x)))))


; Подстановка
(add one two)
(add (lambda (f) (lambda (x) (f x)))
     (lambda (f) (lambda (x) (f (f x)))))
(lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) (f (f x)))) ((lambda (f) (lambda (x) (f x))) f)) x))))
(lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) (f (f x)))) (lambda (x) (f x))) x))))
(lambda (f) (lambda (x) (f ((lambda (x) ((lambda (x) (f x)) ((lambda (x) (f x)) x))) x))))
(lambda (f) (lambda (x) (f (f (f x)))))  ; one + two = three
