(load "part1/1.21.scm")

(define (prime? n)
  (= n (smallest-divisor n)))

(define (report-prime elapsed-time)
  (display "***")
  (newline)
  (display elapsed-time)
  (newline))

(define (timed-prime-test n)
  (define start-time (current-time))
  (newline)
  (display n)
  (newline)
  (if (prime? n)
      (report-prime (- (current-time) start-time))))


(timed-prime-test 7)


(define (check-prime-in-range bottom top)
  (cond ((= bottom top) (newline))
        ((divides? bottom 2) (timed-prime-test bottom))
        (else (check-prime-in-range (+ bottom 1) top))))

(check-prime-in-range 100 1000)
