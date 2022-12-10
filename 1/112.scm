#!/usr/bin/guile -s
!#

#!

We can define a fast multiplication process which uses the same principles as our fast exponentiation
algorithm, but using doubling instead of squaring. This is as follows:

!#

(define (halve x)
  (/ x 2))

(define (double x)
  (* x 2))

(define (even? n)
  (= (remainder n 2) 0))

(define (fast-mult-iter n a b)
  (cond ((= b 0) n)
	((even? b) (fast-mult-iter n (double a) (halve b)))
	(else (fast-mult-iter (+ n a) a (- b 1)))))
