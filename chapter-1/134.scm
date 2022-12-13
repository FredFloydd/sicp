#!/usr/bin/guile -s
!#

(define (newton f guess)
  (if (good-enough? guess f)
    guess
    (newton f (improve guess f))))

(define (improve guess f)
  (- guess (/ (f guess)
	      ((deriv f 0.001) guess))))

(define (deriv f dx)
  (lambda (x)
    (/ (- (f (+ x dx)) (f x))
       dx)))

(define (good-enough? guess f)
  (< (abs (f guess)) 0.001))

(define (cubic a b c)
  (lambda (x)
    (+ (* x x x)
       (* a x x)
       (* b x)
       c)))

#!

We can approximate roots to cubic equations defined by

y = x^3 + ax^2 + bx + c

using our Newton method with a cubic input. For example:

!#

(display (newton (cubic -6 12 -8) 1))
