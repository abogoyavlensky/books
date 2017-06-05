(define (make-interval a b) (cons a b))
(define (lower-bound interval) (car interval))
(define (upper-bound interval) (cdr interval))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (if (or (and (< (lower-bound x) 0)
               (> (upper-bound x) 0))
          (and (< (lower-bound y) 0)
               (< (lower-bound y) 0)))
      (error "Interval across zero")
      (mul-interval x
                    (make-interval (/ 1.0 (upper-bound y))
                                   (/ 1.0 (lower-bound y))))))


(define i1 (make-interval 3 7))
(define i2 (make-interval 2 5))
(define i3 (make-interval -2 5))
(print (div-interval i1 i2))  ; =(0.6000000000000001 . 3.5)
(print (div-interval i1 i3))  ; ERROR: Interval across zero
