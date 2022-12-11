#!/usr/bin/guile -s
!#


(define (product-rec first last term next)
  (if (> first last)
    1
    (* (term first)
       (product-rec (next first) last term next))))


(define (product-iter first last term next)

  (define (iter a result)
    (if (> first last)
      result
      (iter (next first)
	    (* (term first) result))))

  (iter first 1))

#!

These processes find the product of a sequence of terms. They are both O(n) in the number of terms
being multiplied, but have different memory complexity. The first is linear recursive and therefore
takes O(n) memory, while the second is iterative and takes O(1) memory. We can define a function to
calculate factorials via:

!#

(define (identity n)
  n)

(define (inc n)
  (+ n 1))

(define (factorial n)
  (product-iter 1 n identity inc))

(display (factorial 5))
(display "\n")

#!

We can also calculate approximations to pi via:

!#

(define (frac n)
  (if (even? n)
    (/ n (+ n 1))
    (/ (+ n 1) n)))

(define (pi-approx n)
  (* 4 (product-iter 2 n frac inc)))

(display (exact->inexact (pi-approx 10000)))
