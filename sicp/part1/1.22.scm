; 1. Среднее значение проверки на простоту чисел близких 1000 равно
; ~0.001953125, а близких 10000 равно ~0.00390625. sqrt(10) == 3.1622776601684.
; Значит, наше предположение не верно, потому что
; 0.001953125 * 3.1622776601684 = 0.006176323555016366.
; 0.006176323555016366 != 0.00390625. Разница меньше, чем мы ожидали.
;
; 2. Для чисел близких к 100000 затрачивается ~0.012939453125, а к близких к
; 1000000 затрачивается ~0.041015625.
; 0.012939453125 * 3.1622776601684 = 0.04091814355198343, что примерно равно
; количеству времени затрачиваемому во втором случае ~0.041015625.
; Значит предположения подтверждается.
;
; 3. На проверку чисел близких к 1000 требуется примерно ~31 шаг и на каждый
; шаг требуется 6.300403e-05 миллисекунды. На проверку
; чисел близких к 10000 требуется примерно ~99 шаг (100^2 = 10000 и -1,
; так как проверять начинаем с 2), времени на шаг 3.945707070707071e-05.
; На проверку чисел близких к 100000 требуется ~315 шагов и на каждый шаг
; тратися 4.107762896825397e-05 милисекунды. Для чисел близких к 1000000,
; шагов требуется 1000, времени на шаг 4.1015625e-05.
; ==> Для чисел близких к 1000 на шаг требуется чуть больше времени, чем для
; больших чисел разных порядков для проверки на простоты на шаг требуется
; примерно одиноковое время.

; Поиск наименьшего делителя
(define (square x) (* x x))

(define (divides? a b)
  (= (remainder b a) 0))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (smallest-divisor n)
  (find-divisor n 2))

; Проверка на простоту
(define (prime? n)
  (= n (smallest-divisor n)))

(define (runtime) (current-inexact-milliseconds))

; Тест на простоту числа с измерением времени
(define (timed-prime-test n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime n (- (runtime) start-time))
      #f))

(define (report-prime n elapsed-time)
  (print n)
  (print "***")
  (print elapsed-time)
  (newline)
  #t)

; Поиск первых limit простых чисел в интервале от begin до end
(define (search-for-primes begin end limit)
  (define (find begin counter)
    (define current-prime? (timed-prime-test begin))
    (cond ((or (= begin end) (= counter limit)) (print "Finish"))
          ((even? end) (find (+ begin 1) (get_counter current-prime? counter)))
          (else (find (+ begin 2) (get_counter current-prime? counter)))))
  (define (get_counter check c)
    (if check (+ c 1) c))
  (find begin 0)
  (newline))

; Примеры
(search-for-primes 1 1000 3)
(search-for-primes 1000 10000 3)
(search-for-primes 10000 100000 3)
(search-for-primes 100000 1000000 3)
(search-for-primes 1000000 10000000 3)

; Вывод:
;1"***"0.046875
;2"***"0.0029296875
;3"***"0.0
;"Finish"
;1009"***"0.001953125
;1013"***"0.001953125
;1019"***"0.001953125
;"Finish"
;10007"***"0.00390625
;10009"***"0.004150390625
;10037"***"0.00390625
;"Finish"
;100003"***"0.012939453125
;100019"***"0.012939453125
;100043"***"0.012939453125
;"Finish"
;1000003"***"0.041015625
;1000033"***"0.041015625
;1000037"***"0.26220703125
;"Finish"
