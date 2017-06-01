; Возникнет ошибка о том, что функции f не существует, так внутри самой f
; переданныйй параметр не будет видеть своего поределения.
; ==> "application not a procedure."

(define (f g)
  (g 2))

(define (square x) (* x x))

(print (f square))

(print (f (lambda (z) (* z (+ z 1)))))

(print (f f))
