(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))

(define (main) (test 0 (p)))

(load "display.scm")
