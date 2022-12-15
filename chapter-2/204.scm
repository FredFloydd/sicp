#!/usr/bin/guile -s
!#

#!

We can represent pairs of nonnegative integers (a,b) as a single number by letting the pair
(a,b) -> 2^a * 3^b. This maps each pair to a unique integer value. We can add pairs together
by multiplying their single integer representations.

In this case we would have constructor and selectors:

!#

(define (cons a b)
  (* (expt 2 a) (expt 3 b)))

(define (divisions int divisor n)
  (if (= (remainder int divisor) 0)
    (divisions (/ int divisor) divisor (+ n 1))
    n))

(define (car int)
  (divisions int 2 0))

(define (cdr int)
  (divisions int 3 0))
