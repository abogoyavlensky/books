; Accumulate sequence in single value by operation with initial value
(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
      (accumulate op initial (cdr sequence)))))

; Returns sequence with numbers from `a` to `b`
(define (enumerate-interval a b)
  (if (> a b)
      '()
      (cons a (enumerate-interval (+ a 1) b))))

; Append seq2 to seq1 at the end
(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

; Returns flat sequence from nested
(define (flatmap proc sequence)
  (accumulate append '() (map proc sequence)))

; Returns sequence filtered by predicate
(define (filter pred sequence)
  (cond ((null? sequence) '())
    ((pred (car sequence))
     (cons (car sequence)
           (filter pred (cdr sequence))))
    (else (filter pred (cdr sequence)))))
