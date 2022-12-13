#!/usr/bin/guile -s
!#

(define (square x) (* x x))

(define (abs x)
  (if (> x 0)
    x
    (- x)))

(define (improve guess x)
  (/ (+ (/ x (square guess))
	(* guess 2))
     3))

(define (good-enough? guess prev_guess)
  (< (abs(- guess prev_guess)) (* guess 0.001)))

(define (cube-root-iter guess prev_guess x)
  (if (good-enough? guess prev_guess)
    guess
    (cube-root-iter (improve guess x)
		    guess
		    x)))

(define (cube-root x)
  (cube-root-iter 1 2 x))

(display (cube-root 27))
