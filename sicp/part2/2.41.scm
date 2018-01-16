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

(define (check-sum? triplet number)
  (= (accumulate + 0 triplet) number))

; TODO: need to update for triplets
(define (unique-triplets n)
  (flatmap
    (lambda (i)
      (map (lambda (j) (list i j))
           (enumerate-interval 1 (- i 1))))
    (enumerate-interval 1 n)))


; (define (make-triplet-sum pair)
;   (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

; (define (check-sum-triplets n)
;   (map make-pair-sum
;        (filter prime-sum?
;                (unique-pairs n))))
