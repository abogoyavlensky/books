; Рекурсивный процесс
(define (product f a next b)
  (if (> a b)
      1
      (* (f a)
         (product f (next a) next b))))


(define (factorial n)
  (define (id x) x)
  (define (inc x) (+ x 1))
  (product id 1 inc n))


; Итеративный процесс
(define (product-i f a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* (f a) result))))
  (iter a 1))

(define (factorial-i n)
  (define (id x) x)
  (define (inc x) (+ x 1))
  (product-i id 1 inc n))


; Вычисление числа Pi по формуле Джона Уоллиса
(define (pi fin)
  (define (square x)
    (if (= x fin)
        x
        (* x x)))
  (define (inc x) (+ x 2))
  (define up
    (if (even? fin)
        fin
        (- fin 1)))
  (define down
    (if (odd? fin)
        fin
        (- fin 1)))
  (/ (* (product square 4 inc up) 2 4)
     (product square 3 inc down)))

(print (factorial 5))  ; =120
(print (factorial-i 5))  ; =120
(print (pi 8))  ; =3.343673
(print (pi 100))  ; =3.1573
(print (pi 400))  ; =3.1455
