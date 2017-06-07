(define (make-interval a b) (cons a b))
(define (lower-bound interval) (car interval))
(define (upper-bound interval) (cdr interval))

(define (check-all x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (mul-interval x y)
  (if (< (upper-bound x) 0)
      (if (< (upper-bound y) 0)
          (make-interval (* (upper-bound x) (upper-bound y))  ; case 1
                         (* (lower-bound x) (lower-bound y)))
          (if (< (lower-bound y) 0)
              (make-interval (* (lower-bound x) (upper-bound y))  ; case 2
                             (* (lower-bound x) (lower-bound y)))
              (make-interval (* (lower-bound x) (upper-bound y))  ; case 3
                             (* (upper-bound x) (lower-bound y)))))
      (if (< (lower-bound x) 0)
          (if (< (upper-bound y) 0)
              (make-interval (* (upper-bound x) (lower-bound y))  ; case 4
                             (* (lower-bound x) (lower-bound y)))
              (if (< (lower-bound y) 0)
                  (make-interval (min (* (lower-bound x) (upper-bound y))  ; case 5
                                      (* (upper-bound x) (lower-bound y)))
                                 (max (* (upper-bound x) (upper-bound y))
                                      (* (lower-bound x) (lower-bound y))))
                  (make-interval (* (lower-bound x) (upper-bound y))  ; case 6
                                 (* (upper-bound x) (upper-bound y)))))
          (if (< (upper-bound y) 0)
              (make-interval (* (upper-bound x) (upper-bound y))  ; case 7
                             (* (lower-bound x) (lower-bound y)))
              (if (< (lower-bound y) 0)
                  (make-interval (* (upper-bound x) (lower-bound y))  ; case 8
                                 (* (upper-bound x) (upper-bound y)))
                  (check-all x y))))))  ; case 9



(define x (make-interval 3 7))
(define y (make-interval 2 5))
(print (mul-interval x y))
