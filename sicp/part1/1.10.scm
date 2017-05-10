;Функция Аккермана.
(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))

(print (A 1 10)) ;1024
(print (A 2 4)) ;65536
(print (A 3 3)) ;65536

(define (f n) (A 0 n)) ;f(n) = n * 2
; Подстановка
;(f n)
;(A 0 n)
;(* 2 n)


(define (g n) (A 1 n)) ;g(n) = n * 2
; Подстановка
;(g n)
;(A 1 n)
;(A (- 1 1) (A 1 (- n 1)))
;(A 0 (A 1 (- n 1)))
;(* 2 n)


(define (h n) (A 2 n)) ;?
;(h n)
;(A 2 n)
;(A (- 2 1) (A 2 (- n 1)))
;(A 1 (A (- 2 1) (A 2 (- (- n 1) 1))))
;(* 2 n)


(print (f 3))
(print (g 3))
(print (h 3))
