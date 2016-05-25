(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

(print (a-plus-abs-b 10 4))
(print (a-plus-abs-b 3 7))
