#!/usr/bin/guile -s
!#

(define (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda (p q) p)))

#!

This is a procedural representation of the construction of a pair. We can show that
the created data object behaves like a normally constructed pair. Consider trying
to access the first element of the pair (cons 1 2):

(car (cons 1 2))
((cons 1 2) (lambda (p q) p))
((lambda (m) (m 1 2)) (lambda (p q) p))
((lambda (p q) p) 1 2)
1

This behaves as we wish. We could define a corresponding cdr selector via:

!#

(define (cdr z)
  (z (lambda (p q) q)))
