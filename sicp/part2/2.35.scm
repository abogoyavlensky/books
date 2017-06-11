; Возможно аргументы map в count-leaves можно определить подругому, более
; логично. Так как на первый взглять можно обйтись вообще без map, а
; использовать только enumerate-tree.

(define (map proc items)
  (if (null? items)
      '()
      (cons (proc (car items))
            (map proc (cdr items)))))

(define (enumerate-tree tree)
  (cond ((null? tree) '())
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (count-leaves t)
  (accumulate +
              0
              (map (lambda (x) 1)
                   (enumerate-tree t))))

(define tree (list 1 (list (list 5 6) (list (list 7) 4) 2) (list 3)))

(print tree)
(print (count-leaves tree))  ; =7
