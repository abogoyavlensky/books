; 1 градус ~ 0,0174533 радиан
(define (cont-frac combiner d n k)
  (define (finish? x)
    (> x k))
  (define (try i)
    (let ((dd (d i))
          (nn (n i)))
      (if (finish? i)
          1
          (/ nn (combiner dd (try (+ i 1)))))))
  (try 0))

(define (tan-cf x k)
  (define (n i)
    (if (= i 0)
        x
        (* x x)))
  (define (d i)
    (define (iter j result)
      (if (= j i)
          result
          (iter (+ j 1) (+ result 2))))
    (iter 0 1))
  (cont-frac - d n k))


;(print (tan-cf 1 10))
;(print (tan-cf 6 10))
;(print (tan-cf 7 10))

(define (tan x)
  (/ (sin x) (cos x)))

(print (tan 0.0174533))  ; ~1 градус
(print (tan-cf 0.0174533 5))  ; =0.017455072410553304

(print (tan 0.0349066))  ; ~2 градуса
(print (tan-cf 0.0349066 5))  ; =0.034920784470104404

(print (tan 0.0523599))  ; ~3 градуса
(print (tan-cf 0.0523599 5))  ; =0.052407801784844956
