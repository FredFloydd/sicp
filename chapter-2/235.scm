#!/usr/bin/guile -s
!#

(define (element-of-set? x set)
  (cond ((null? set) #nil)
	((= x (car set)) #t)
	((< x (car set)) #nil)
	(else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (cond ((null? set) x)
	((= x (car set)) set)
	((< x (car set)) (cons x set))
	(else (cons (car set) (adjoin-set x (cdr set))))))

#!

This procedure extends adjoining to ordered sets. It will on average require
half as many operations as in the case of unordered sets.

!#
