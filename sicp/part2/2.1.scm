(define (make-rat-simple n d) (cons n d))
(define (numer x) (car x))
(define (denom x) (cdr x))
(define (print-rat x)
  (display (numer x))
  (display "/")
  (print (denom x)))

(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))

(define (make-rat n d)
  (if (and (> n 0) (> d 0))
      (cons n d)
      (cons (* (abs n) -1) (abs d))))


(define a (make-rat 1 2))
(define b (make-rat 3 -5))
(print-rat (mul-rat a b))  ; =-3/10

(define a (make-rat -1 2))
(define b (make-rat 3 -5))
(print-rat (mul-rat a b))  ; =3/10

(define a (make-rat -1 -2))
(define b (make-rat 3 5))
(print-rat (mul-rat a b))  ; =-3/10

(define a (make-rat -1 -2))
(define b (make-rat 3 -5))
(print-rat (mul-rat a b))  ; =3/10
