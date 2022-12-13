#!/usr/bin/guile -s
!#

#!

Our methods for finding the maximum point of a unimodal function over a given domain (a,b) converge
at different speeds. Our brute force method has an error which is proportional to n^(-1) if we have
n steps. Meanwhile our golden ratio method has an error which is proportional to (phi)^(-n).

In the case where we have domain (0,1) and we wish to determine our maximum point to within an
accuracy of 0.001, for each of the methods we require:

Brute Force: 1000 steps
Golden Ratio: 15 steps

!#
