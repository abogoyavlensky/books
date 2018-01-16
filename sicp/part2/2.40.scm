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

(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
      (accumulate op initial (cdr sequence)))))

(define (enumerate-interval a b)
  (if (> a b)
      '()
      (cons a (enumerate-interval (+ a 1) b))))

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

(define (flatmap proc sequence)
  (accumulate append '() (map proc sequence)))

(define (unique-pairs n)
  (flatmap
    (lambda (i)
      (map (lambda (j) (list i j))
           (enumerate-interval 1 (- i 1))))
    (enumerate-interval 1 n)))

(define (filter pred sequence)
  (cond ((null? sequence) '())
    ((pred (car sequence))
     (cons (car sequence)
           (filter pred (cdr sequence))))
    (else (filter pred (cdr sequence)))))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
               (unique-pairs n))))

(print (unique-pairs 6))
;((1 1) (1 2) (1 3) (1 4) (1 5) (2 1) (2 2) (2 3) (2 4) (2 5) (3 1) (3 2)
;(3 3) (3 4) (3 5) (4 1) (4 2) (4 3) (4 4) (4 5) (5 1) (5 2) (5 3) (5 4)
; (5 5) (6 1) (6 2) (6 3) (6 4) (6 5)

(print (prime-sum-pairs 6))
; ((2 1 3) (3 2 5) (4 1 5) (4 3 7) (5 2 7) (6 1 7) (6 5 11))
