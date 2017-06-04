; Для нахождения корня n-ой степени из числа процедуру average-dump
; необходимо применять 3 раза. Возможно приувеличение степени корня
; понадобится увеличивать количество раз применения процедуры, но для
; проверенных корней до 11-ой степени решение сходится. Также можно найти
; более оптимальное количество 

(define (repeated f n)
  (define (try i)
    (if (= i n)
        id
        (compose f (try (+ i 1)))))
  (try 0))

(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (id x) x)

(define (fixed-point f first-guess)
  (define tolerance 0.00001)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try (f next)))))
  (try first-guess))

(define (average x y)
  (/ (+ x y)
     2))

(define (average-dump f)
  (lambda (x)
    (average x (f x))))

(define (square x) (* x x))

(define (fast-pow b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-pow b (/ n 2))))
        (else (* b (fast-pow b (- n 1))))))

(define (sqrt x)
  (fixed-point (average-dump (lambda (y) (/ x y)))
               1.0))

(define (find-root x n)
  (let ((f (lambda (y) (/ x (fast-pow y (- n 1))))))
    ;(fixed-point ((repeated average-dump (- n 1)) f))
    (fixed-point ((repeated average-dump 3) f)
                 1.0)))


(print (sqrt 625))  ; =25.0
(print (find-root 625 2))  ; =25.0
(print (find-root 125 3))  ; =5.000000237699204
(print (find-root 625 4))  ; =5.000008066382536
(print (find-root 3125 5))  ; =5.000018484249296
(print (find-root 3125 6))  ; =3.8236549447341872
(print (find-root 43125 7))  ; =4.59307781928076
(print (find-root 43125 8))  ; =3.7961305411576704
(print (find-root 43125 9))  ; =3.2731801715375326
(print (find-root 43125 10))  ; =2.907185464256537
(print (find-root 43125 11))  ; =2.6383893477109285
