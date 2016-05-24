;Функция pascal выводит Треугольник Паскаля построчно без смещения.

(define (get_item row index)
  (cond ((or (= index 0) (= index row)) 1)
        ((or (= index 1) (= index (- row 1) )) row)
        (else (+ (get_item (- row 1) index) (get_item (- row 1) (- index 1))))))

(define (row_iter result i max_v)
  (if (> i max_v)
      result
      (row_iter (string-append (number->string (get_item max_v i))
                         " "
                         result)
          (+ i 1)
          max_v)))

(define (iter i r)
  (print (row_iter "" 0 i))

  (if (< i r)
      (iter (+ i 1) r)
      (exit)))

(define (pascal n)
    (iter 0 n))

(print (pascal 14))
