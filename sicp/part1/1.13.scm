(load "common/math.scm")

(define (fibonacci n)
  (define (iter a b count)
    (if (= count 0)
        b
        (iter (+ a b) a (- count 1))))
  (iter 1 0 n))


(define (fi1)
  (/ (+ 1 (sqrt 5)) 2))

(define (fi2)
  (/ (- 1 (sqrt 5))
     2))


(define (f_to_cmp1 p)
  (/ (pow (fi1) p)
     (sqrt 5)))

(define (f_to_cmp2 p)
  (/ (- (pow (fi1) p) (pow (fi2) p)) (sqrt 5)))


(define n 10)
(print (fibonacci n))
(print (f_to_cmp1 n))
(print (f_to_cmp2 n))
