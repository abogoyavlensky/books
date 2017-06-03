(define (cont-frac d n k)
  (define (finish? x)
    (> x k))
  (define (try i)
    (let ((dd (d i))
          (nn (n i)))
      (if (finish? i)
          1
          (/ nn (+ dd (try (+ i 1)))))))
  (try 0))

(define (d i)
  (define (iter acc count k)
    (cond
          ((= k count 0) acc)
          ((and (= k 0) (not (= count 0))) 1)
          ((= count 2) (iter (+ acc 2) 0 (- k 1)))
          (else (iter acc (+ count 1) (- k 1)))))
  (iter 0 2 i))

(define e
  (+ (cont-frac d
                (lambda (i) 1.0)
                5)
     2))


(print e)  ; =2.7183098591549295
