; Получилось сделать два разных представления прямоугольника.
; Первое задается двумя точками, а второе двумя отрезками. Для того, чтобы
; сделать возможным применение функции area и perimetr более общим
; понадобилось использовать возможность определять тип переданного объекта.

(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))
(define (print-point p)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")")
  (newline))

; Уровень представления (первый вариант)
(define (make-rectangle left-low-corner-p right-up-corner-p)
  (cons left-low-corner-p right-up-corner-p))
(define (left-low-corner rectangle) (car rectangle))
(define (right-up-corner rectangle) (cdr rectangle))

; Уровень представления (второй вариант)
(define (make-segment start-p end-p) (cons start-p end-p))
(define (start-segment segment) (car segment))
(define (end-segment segment) (cdr segment))

(define (make-rec left-s up-s)
  (cons (start-segment left-s)
        (end-segment up-s)))

; Уровень использования
(define (area rectangle)
  (* (- (x-point (right-up-corner rectangle))
        (x-point (left-low-corner rectangle)))
     (- (y-point (right-up-corner rectangle))
        (y-point (left-low-corner rectangle)))))

(define (perimetr rectangle)
  (+ (* (- (x-point (right-up-corner rectangle))
           (x-point (left-low-corner rectangle)))
        2)
     (* (- (y-point (right-up-corner rectangle))
           (y-point (left-low-corner rectangle)))
        2)))


(define left-p (make-point 1 2))
(define right-p (make-point 5 4))
(define r (make-rectangle left-p right-p))
(print (area r))  ; =8
(print (perimetr r))  ; =12

(define left-up-p (make-point 1 4))
(define left-s (make-segment left-p left-up-p))
(define right-s (make-segment left-up-p right-p))
(define r (make-rec left-s right-s))
(print (area r))  ; =8
(print (perimetr r))  ; =12
