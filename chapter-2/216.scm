#!/usr/bin/guile -s
!#

(define (last x)
  (if (null? (cdr x))
    x
    (last (cdr x))))

(define numbers (list 1 2 3 4 5 6 7))

#!

This procedure returns a list of length one, containing only the last item in the list x.

!#
