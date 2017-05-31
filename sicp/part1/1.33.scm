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

; Проверка на простоту из файла 1.22.scm
(define (prime? n)
  (= n (smallest-divisor n)))


; Итеративный процесс
(define (filtered-accumulate-i filter combiner null-value term a next b)
  (define (iter a result)
    (cond ((> a b) result)
          ((filter a) (iter (next a) (combiner (term a) result)))
          (else (iter (next a) (combiner null-value result)))))
  (iter a null-value))

(define (inc x) (+ x 1))
(define (id x) x)

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (find n)
  (define (prime-toward? x)
    (= (gcd x n) 1))
  (filtered-accumulate-i prime-toward? * 1 id 1 inc n))


; Поиск суммы квадратов простых чисел в интервале от a до b
(print (filtered-accumulate-i prime? + 0 square 1 inc 15))  ; =378
(print (find 15))  ; =896896
