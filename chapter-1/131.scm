#!/usr/bin/guile -s
!#

#!

We can define a process for finding fixed points of functions via:

!#

(define (fixed-point f initial-guess)
  (if (< (abs (- (f initial-guess) initial-guess)) 0.001)
    initial-guess
    (fixed-point f (f initial-guess))))

(display (fixed-point cos 1))
