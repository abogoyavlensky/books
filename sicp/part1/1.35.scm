(define (fixed-point f first-guess)
  (define tolerance 0.00001)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try (f next)))))
  (try first-guess))

(define fi
  (fixed-point (lambda (x) (+ 1 (/ 1 x)))
               1.0))

(print (fixed-point cos 1.0))
(print fi)  ; =1.6180344
