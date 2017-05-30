(define (cube x) (* x x x))

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2)) add-dx b)
     dx))


(define (simpson f a b n)
  (define (h)
    (/ (- b a) n))
  (define (inc x)
    (+ x 1))
  (define (get-k k)
    (cond ((or (= k 1) (= k n)) 1)
          ((even? k) 2)
          (else 4)))
  (define (term k)
    (* (get-k k)
       (f (+ a (* (h) k)))))
  (* (sum term 0 inc n)
     (/ (h) 3.0)))


(print (integral cube 0 1 0.01))
(print (integral cube 0 1 0.001))

(print (simpson cube 0 1 100))
(print (simpson cube 0 1 1000))
