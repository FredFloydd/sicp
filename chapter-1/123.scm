#!/usr/bin/guile -s
!#

(define (simpson f a b n)

  (define h
    (/ (- b a) n))

  (define (sum first last term next)
    (if (> first last)
      0
      (+ (term first)
	 (sum (next first) last term next))))

  (define (func val)
    (f (+ a (* val h))))

  (define (term val)
    (cond ((= (remainder val n) 0) (func val))
	  ((even? val) (* (func val) 2))
	  (else (* (func val) 4))))

  (define (next val)
    (+ val 1))

  (* (/ h 3)
     (sum 0 n term next)))

(define (square x)
  (* x x))

(display (simpson square 0 10 100))


#!

This algorithm can integrate a given function using Simpson's rule.

!#
