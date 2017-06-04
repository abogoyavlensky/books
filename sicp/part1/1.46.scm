(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (square x) (* x x))

(define (improve guess x)
  (let ((average (lambda (a b) (/ (+ a b) 2))))
    (average guess (/ x guess))))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt-simple x)
  (sqrt-iter 1.0 x))

; Общая процедура итеративного улучшения
(define (iterative-imporove good-enough? improve)
  (define (try guess)
    (if (good-enough? guess)
        guess
        (try (improve guess))))
  (lambda (guess) (try guess)))

; Вычисление корня из числа с помощью общего метода итеративного улучшения
(define (sqrt x)
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess)
    (let ((average (lambda (a b) (/ (+ a b) 2))))
      (average guess (/ x guess))))
  ((iterative-imporove good-enough? improve) 1.0))


(print (sqrt-simple 9))  ; =3.00009155413138
(print (sqrt-simple 25))  ; =5.000023178253949
(print (sqrt 9))  ; =3.00009155413138
(print (sqrt 25))  ; =5.000023178253949
