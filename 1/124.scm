#!/usr/bin/guile -s
!#

(define (sum a b term next)

  (define (iter a result)
    (if (> a b)
      result
      (iter (next a)
	    (+ (term a) result))))

  (iter a 0))

#!

This is a way of defining a summation algorithm that is iterative, and therefore takes constant
memory to execute.

!#
