(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) '() sequence))

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

(define (length sequence)
  (accumulate (lambda (x y) (+ 1 y)) 0 sequence))


(define (square x) (* x x))
(define x (list 1 2 3 4 5))
(define y (list 6 7 8 9 10))

(print (map square x))  ; =(1 4 9 16 25)
(print (append x y))  ; =(1 2 3 4 5 6 7 8 9 10)
(print (length y))  ; =5
