#!/usr/bin/guile -s
!#

(define (repeated f n)
  (if (= n 0)
    (lambda (x) x)
    (lambda (x) (f ((repeated f (- n 1)) x)))))

(display ((repeated (lambda (x) (* x x)) 2) 5))

#!

This procedure applies a function n times to an input.

!#
