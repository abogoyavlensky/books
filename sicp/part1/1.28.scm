(define (square x) (* x x))
(define (!= x y) (not (= x y)))

(define (expmod base exp m)
  (define (check x n)
    (define r (remainder (square x) n))
    (cond ((and (!= x 1) (!= x (- n 1)) (= r 1)) 0)
          (else r)))
  (cond ((= exp 0) 1)
        ((even? exp) (check (expmod base (/ exp 2) m) m))
        (else (remainder (* base (expmod base (- exp 1) m))
                         m))))

(define (millera-rabina-test a n)
  (= (expmod a (- n 1) n) 1))


(define (carmichael-test n)
  (define (test a n)
    (cond ((= a n) (print "Is prime."))
          ((millera-rabina-test a n) (test (+ a 1) n))
          (else (print "Is not prime."))))
  (print n)
  (test 2 n))


(carmichael-test 1009)  ; Проверяем заведомо простое число.
(carmichael-test 1011)  ; Проверяем заведомо не простое число.
(carmichael-test 561)  ; Проверяем числа Кармайкла.
(carmichael-test 1105)  ; Проверяем числа Кармайкла.
(carmichael-test 1729)  ; Проверяем числа Кармайкла.
(carmichael-test 2465)  ; Проверяем числа Кармайкла.
(carmichael-test 2821)  ; Проверяем числа Кармайкла.
(carmichael-test 6601)  ; Проверяем числа Кармайкла.


; Вывод программы
;100`9
;"Is prime."
;1011
;"Is not prime."
;561
;"Is not prime."
;1105
;"Is not prime."
;1729
;"Is not prime."
;2465
;"Is not prime."
;2821
;"Is not prime."
;6601
;"Is not prime."
