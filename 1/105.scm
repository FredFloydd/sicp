#!/usr/bin/guile -s
!#

(define (square x) (* x x))

(define (abs x)
  (if (> x 0)
    x
    (- x)))

(define (average x y) (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
	  guess
	  (sqrt-iter (improve guess x)
		     x)))

(define (sqrt x)
  (sqrt-iter 1 x))

#!

The good-enough? test will fail for small and large values of x. For small values, such as the square root
of 0.0000001, we can satisfy our tolerance while being nearly an order of magnitude out on our estimate
for the root. This is because our tolerance is a hard coded number that doesn't account for the size of our
input. This issue would not arise if our tolerance was scaled with the size of x. For large values, we begin
to lose precision in the floating-point representations of numbers past a given size, due to having a finite
amount of memory to store numbers in. Once numbers begin to exceed this amount of precision, we will not be
able to determine whether numbers differ by less than our tolerance, as it is too small. Again, this will
lead to an incorrect calculation of the square root.

!#

(define (new-good-enough? guess prev_guess)
  (< (abs(- guess prev_guess)) (* guess 0.001)))

(define (new-sqrt-iter guess prev_guess x)
  (if (new-good-enough? guess prev_guess)
    guess
    (new-sqrt-iter (improve guess x)
		   guess
		   x)))

(define (new-sqrt x)
  (new-sqrt-iter 1 2 x))

(display (new-sqrt 0.000001))

#! This new algorithm works by comparing the guess with the previous guess, and sees if they differ by less
than one part in a thousand. This works better for small and large numbers because the tolerance now scales
with the size of the root.

!#
