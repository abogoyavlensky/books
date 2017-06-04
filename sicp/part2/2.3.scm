; Получилось сделать два разных представления прямоугольника.
; Первое задается двумя точками, а второе двумя отрезками. Для того, чтобы
; сделать возможным применение функции area и perimeter более общим
; понадобилось использовать возможность определять тип переданного объекта.
; Но уровень абстрации получения точек сегмента "протек" на уровень получения
; точек прямоугольника. Пока у нас нет более мощных средств манипулированиями
; типами видимо это допустимо.

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
(define (left-low-corner rectangle)
  (let ((left (car rectangle)))
    (if (pair? (car left))
        (car left)
        left)))
(define (right-up-corner rectangle)
  (let ((right (cdr rectangle)))
    (if (pair? (cdr right))
        (cdr right)
        right)))

; Уровень представления (второй вариант)
(define (make-segment start-p end-p) (cons start-p end-p))
(define (make-rec left-s up-s) (cons left-s up-s))

; Уровень использования
(define (area rectangle)
  (* (- (x-point (right-up-corner rectangle))
        (x-point (left-low-corner rectangle)))
     (- (y-point (right-up-corner rectangle))
        (y-point (left-low-corner rectangle)))))

(define (perimeter rectangle)
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
(print (perimeter r))  ; =12

(define left-up-p (make-point 1 4))
(define left-s (make-segment left-p left-up-p))
(define right-s (make-segment left-up-p right-p))
(define r (make-rec left-s right-s))
(print (area r))  ; =8
(print (perimeter r))  ; =12
