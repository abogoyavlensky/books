;Построить дерево в консоли
;ввиде последовательно представленого списка вызовов процедур.
;Код взять из комментария:
;http://sicp.sergeykhenkin.com/2007/08/27/sicp-exercise-solution-1-14/
;Ответ на вопрос: сложность алгоритма O(n^k), где n - сумма,
;k - количество номиналов; порядок роста памяти O(n), n - сумма.
;
(define (mknode amount kinds-of-coins left right)
  (list amount kinds-of-coins left right))

(define (mkleaf amount)
  (list amount))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
	((= kinds-of-coins 2) 5)
	((= kinds-of-coins 3) 10)
	((= kinds-of-coins 4) 25)
	((= kinds-of-coins 5) 50)))

(define (cc amount kinds-of-coins)
  (cond ((= amount 0) (mkleaf 1))
	((or (< amount 0) (= kinds-of-coins 0)) (mkleaf 0))
	(else (mknode amount
		      kinds-of-coins
		      (cc amount
			  (- kinds-of-coins 1))
		      (cc (- amount (first-denomination kinds-of-coins))
			  kinds-of-coins)))))

(define (count-change amount)
  (cc amount 5))

(print (count-change 11))
