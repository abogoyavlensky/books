(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))


;Нормальный порядок
(gcd 206 40)
(gcd 40 (remainder 206 40)) ; +1 : if b
(gcd (remainder 206 40) (remainder 40 (remainder 206 40))) ; +2 : if b
(gcd (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))) ; +4 : if b
(gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))) ; +7 : if b
(remainder (remainder 206 40) (remainder 40 (remainder 206 40))) ; +4
(remainder (remainder 206 40) (remainder 40 6))
(remainder 6 4)
2
;Ответ: при нормальном порядке выполняется 18 операций remainder.

;Аппликативный порядок
(gcd 206 40)
(gcd 40 6)
(gcd 6 4)
(gcd 4 2)
2
;Ответ: при аппликативном порядке выполняется 4 операций remainder.


(print (gcd 206 40))
