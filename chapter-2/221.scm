#!/usr/bin/guile -s
!#

(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
	((or (< amount 0) (no-more? kinds-of-coins)) 0)
	(else (+ (cc (- amount (first-denomination kinds-of-coins))
		     kinds-of-coins)
		 (cc amount
		     (except-first-denomination kinds-of-coins))))))

#!

This procedure will count the ways of making change given a list of coin values. The procedure
can take a custom list of coins if we define the accompanying procedures in the following way:

!#

(define (first-denomination coins)
  (car coins))

(define (except-first-denomination coins)
  (cdr coins))

(define (no-more? coins)
  (null? coins))

#!

This is much cleaner than the method without lists. The order of the coins in the list does not
matter in the recursive case, but would in the iterative case.

!#
