#!/usr/bin/guile -s
!#

#!

If we assume that the percentage tolerances in our intervals are small, and that all
centers are positive, we can sum the percentage tolerances when multiplying intervals:

(L U) = (c1*(1-0.01p1) c1*(1+0.01p1) * (c2*(1-0.01p2) c2*(1+0.01p2)

L = c1c2 - 0.01(p1+p2)c1c2 + 0.0001p1p2c1c2 ~ c1c2(1-0.01(p1+p2)) = c1c2(1-0.01p)
U = c1c2 + 0.01(p1+p2)c1c2 + 0.0001p1p2c1c2 ~ c1c2(1+0.01(p1+p2)) = c1c2(1+0.01p)

!#
