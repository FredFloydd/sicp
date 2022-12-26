#!/usr/bin/guile -s
!#

(define x (list 1 2 3))
(define y (list 4 5 6))

#!

If we execute the following commands, the corresponding results will be output by the interpreter:

(append x y)					(1 2 3 4 5 6)

(cons x y)					((1 2 3) 4 5 6)

(list x y)					((1 2 3) (4 5 6))

The append procedure simply appends the values in y onto the end of x. The cons procedure creates
a pair where the first item is x and the second item points to the first value in y, which is itelf
a pair. Finally, the list procedure creates a list where the first item is the list x, and the second
item is the list y.

!#
