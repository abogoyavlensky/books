(define (make-interval a b) (cons a b))
(define (lower-bound interval) (car interval))
(define (upper-bound interval) (cdr interval))

(define (make-center-percent c p)
  (let ((w (/ c p)))
    (make-interval (- c w) (+ c w))))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i))
     2))

(define (percent i)
  (let ((w (- (center i) (lower-bound i))))
    (/ (center i) w)))

(define i (make-center-percent 6.8 10))
(print i)
(print (center i))
(print (percent i))
