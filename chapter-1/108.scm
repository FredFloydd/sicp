#!/usr/bin/guile -s
!#

(define (A x y)
  (cond ((= y 0) 0)
	((= x 0) (* 2 y))
	((= y 1) 2)
	(else (A (- x 1)
		 (A x (- y 1))))))


#!

We have (A 1 n) = 2^n for n > 0. Thus (A 1 10) = 1024.

We then have (A 2 4) = (A 1 (A 2 3))
                     = (A 1 (A 1 (A 2 2)))
                     = (A 1 (A 1 (A 1 (A 2 1))))
		     = (A 1 (A 1 (A 1 2)))
		     = (A 1 (A 1 4))
		     = (A 1 16)
		     = 65536

In fact we can show that (A 2 n) = 2^^n

Finally we have (A 3 3) = (A 2 (A 3 2))
			= (A 2 (A 2 (A 3 1)))
			= (A 2 (A 2 2))
			= (A 2 4)
			= 65536

Now consider the following functions

!#

(define (f n) (A 0 n))

(define (g n) (A 1 n))

(define (h n) (A 2 n))

#!

From above we have that:

(f n) = 2n
(g n) = 2^n
(h n) = 2^^n

!#
