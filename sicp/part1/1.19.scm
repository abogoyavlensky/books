(load "common/math.scm")

(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   (pp a b q p)
                   (qq a b q p)
                   (/ count 2)))
         (else (fib-iter (+ (* b q) (* a q) (* a p))
                         (+ (* b p) (* a q))
                         p
                         q
                         (- count 1)))))


(define (qq a b p q)
  (/ (- (+ (* 2 b q)
           (* 2 a p))
        (* a q))
     ((- (+ a b)
         (* a a)))))

(define (pp a b p q)
  (/ (- (+ (* 2 b p)
           (* 2 a q))
        (* a (qq a b p q)))
     b))

;(print (fib 9)) ;34
;(print (fib 10)) ;55
;(print (fib 11)) ;89
;(print (fib 12)) ;144

(print (qq 10 10 10 10))
