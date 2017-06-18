; Чтобы обе функции давали одинаковый ответ, необходимо, чтобы op не зависела
; от порядка применения.

(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op initial (cdr sequence)))))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))


(print (fold-right / 1 (list 1 2 3)))  ; =1.5
(print (fold-left / 1 (list 1 2 3)))  ; =0.16666666666666665
(print (fold-right list '() (list 1 2 3)))  ; =(1 (2 (3 ())))
(print (fold-left list '() (list 1 2 3)))  ; =(((() 1) 2) 3)

(print (fold-right + 0 (list 1 2 3)))  ; =6
(print (fold-left + 0 (list 1 2 3)))  ; =6
(print (fold-right - 0 (list 1 2 3)))  ; =2
(print (fold-left - 0 (list 1 2 3)))  ; =-6
