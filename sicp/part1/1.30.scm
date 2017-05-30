(define (cube x) (* x x x))

; Рекурсивный процесс
(define (sum-rec term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum-rec term (next a) next b))))

(define (integral-rec f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum-rec f (+ a (/ dx 2)) add-dx b)
     dx))

; Итеративный процесс
(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ (term a) result))))
  (iter a 0))

(define (integral f a b dx)
 (define (add-dx x) (+ x dx))
 (* (sum f (+ a (/ dx 2)) add-dx b)
    dx))


(print (integral-rec cube 0 1 0.01))
(print (integral cube 0 1 0.01))
