#!/usr/bin/guile -s
!#

(define (iterative-improve good-enough? improve)
  (lambda (guess)
    (if (good-enough? guess)
      guess
      ((iterative-improve good-enough? improve) (improve guess)))))

#!

This method allows for a general iterative-improvement of guessing, for
finding roots or maxima of functions for example. We can express Newton's
method in this case as:

!#

(define (newton f initial-guess)

  (define (newton-check guess)
    (< (abs (f guess)) 0.00001))

  (define (deriv f dx)
    (lambda (x)
      (/ (- (f (+ x dx)) (f x))
	 dx)))

  (define (improve guess)
    (- guess (/ (f guess)
		((deriv f 0.00001) guess))))

  ((iterative-improve newton-check improve) initial-guess))

#!

We can also express our fixed-point search for maxima of functions via:

!#

(define (fixed-point f initial-guess)

  (define (fixed-check guess)
    (< (abs (- (f guess) guess)) 0.00001))

  (define (improve guess)
    (f guess))

  ((iterative-improve fixed-check improve) initial-guess))
