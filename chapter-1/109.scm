#!/usr/bin/guile -s
!#

(define (count-change amount)
  (cc amount 5))

(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
	((or (< amount 0) (= kinds-of-coins 0)) 0)
	(else (+ (cc (- amount
			(first-denomination kinds-of-coins))
		     kinds-of-coins)
		 (cc amount
		     (- kinds-of-coins 1))))))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
	((= kinds-of-coins 2) 5)
	((= kinds-of-coins 3) 10)
	((= kinds-of-coins 4) 25)
	((= kinds-of-coins 5) 50)))

#!

This is a tree-recursive process, which is very time inefficient. We wish
to re-implement the process such that it is iterative.

This can be done like so:

!#

(define (count-change-iter amount)

  (define (cc-iter amount fifties quarters tens fives)
    (cond ((> (* fifties 50) amount) 0)
	  ((> (+ (* fifties 50)
		 (* quarters 25)) amount)
	   (cc-iter amount (+ fifties 1) 0 0 0))
	  ((> (+ (* fifties 50)
		 (* quarters 25)
		 (* tens 10)) amount)
	   (cc-iter amount fifties (+ quarters 1) 0 0))
	  ((> (+ (* fifties 50)
		 (* quarters 25)
		 (* tens 10)
		 (* fives 5)) amount)
	   (cc-iter amount fifties quarters (+ tens 1) 0))
	  (else (+ 1
		   (cc-iter amount fifties quarters tens (+ fives 1))))))

  (cc-iter amount 0 0 0 0))

#!

This algorithm keeps track of the number of each coin being used at a given
time. The number of ways of summing to the amount will be the number of ways
of combining the large coins (those with value greater than one) such that
their total value is less than the amount. The remaining amount is then filled
by ones.

This algorithm starts by counting the number of ways of adding to the amount
using only fives. Next it counts the ways of using fives and tens. It continues
doing so, finding all the ways of summing to the amount using the smallest coins
possible at a given stage until it has counted all the ways of summing to the
amount.

!#
