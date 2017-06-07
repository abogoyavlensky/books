; По идее погрешность произведения интервалов должна расчитываться как
; сумма погрешностей каждого из интервалов. Но на практике это
; не подтверждается. Нужно будет вернуться к этой задаче и понять в чем
; может быть дело.
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

(define (make-center-percent c p)
  (let ((w (/ c p)))
    (make-interval (- c w) (+ c w))))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i))
     2))

(define (percent i)
  (let ((w (- (center i) (lower-bound i))))
    (/ (center i) w)))

(define x (make-center-percent 26.8 1.2))
(define y (make-center-percent 35.6 1.3))
(define m (mul-interval x y))
(print (percent x))
(print (percent y))
(print (+ (percent x) (percent y)))
(print (percent m))
