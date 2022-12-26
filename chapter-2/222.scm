#!/usr/bin/guile -s
!#

#!

If we create and print the combination (list 1 (list 2 (list 3 4))), the console will display:

(1 (2 (3 4)))

!#

(display (list 1 (list 2 (list 3 4))))
