(define (repeated f n)
  (define (try i)
    (if (= i n)
        id
        (compose f (try (+ i 1)))))
  (try 0))

(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (id x) x)

(define dx 0.00001)

(define (average a b c)
  (/ (+ a b c)
     3))

(define (smooth f)
  (lambda (x)
    (average (- (f x) dx)
             (f x)
             (+ (f x) dx))))

(print ((smooth cos) 1))  ; =0.5403023058681398
(print (((repeated smooth 5) cos) 1))  ; =0.5403023058681398
