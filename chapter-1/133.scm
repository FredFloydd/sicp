#!/usr/bin/guile -s
!#

(define (repeated f n)
  (if (= n 0)
    (lambda (x) x)
    (lambda (x) (f ((repeated f (- n 1)) x)))))

(define (smooth f dx)
  (lambda (x)
    (/ (+ (f (- x dx))
	  (f x)
	  (f (+ x dx)))
       3)))

#!

The above functions allow repeated application of a given function, and the smoothing of a given
function. We can therefore obtain an n-fold smoothed function via:

!#

(define (n-fold-smoothed f dx n)
  (lambda (x)
    ((repeated (lambda (x)
		((smooth f dx) x))
	      n) x)))
