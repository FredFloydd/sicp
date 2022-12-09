#!/usr/bin/guile -s
!#

(define (p) (p))

(define (test x y)
  (if (= x 0)
    0
    y))

(display (test 0 (p)))


#!

If a normal-order interpreter is used, the interpreter will try to expand (p). As (p) returns a procedure
as its result, it will try to expand (p) again, getting stuck in a loop. The program will get stuck. If an
applicative-order approach is taken, the interpreter will evaluate the predicate of the if statement,
and see that it is true. It will then immediately return 0, as it need not evaluate further. This method
of evaluation does not get stuck in a loop.

!#
