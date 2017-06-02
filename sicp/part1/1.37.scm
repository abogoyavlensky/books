; Приблежение должно содеражать 9 шагов, чтобы достич точности до четверго
; знака после запятой значения 1/fi.

; Рекурсивный процесс
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

; Итеративный процесс
(define (cont-frac-i d n k)
  (define (finish? x)
    (< x 0))
  (define (try i result)
    (let ((dd (d i))
          (nn (n i)))
      (if (finish? i)
          result
          (try (- i 1) (/ nn (+ dd result))))))
  (try k 1))


(define fi 1.6180344)


(print (/ 1.0 fi))  ; =0.6180338316663726
(print (cont-frac (lambda (i) 1.0)
                  (lambda (i) 1.0)
                  9))  ; =0.6180555555555555
(print (cont-frac-i (lambda (i) 1.0)
                    (lambda (i) 1.0)
                    9))  ; =0.6180555555555555
