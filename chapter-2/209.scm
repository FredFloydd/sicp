#!/usr/bin/guile -s
!#

(define (make-interval a b)
  (cons a b))

(define (lower-bound interval)
  (car interval))

(define (upper-bound interval)
  (cdr interval))

(define (intmul x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
	(p2 (* (lower-bound x) (upper-bound y)))
	(p3 (* (upper-bound x) (lower-bound y)))
	(p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
		   (max p1 p2 p3 p4))))

(define (intdiv x y)
  (intmul x
	  (make-interval (/ 1 (upper-bound y))
			 (/ 1 (lower-bound y)))))

#!

This procedure for division will break if the input interval spans zero. The procedure
can be somewhat fixed if the following check is performed:

!#

(define (intdiv x y)
  (if (and (< (lower-bound y) 0) (> (upper-bound y) 0))
    (error "Input denominator spans zero")
    (intmul x
	  (make-interval (/ 1 (upper-bound y))
			 (/ 1 (lower-bound y))))))
