#!/usr/bin/guile -s
!#

#!

The width of the interval resulting from an addition of two intervals is dependent only on the
width of the initial intervals. Consider two intervals (L1 U1) and (L2 U2). The resulting interval
will be (L1+L2 U1+U2).

The width of this resulting interval is:

w = (U1+U2) - (L1+L2)
  = (U1-L1) + (U2-L2)
  = w1 + w2

The width of the result is the sum of the widths of the starting intervals. We can show the same
for a subtraction of intervals where we end up with (L1-U2 U1-L2). Here we have a resulting width
of:

w = (U1-L2) - (L1-U2)
  = (U1-L1) + (U2-L2)
  = w1 + w2

Once again, the width is the sum of the initial widths.

This no longer works for multiplication or division. Consider multiplication of the same intervals.
Consider the case where all values in our intervals are positive. We then have result (L1L2 U1U2).
This has width:

w = U1U2 - L1L2

This cannot be expressed in terms of only the widths of the original intervals.

!#
