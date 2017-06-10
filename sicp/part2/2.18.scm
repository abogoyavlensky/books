; Итеративный процесс
(define (reverse l)
  (define (iter tail result)
    (if (null? tail)
        result
        (iter (cdr tail) (cons (car tail) result))))
  (iter l '()))


; Рекурсивный процесс
(define (reverse-rec items)
  (if (null? items)
      '()
      (append (reverse-rec (cdr items))
              (list (car items)))))


(print (reverse (list 1 4 9 16 25)))
(print (reverse-rec (list 1 4 9 16 25)))
