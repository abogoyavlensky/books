(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
      (accumulate op initial (cdr sequence)))))

(define (enumerate-interval a b)
  (if (> a b)
      '()
      (cons a (enumerate-interval (+ a 1) b))))

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

(define (flatmap proc sequence)
  (accumulate append '() (map proc sequence)))

(define (unique-pairs n)
  (flatmap
    (lambda (i)
      (map (lambda (j) (list i j))
           (enumerate-interval 1 (- n 1))))
    (enumerate-interval 1 n)))

(print (unique-pairs 6))
;((1 1) (1 2) (1 3) (1 4) (1 5) (2 1) (2 2) (2 3) (2 4) (2 5) (3 1) (3 2)
;(3 3) (3 4) (3 5) (4 1) (4 2) (4 3) (4 4) (4 5) (5 1) (5 2) (5 3) (5 4)
; (5 5) (6 1) (6 2) (6 3) (6 4) (6 5)
