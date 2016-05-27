(load "common/math.scm")

(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   (pp p q)
                   (qq p q)
                   (/ count 2)))
         (else (fib-iter (+ (* b q) (* a q) (* a p))
                         (+ (* b p) (* a q))
                         p
                         q
                         (- count 1)))))


(define (pp p q)
  (+ (square p) (square q)))

(define (qq p q)
  (+ (* 2 p q) (square q)))

(print (fib 9)) ;34
(print (fib 10)) ;55
(print (fib 11)) ;89
(print (fib 12)) ;144
