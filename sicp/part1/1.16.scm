(load "common/math.scm")

(define (fast_pow b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast_pow b (/ n 2))))
        (else (* b (fast_pow b (- n 1))))))

(define (iter_fast_pow x p)
  (define (iter a b n)
    (cond ((= n 0) a)
          ((even? n) (iter a (square b) (/ n 2) ))
          (else (iter (* a b) b (- n 1)))))
  (iter 1 x p))


(define p 9)
(print (fast_pow 2 p))
(print (iter_fast_pow 2 p))
