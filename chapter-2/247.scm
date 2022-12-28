#!/usr/bin/guile -s
!#

(define (make-polar mag ang)
  (define (dispatch m)
    (cond ((eq? m 'real-part)
	   (* mag (cos ang)))
	  ((eq? m 'imag-part)
	   (* mag (sin ang)))
	  ((eq? m 'magnitude) mag)
	  ((eq? m 'angle) ang))))

#!

This consructs a polar representation of a complex number using a message passing approach.

!#
