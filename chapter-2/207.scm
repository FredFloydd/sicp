#!/usr/bin/guile -s
!#

(define (make-interval a b)
  (cons a b))

(define (lower-bound interval)
  (car interval))

(define (upper-bound interval)
  (cdr interval))


(define (intsub x y)
  (make-interval (- (lower-bound x) (upper-bound y))
		 (- (upper-bound x) (lower-bound y))))

#!

This procedure defines how to subtract confidence intervals from one another. The lower bound
of the resulting interval will be the lower bound of the first minus the upper bound of the
second, while the upper bound will be the upper bound of the first minus the lower bound of
the second.

!#
