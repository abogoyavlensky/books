;syn(x) function
(load "common/math.scm")

(define (p x) (- (* 3 x) (* 4 (cube x))))

(define (syn angle)
  (if (not (> (abs angle) 0.1))
      angle
      (p (syn (/ angle 3.0)))))

(print (syn 12.15))
