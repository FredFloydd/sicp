#!/usr/bin/guile -s
!#

(define (equal? a b)
  (cond ((and (pair? a) (pair? b))
	 (and (equal? (car a) (car b)) (equal? (cdr a) (cdr b))))
        ((and (null? a) (null? b))
	 #t)
        ((and (number? a) (number? b))
	 (= a b))
        ((and (symbol? a) (symbol? b))
	 (eq? a b))
        (else #f)))

#!

This procedure determines whether lists are equal to each other.

!#
