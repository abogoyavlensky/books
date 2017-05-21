; Изменение времени проверки prime? с применением функции next изменилось,
; но не в 2 раза а меньше, примерно в ~1,5. Возможно, это оюъясняется тем, что
; на деление на нечетное число тратится больше времени, чем на деление на
; четное.

; Поиск наименьшего делителя
(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(define (square x) (* x x))

(define (divides? a b)
  (= (remainder b a) 0))

(define (next x)
  (if (= x 2) 3 (+ x 2)))


; Тест на простоту числа с измерением времени
(define (timed-prime-test n)
  (start-prime-test n (runtime)))

(define (runtime) (current-inexact-milliseconds))

(define (start-prime-test n start-time)
  (if (prime? n)
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
(timed-prime-test 1)
(timed-prime-test 2)
(timed-prime-test 3)
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

; Вывод программы:
;1"***"0.053955078125
;2"***"0.0009765625
;3"***"0.0009765625
;1009"***"0.030029296875
;1013"***"0.002197265625
;1019"***"0.0009765625
;10007"***"0.0029296875
;10009"***"0.0029296875
;10037"***"0.0029296875
;100003"***"0.008056640625
;100019"***"0.0087890625
;100043"***"0.009033203125
;1000003"***"0.025146484375
;1000033"***"0.025146484375
;1000037"***"0.02490234375
