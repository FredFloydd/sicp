#!/usr/bin/guile -s
!#

(define (gcd a b)
  (if (= b 0)
    a
    (gcd b (remainder a b))))

#!

Consider evaluating (gcd 206 40) with a normal-order interpreter. We have:

(gcd 206 40)
(gcd 40 (remainder 206 40))
(gcd 40 6)
(gcd 6 (remainder 40 6))
(gcd 6 4)
(gcd 4 (remainder 6 4))
(gcd 4 2)
(gcd 2 (remainder 4 2))
(gcd 2 0)
2

The time complexity of this process is O(log(b)).

!#
