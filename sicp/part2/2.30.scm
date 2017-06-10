(define (square x) (* x x))

(define (map items proc)
  (if (null? items)
      '()
      (cons (proc (car items))
            (map (cdr items) proc))))

(define (square-tree tree)
  (cond ((null? tree) '())
        ((not (pair? tree)) (square tree))
        (else (cons (square-tree (car tree))
                    (square-tree (cdr tree))))))

(define (square-tree-map tree)
  (map tree
       (lambda (sub-tree)
         (if (pair? sub-tree)
             (square-tree-map sub-tree)
             (square sub-tree)))))

(define tree (list 1 (list 2 (list 3 4) 5) (list 6 7)))

(print tree)
(print (square-tree tree))
(print (square-tree-map tree))
