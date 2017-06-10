(define (square x) (* x x))

(define (map items proc)
  (if (null? items)
      '()
      (cons (proc (car items))
            (map (cdr items) proc))))

(define (tree-map proc tree)
  (map tree
       (lambda (sub-tree)
         (if (pair? sub-tree)
             (tree-map proc sub-tree)
             (proc sub-tree)))))

(define (square-tree tree) (tree-map square tree))


(define tree (list 1 (list 2 (list 3 4) 5) (list 6 7)))

(print tree)
(print (square-tree tree))
