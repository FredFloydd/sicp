#!/usr/bin/guile -s
!#

(define (square x)
  (* x x))

(define (divides? a b)
  (= (remainder b a) 0))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
	((divides? test-divisor n) test-divisor)
	(else (find-divisor n (+ test-divisor 1)))))

(define (smallest-divisor n)
  (find-divisor n 2))

#!

This algorithm is an O(sqrt(n)) proceess to find the smallest integral divisor of a number. We
can use it to evaluate the smallest divisors of:

!#

(display (smallest-divisor 199))
(display "\n")
(display (smallest-divisor 1999))
(display "\n")
(display (smallest-divisor 19999))
