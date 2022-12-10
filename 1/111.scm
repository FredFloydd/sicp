#!/usr/bin/guile -s
!#

(define (square x)
  (* x x))

(define (even? n)
  (= (remainder n 2) 0))

(define (fast-exp b n)
  (cond ((= n 0) 1)
	((even? n) (square (fast-exp b (/ n 2))))
	(else (* b (fast-exp b (- n 1))))))

#!

This algorithm recursively calculates exponentials, but is linear in n with memory. By
defining an iterative process we can use constant memory. This can be done with the
following algorithm:

!#

(define (fast-exp-iter a b n)
  (cond ((= n 0) a)
	((even? n) (fast-exp-iter a (square b) (/ n 2)))
	(else (fast-exp-iter (* a b) b (- n 1)))))
