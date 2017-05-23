; Числа Кармайкла действительно "обманывают" тест Ферма, тогда как обычные
; числа его не проходят.

(define (square x) (* x x))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp) (remainder (square (expmod base (/ exp 2) m))
                                m))
        (else (remainder (* base (expmod base (- exp 1) m))
                         m))))

(define (ferma-test a n)
  (= (expmod a n n) a))


; Проверка всех чисел, меньших проверяемого, с помощью теста Ферма
(define (carmichael-test n)
  (define (check a n)
    (cond ((= a n) (print "Is prime."))
          ((ferma-test a n) (check (+ a 1) n))
          (else (print "Is not prime."))))
  (print n)
  (check 2 n))


(carmichael-test 1009)  ; Проверяем заведомо простое число.
(carmichael-test 1011)  ; Проверяем заведомо не простое число.
(carmichael-test 561)  ; Проверяем числа Кармайкла.
(carmichael-test 1105)  ; Проверяем числа Кармайкла.
(carmichael-test 1729)  ; Проверяем числа Кармайкла.
(carmichael-test 2465)  ; Проверяем числа Кармайкла.
(carmichael-test 2821)  ; Проверяем числа Кармайкла.
(carmichael-test 6601)  ; Проверяем числа Кармайкла.


; Вывод программы
;1009
;"Is prime."
;1011
;"Is not prime."
;561
;"Is prime."
;1105
;"Is prime."
;1729
;"Is prime."
;2465
;"Is prime."
;2821
;"Is prime."
;6601
;"Is prime."
