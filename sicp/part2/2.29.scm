(define (make-mobile left right)
  (list left right))

(define (make-branch len structure)
  (list len structure))

;a
(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (car (cdr mobile)))

(define (branch-len branch)
  (car branch))

(define (branch-structure branch)
  (car (cdr branch)))

;б
(define (total-weight structure)
  (cond ((null? structure) 0)
        ((number? structure) structure)
        (else (+ (total-weight (branch-structure (left-branch structure)))
                 (total-weight (branch-structure (right-branch structure)))))))

;в
(define (balance? structure)
  (let ((lstructure (branch-structure (left-branch structure)))
        (rstructure (branch-structure (right-branch structure)))
        (lweight (total-weight (branch-structure (left-branch structure))))
        (llen (branch-len (left-branch structure)))
        (rweight (total-weight (branch-structure (right-branch structure))))
        (rlen (branch-len (right-branch structure))))
    (if (and (= (* lweight llen)
                (* rweight rlen))
             (if (number? rstructure)
                 #t
                 (balance? rstructure))
             (if (number? lstructure)
                 #t
                 (balance? lstructure)))
        #t
        #f)))

(define mobile1 (make-mobile (make-branch 1
                                         (make-mobile (make-branch 2 3)
                                                      (make-branch 5 5)))
                             (make-branch 3 2)))

(define mobile2 (make-mobile (make-branch 1
                                        (make-mobile (make-branch 2 4)
                                                     (make-branch 4 2)))
                             (make-branch 3 2)))


(print mobile1)
(print (total-weight mobile1))  ; =10
(print mobile2)
(print (total-weight mobile2))  ; =10
(print (balance? mobile2))  ; =10
