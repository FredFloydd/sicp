#!/usr/bin/guile -s
!#

(define (f g)
  (g 2))

#!

If we ask this function to operate on itself, we have the following expansion:

(f f)
(f 2)
(2 2)

The last expression makes no sense to the interpreter, as 2 is not a process,
so an error will be thrown.

!#

(display (f f))
