#!/usr/bin/guile -s
!#

#!

In order to pick the number 7 from the following lists, we need to use the following commands:

!#

(define x (list 1 (list 2 3 (list 5 7) 9)))
(display (car (cdr (car (cdr (cdr (car (cdr x))))))))

(define y (list (list 7)))
(display (car (car y)))

(define z (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))
(display (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr z)))))))))))))
