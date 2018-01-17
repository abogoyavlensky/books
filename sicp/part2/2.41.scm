(load "collections.scm")

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

(print (check-sum-triplets 6 10))
