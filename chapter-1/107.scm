#!/usr/bin/guile -s
!#

(define (1+ x)
  (+ x 1))

(define (-1+ x)
  (- x 1))

(define (+ a b)
  (if (= a 0)
    b
    (1+ (+ (-1+ a) b))))

(define (+ a b)
  (if (= a 0)
    b
    (+ (-1+ a) (1+ b))))

#!

We can evaluate these procedures for the inputs a=4, b=5, to work out whether they are recursive or
iterative.

First do the first function:

(+ 4 5)
(1+ (+ 3 5))
(1+ (1+ (+ 2 5)))
(1+ (1+ (1+ (+ 1 5))))
(1+ (1+ (1+ (1+ (+ 0 5)))))
(1+ (1+ (1+ (1+ 5))))
(1+ (1+ (1+ 6)))
(1+ (1+ 7))
(1+ 8)
(9)

This function is recursive as it has to build a chain of deferred operations before collapsing the
chain once everything has been expanded.

Now the second function:

(+ 4 5)
(+ 3 6)
(+ 2 7)
(+ 1 8)
(+ 0 9)

This function is iterative as its progress can be tracked by the state variable a. The process is
linear in a.

!#
