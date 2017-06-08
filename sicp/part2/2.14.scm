; В первом случае взял интервалы с большим значением центра, но
; не большим радиусом. Две эквивалентные формула расчета сопротивления
; параллельного подключения двух резисторов дают разные результаты. Значения
; центров этих результатов также сильно разнятся, но процетное отклонение
; погрешности вычисляется в обоих случаях примерно одинаково.
; Во втором случае взял интервалы центр и радиус, которых отличаются не сильно.
; В результате обе формулы дают сопоставимый результат с небольшой
; погрешностью. Значения центров результатов также примерно равны, а вот
; значение погрешности в процентах отличается существенно.

(define (make-interval a b) (cons a b))
(define (lower-bound interval) (car interval))
(define (upper-bound interval) (cdr interval))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))

(define (make-center-percent c p)
  (let ((w (/ c p)))
    (make-interval (- c w) (+ c w))))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i))
     2))

(define (percent i)
  (let ((w (- (center i) (lower-bound i))))
    (/ (center i) w)))

(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))

(define x (make-center-percent 26.8 1.2))
(define y (make-center-percent 35.6 1.3))

(define a (make-center-percent 18.8 20.2))
(define b (make-center-percent 10.6 15.3))

(print (par1 x y))  ; =(0.3272926862736129 . 244.01763040841086)
(print (par2 x y))  ; =(2.893489688637282 . 27.601683209074692)
(print (center (par1 x y)))  ; =122.17246154734222
(print (center (par2 x y)))  ; =15.247586448855987
(print (percent (par1 x y)))  ; =1.0026861359324537
(print (percent (par2 x y)))  ;1.2342129695757746

(print (par1 a b))  ; =(5.706467375682669 . 8.021709190080285)
(print (par2 a b))  ; =(6.373539979246568 . 7.182134565635572)
(print (center (par1 a b)))  ; =6.864088282881477
(print (center (par2 a b)))  ; =6.7778372724410704
(print (percent (par1 a b)))  ; =5.929478502155843
(print (percent (par2 a b)))  ; =16.76448837657773
