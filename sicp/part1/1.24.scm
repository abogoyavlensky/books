; #lang racket
; Спавнив данные полученные в этом примере с данными из примера 1.22, можно
; заметить, что проверка на простоту небольших чисел практически совпадает
; по времени. Но при увеличении чисел разница видна ощутимо. При использовании
; функции из этого примера после 1000 скорочть растет очень медленно и
; достигает ~0.0032 при проверке 1000000. Тогда как функция обычная функция
; показыват ~0.004 уже на 10000 и при увеличении чисел продолжает только резко
; расти. Можно сделать приближенный вывод, что разница скоростей этих функции
; динамически изменияется примерно в экспоненциальной пропорции.

; Функция быстрой проверки на простоту с помощью теста Ферма.
(define (square x) (* x x))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp) (remainder (square (expmod base (/ exp 2) m))
                                m))
        (else (remainder (* base (expmod base (- exp 1) m))
                         m))))

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
;3"***"0.112060546875
;5"***"0.0029296875
;7"***"0.002197265625
;1009"***"0.0029296875
;1013"***"0.001953125
;1019"***"0.001953125
;10007"***"0.001953125
;10009"***"0.001953125
;10037"***"0.002197265625
;100003"***"0.0029296875
;100019"***"0.0029296875
;100043"***"0.003173828125
;1000003"***"0.0029296875
;1000033"***"0.0029296875
;1000037"***"0.003173828125
