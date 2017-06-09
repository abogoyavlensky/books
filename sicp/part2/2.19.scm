; Порядок монет в списке coin-values значения не имеет, так как алгоритм
; должен перебрать все монеты не зависимо от порядка.

(define (cc amount coin-values)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else (+ (cc amount
                     (except-first-denomination coin-values))
                 (cc (- amount (first-denomination coin-values))
                     coin-values)))))

(define (no-more? l)
  (null? l))

(define (first-denomination l)
  (car l))

(define (except-first-denomination l)
  (cdr l))

(define us-coins (list 50 25 10 5 1))
(define us-coins-shuffled (list 5 1 25 50 10))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))

(print (cc 100 us-coins))  ; =292
(print (cc 100 us-coins-shuffled))  ; =292
(print (cc 50 uk-coins))  ; =6149
