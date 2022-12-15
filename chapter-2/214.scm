#!/usr/bin/guile -s
!#

(define (make-interval a b)
  (cons a b))

(define (lower-bound interval)
  (car interval))

(define (upper-bound interval)
  (cdr interval))

(define (center-width c w)
  (make-interval (- c w) (+ c w)))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (make-center-percent c p)
  (let ((width (* (abs c) p 0.01)))
    (make-interval (- c width) (+ c width))))

(define (percent i)
  (* (/ (width i) (abs (center i))) 100))

(define (intadd x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
		 (+ (upper-bound x) (upper-bound y))))

(define (intsub x y)
  (make-interval (- (lower-bound x) (upper-bound y))
		 (- (upper-bound x) (lower-bound y))))

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

(define (par1 r1 r2)
  (intdiv (intmul r1 r2)
	  (intadd r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (intdiv one
	    (intadd (intdiv one r1)
		    (intdiv one r2)))))

(define a (make-center-percent 10 1))
(define b (make-center-percent 20 1))

(define a-div-a (intdiv a a))
(define a-div-b (intdiv a b))

(display (center a-div-a))
(newline)
(display (percent a-div-a))
(newline)
(display (center a-div-b))
(newline)
(display (percent a-div-b))
(newline)
(display (center (par1 a b)))
(newline)
(display (center (par2 a b)))

#!

The two methods obtain different answers because of finite floating point precision in the values being
stored. The second method is better because it only uses each interval once. This means that inaccuracies
in performing operations with the interval only come into the calculation in one place instead of two.
This means less deviation from the correct value for the parallel resistance occurs.

!#
