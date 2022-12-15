#!/usr/bin/guile -s
!#

(define (make-interval a b)
  (cons a b))

(define (lower-bound interval)
  (car interval))

(define (upper-bound interval)
  (cdr interval))

#!

We have nine possible cases for inteval multiplication. These are:

LB1   UB1   LB2   UB2   M   LB     UB

-ve   -ve   -ve   -ve   2   U1U2   L1L2
-ve   -ve   -ve   +ve   2   L1U2   L1L2
-ve   -ve   +ve   +ve   2   L1U2   U1L2
-ve   +ve   -ve   -ve   2   U1L2   L1L2
-ve   +ve   -ve   +ve   4
-ve   +ve   +ve   +ve   2   L1U2   U1U2
+ve   +ve   -ve   -ve   2   U1L2   L1U2
+ve   +ve   -ve   +ve   2   U1L2   U1U2
+ve   +ve   +ve   +ve   2   L1L2   U1U2

Based off this table we can create a faster procedure for interval
multiplication:

!#

(define (intmul x y)
  (let ((L1 (lower-bound x))
	(U1 (upper-bound x))
	(L2 (lower-bound y))
	(U2 (upper-bound y)))
  (cond ((and (< L1 0) (< U1 0) (< L2 0) (< U2 0)) (make-interval (* U1 U2) (* L1 L2)))
	((and (< L1 0) (< U1 0) (< L2 0) (> U2 0)) (make-interval (* L1 U2) (* L1 L2)))
	((and (< L1 0) (< U1 0) (> L2 0) (> U2 0)) (make-interval (* L1 U2) (* U1 L2)))
	((and (< L1 0) (> U1 0) (< L2 0) (< U2 0)) (make-interval (* U1 L2) (* L1 L2)))
	((and (< L1 0) (> U1 0) (< L2 0) (> U2 0)) (make-interval (* L1 U2) (* U1 U2)))
	((and (> L1 0) (> U1 0) (< L2 0) (< U2 0)) (make-interval (* U1 L2) (* L1 U2)))
	((and (> L1 0) (> U1 0) (< L2 0) (> U2 0)) (make-interval (* U1 L2) (* U1 U2)))
	((and (> L1 0) (> U1 0) (> L2 0) (> U2 0)) (make-interval (* L1 L2) (* U1 U2)))
	(else (let ((p1 (* L1 L2))
		    (p2 (* L1 U2))
		    (p3 (* U1 L2))
		    (p4 (* U1 U2)))
		(make-interval (min p1 p2 p3 p4)
			       (max p1 p2 p3 p4)))))))
