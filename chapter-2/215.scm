#!/usr/bin/guile -s
!#

#!

In general, equivalent algebraic expressions may lead to different answers due to floating point
representations of numbers not being totally precise. It would be possible to define an interval
arithmetic package that can perform addition, subtraction, multiplication and division of intervals
by storing the upper and lower bound of each interval as a rational number. The operations would
then be performed with perfect precision, as these operations will always lead to another rational
number. The intervals would be made up of a pair of pairs of integers.

!#
