#!/usr/bin/guile -s
!#


(define (square x)
  (* x x))

(define (square-list x)
  (if (null? x)
    #nil
    (cons (square (car x))
	  (square-list (cdr x)))))

#!

This procedure can be made a higher order function, that applies any given function to every
member in the list:

!#

(define (mapcar f x)
  (if (null? x)
    #nil
    (cons (f (car x))
	  (mapcar f (cdr x)))))
