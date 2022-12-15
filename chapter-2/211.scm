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

#!

The above procedures allow for the creation of intervals defined by a center and
a width. We can also define intervals via a center and a width given by a percentage
of the center:

!#

(define (make-center-percent c p)
  (let ((width (* (abs c) p 0.01)))
    (make-interval (- c width) (+ c width))))

(define (percent i)
  (* (/ (width i) (abs (center i))) 100))
