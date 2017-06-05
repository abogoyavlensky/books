; (a,b) = 2^a3^b
(define (square x) (* x x))
(define (pow b n)
  (cond ((= n 0) 1)
        ((even? n) (square (pow b (/ n 2))))
        (else (* b (pow b (- n 1))))))

(define (cons a b) (* (pow 2 a) (pow 3 b)))

(define (iter i result divider)
  (let ((r (rem result divider)))
    (if (not (= r 0))
        i
        (iter (+ i 1) (/ result divider) divider))))

(define (car z) (iter 0 z 2))
(define (cdr z) (iter 0 z 3))

(define point (cons 3 5))
(print (car point))
(print (cdr point))
