#!/usr/bin/guile -s
!#

(define (accumulator combiner null-value a b term next)

  (define (iter a result)
    (if (> a b)
      result
      (iter (next a)
	    (combiner (term a) result))))

  (iter a null-value))

(define (max a b)
  (if (> a b)
    a
    b))

#!

We can use this accumulator method to find the maximum value of a function via brute force.
This can be done as follows:

!#

(define (find-maximum f a b n)
  (let ((h (/ (- b a) n)))
    (accumulator max (f a) a b f (lambda (x) (+ x h)))))

(display (find-maximum (lambda (x) (* x x)) 1 2 100))
