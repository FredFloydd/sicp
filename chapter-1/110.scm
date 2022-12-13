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

(display (count-change 11))

#!

If we call this procedure with an amount of 11, the following recursion takes place:

                                                 (cc 11 3)
                                /                                    \
                (cc 1 3)                                                       (cc 11 2)
             /            \                                                 /              \
  (cc -9 3)                  (cc 1 2)                             (cc 6 2)                    (cc 11 1)
                            /        \                           /        \                  /         \
     = 0            (cc -4 2)      (cc 1 1)               (cc 1 2)        (cc 6 1)     (cc 10 1)       (cc 11 0)
                                   /       \             /        \
                       = 0    (cc 0 1)  (cc 1 0)   (cc -4 2)     (cc 1 1)   (= 1)         (= 1)            = 1
                                                                /        \
                                 = 1       = 0        = 0   (cc 0 1)   (cc 1 0)

                                                               = 1        = 0

We find that (cc 11 3) = 4. The bracketed terms (= 1) will eventually resolve to 1,
but take six and ten steps respectively to be fully evaluated. The process is O(n)
in memory (the maximum depth of the tree is n), and O(exp(n)) in time.

!#
