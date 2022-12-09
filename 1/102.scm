#!/usr/bin/guile -s
!#

(define (square x) (* x x))

(define (sum-of-largest-squares x y z) (cond ((and (< x y) (< x z)) (+ (square y) (square z)))
					     ((and (< y x) (< y z)) (+ (square x) (square z)))
					     (else (+ (square x) (square y)))))

(display (sum-of-largest-squares 1 5 10))
(display "\n")
(display (sum-of-largest-squares 11 5 10))
(display "\n")
(display (sum-of-largest-squares 1 -5 10))
