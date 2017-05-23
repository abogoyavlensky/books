; # lang racket
; При проверке простых чисел меньших и близких 1000 разница не слишком заметна.
; Но при увеличении проверяемого числа время на выполнение программы растет
; очень большими темпами. На столько, что на проверку 1000000 тратится больше
; секунды (!).
; Мы наблюдаем такую разницу, возможно, из-за того, что при обычном вычисление
; числа по модулю (как в текущей задаче) мы вынуждены использовать числа
; в качестве делимого на много больших m (делителя). При делении бОльших чисел
; тратится больше памяти и больше итерации на осуществлениеи деления. Поэтому
; мы наблюдаем такую существенную разницу во времени выполнения программы.


(define (square x) (* x x))

(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

(define (expmod base exp m)
  (remainder (fast-expt base exp) m))


; Копия кода из 1.24.scm, чтобы сравнить скорость работы expmod
(define (ferma-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((ferma-test n) (fast-prime? n (- times 1)))
        (else false)))

; Тест на простоту числа с измерением времени
(define (timed-prime-test n)
  (start-prime-test n (runtime)))

(define (runtime) (current-inexact-milliseconds))

(define (start-prime-test n start-time)
  (if (fast-prime? n 1)
      (report-prime n (- (runtime) start-time))
      #f))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (report-prime n elapsed-time)
  (print n)
  (print "***")
  (print elapsed-time)
  (newline)
  #t)


; Проверка всех простых чисел найденных в предыдущем примере.
(timed-prime-test 3)
(timed-prime-test 5)
(timed-prime-test 7)
(timed-prime-test 1009)
(timed-prime-test 1013)
(timed-prime-test 1019)
(timed-prime-test 10007)
(timed-prime-test 10009)
(timed-prime-test 10037)
(timed-prime-test 100003)
(timed-prime-test 100019)
(timed-prime-test 100043)
(timed-prime-test 1000003)
(timed-prime-test 1000033)
(timed-prime-test 1000037)


; Вывод программы
;3"***"0.09814453125
;5"***"0.001953125
;7"***"0.001953125
;1009"***"0.02490234375
;1013"***"0.022216796875
;1019"***"0.01806640625
;10007"***"0.8349609375
;10009"***"0.64697265625
;10037"***"0.8330078125
;100003"***"30.56396484375
;100019"***"35.612060546875
;100043"***"42.708984375
;1000003"***"1551.77490234375
;1000033"***"1048.072021484375
;1000037"***"1126.177978515625
