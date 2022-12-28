#!/usr/bin/guile -s
!#

(define (attach-type type contents)
  (if (number? contents)
    contents
    (cons type contents)))

(define (type datum)
  (cond ((number? datum) 'number)
	((not (atom? datum)) (car datum))
	(else (error "Bad typed datum -- TYPE" datum))))

(define (contents datum)
  (cond ((number? datum) datum)
	((not (atom? datum)) (cdr datum))
	(else (error "Bad typed datum -- CONTENTS" datum))))

#!

These procedures change our typing to take advantage of Lisp's internal typing system.

#!
