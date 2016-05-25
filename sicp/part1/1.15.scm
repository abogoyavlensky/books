;syn(x) function
;a. Функция p вызывается 5 раз.
;b. Память растет логарифмически O(log(a));
;   количество шагов (сложность) O(log(a)).
(load "common/math.scm")

(define (p x)
  (print "1")  ; uncomment to count number of calls of (p)
  (- (* 3 x) (* 4 (cube x))))

(define (syn angle)
  (if (not (> (abs angle) 0.1))
      angle
      (p (syn (/ angle 3.0)))))

(print (syn 3000000.15))

(syn 12.15)
(p (syn 4.15))
(p (p (syn 1.0...)))
...
