(define (map proc items)
  (if (null? items)
      '()
      (cons (proc (car items))
            (map proc (cdr items)))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      '()
      (cons (accumulate op
                        init
                        (let ((rest (car seqs)))
                          (append rest
                                  (map (lambda (x) (cons (car seqs) x))
                                       rest))))
            (accumulate-n op
                          init
                          (if (null? (cdr seqs))
                              (list '())
                              (cdr seqs))))))


(define s (list (list 1 2 3) (list 4 5 6) (list 7 8 9) (list 10 11 12)))

(print (accumulate-n + 0 s))  ; =(22 26 30)
