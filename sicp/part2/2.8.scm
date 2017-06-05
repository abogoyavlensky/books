(define (make-interval a b) (cons a b))
(define (lower-bound interval) (car interval))
(define (upper-bound interval) (cdr interval))

(define (sub-interval a b)
  (make-interval (abs (- (lower-bound a) (lower-bound b)))
                 (abs (- (upper-bound a) (upper-bound b)))))
