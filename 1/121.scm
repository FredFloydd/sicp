#!/usr/bin/guile -s
!#

(define (expmod b e m)
  (cond ((= e 0) 1)
	((even? e)
	 (remainder (* (expmod b (/ e 2) m)
		       (expmod b (/ e 2) m))
		    m))
	(else
	  (remainder (* b (expmod b (- e 1) m))
		     m))))

#!

The above procedure loses the efficiency of the fast exponentiation method, and is
O(n) in time. This is because in the squaring of the expmod function, the two terms
need to each be evaluated separately. Each of these will require two additional
expmod terms to be evaluated, meaning that we have an exponentially growing number
of terms with 2^e. This means that overall our process is linear in e.

!#
