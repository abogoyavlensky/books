(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      '()
      (cons (accumulate op init (map (lambda (x) (car x)) seqs))
            (accumulate-n op init (map (lambda (x) (cdr x)) seqs)))))

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (lambda (x) (dot-product x v)) m))

(define (transpose mat)
  (accumulate-n cons '() mat))


(define v (list 1 2 3 4))
(define m (list (list 1 2 3 4) (list 4 5 6 6) (list 6 7 8 9)))

(print (dot-product v v))  ; =30
(print (matrix-*-vector m v))  ; =(30 56 80)
(print (transpose m))  ; =((1 4 6) (2 5 7) (3 6 8) (4 6 9))
