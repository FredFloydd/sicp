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

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
	(else else-clause)))

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
	  guess
	  (sqrt-iter (improve guess x)
		     x)))

(define (sqrt x)
  (sqrt-iter 1 x))

(display (sqrt 25))

#!

The program gets stuck in another loop. Cond statements allow for multiple expressions within
their cases, so the interpreter tries to expand the sqrt-iter function in the else case. As
the recursion has no exit point without evaluating the good-enough? function, the interpreter
never escapes and is stuck expanding forever.

!#
