#!/usr/bin/guile -s
!#


(define (accumulator-rec combiner null-value a b term next)
  (if (> a b)
    null-value
    (combiner (term a)
	      (accumulator-rec combiner null-value (next first) last term next))))


(define (accumulator-iter combiner null-value a b term next)

  (define (iter a result)
    (if (> a b)
      result
      (iter (next a)
	    (combiner (term a) result))))

  (iter a null-value))

#!

These processes define a more general accumulation process. We can implement our sum
and product as accumulators:

!#

(define (sum a b term next)

  (define (add x y)
    (+ x y))

  (accumulator-iter add 0 a b term next))

(define (product a b term next)

  (define (times x y)
    (* x y))

  (accumulator-iter times 1 a b term next))
