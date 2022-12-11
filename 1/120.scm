#!/usr/bin/guile -s
!#

#!

We have a proposed exponentiation procedure of:

!#

(define (expmod base exp m)
  (remainder (fast-exp base exp) m))

#!

This procedure would work in theory, however in practice it is unlikely that it would. When
we are searching for large primes, our exponent will be very large, and it would be totally
infeasible to store numbers to enough precision to obtain the correct answer. This method
would never work for primes over 100.

#!
