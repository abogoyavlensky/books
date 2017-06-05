(define (make-interval a b) (cons a b))
(define (lower-bound interval) (car interval))
(define (upper-bound interval) (cdr interval))

(define (sub-interval x y)
  (make-interval (abs (- (lower-bound x) (lower-bound y)))
                 (abs (- (upper-bound x) (upper-bound y)))))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))

(define (radius-interval interval)
  (/ (- (upper-bound interval)
        (lower-bound interval))
     2))


(define i1 (make-interval 3 7))
(define i2 (make-interval 9 16))
(print (radius-interval i1))  ; =2
(print (radius-interval i2))  ; =3.5
(print (add-interval i1 i2))  ; =(12 . 13)
(print (radius-interval (add-interval i1 i2)))  ;=5.5  = 2 + 3.5 - зависит
(print (sub-interval i1 i2))  ; =(6 . 9)
(print (radius-interval (sub-interval i1 i2)))  ;=1.5  = 3.5 - 2 - зависит
(print (radius-interval (mul-interval i1 i2)))  ;=42.5  != 2 * 3.5  - не зависит
(print (radius-interval (div-interval i1 i2)))  ;=0.29513888888888883  != 3.5 / 2  - не зависит
