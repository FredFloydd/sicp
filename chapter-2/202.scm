#!/usr/bin/guile -s
!#

(define (make-segment point1 point2)
  (cons point1 point2))

(define (start-point segment)
  (car segment))

(define (end-point segment)
  (cdr segment))

(define (make-point x y)
  (cons x y))

(define (midpoint segment)

  (define (average a b)
    (/ (+ a b) 2))

  (let ((point1 (car segment))
	(point2 (cdr segment)))
    (make-point (average (car point1) (car point2))
		(average (cdr point1) (cdr point2)))))

#!

These procedures define a data structure for line segments in a 2D plane. We can find the
midpoint of a segment and select its first and last points.

!#
