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

(define (filter pred sequence)
  (cond ((null? sequence) '())
    ((pred (car sequence))
     (cons (car sequence)
           (filter pred (cdr sequence))))
    (else (filter pred (cdr sequence)))))

(define (check-sum? triplet s)
  (= (accumulate + 0 triplet) s))

(define (unique-triplets n)
  (flatmap
    (lambda (i)
      (flatmap
        (lambda (k)
          (map (lambda (j) (list i j k))
               (enumerate-interval 1 (- k 1))))
        (enumerate-interval 1 (- i 1))))
    (enumerate-interval 1 n)))

(define (make-triplet-sum triplet)
  (append triplet (list (accumulate + 0 triplet))))

(define (check-sum-triplets n s)
  (map make-triplet-sum
      (filter (lambda (x) (check-sum? x s))
              (unique-triplets n))))

(print (check-sum-triplets 6 8))
