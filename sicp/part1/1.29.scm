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
  (define (add-h x y) (/ (- y x) n))
  (* (/ (add-h a b) 3)
    ; (sum f (+ a (* 3 (add-h a b))) add-h b)
     (sum f (+ a 0.1) add-h b)))
  ;(sum f (+ a (* 3 (add-h a b n))) add-h b)
  ;(sum f))

;(print (integral cube 0 1 0.01))
;(print (integral cube 0 1 0.001))

(print (simpson cube 0 1 100))
