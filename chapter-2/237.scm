#!/usr/bin/guile -s
!#

#!

The tree representation of sets has an O(n log(n)) algorithm for finding the union of
sets. Each item in the first set needs to be added to the second set. Adding can be
done in log(n) steps, and there are n elements to add.

!#
