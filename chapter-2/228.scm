#!/usr/bin/guile -s
!#

#!

The following the expressions will be evaluated by the interpreter in the following way:

(list 'a 'b 'c)					(a b c)

(list (list 'george)) 				((george))

(cdr '((x1 x2) (y1 y2)))			(y1 y2)

(cadr '((x1 x2) (y1 y2)))			y1

(atom? (car '(a short list)))			#t

(memq 'red '((red shoes) (blue socks)))		()

(memq 'red '(red shoes blue socks))		(red shoes blue socks)

!#
