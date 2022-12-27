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


(define (element-of-set? x set)
  (cond ((null? set) #nil)
	((equal? x (car set)) #t)
	(else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (element-of-set? x set)
    set
    (cons x set)))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
	((element-of-set? (car set1) set2)
	 (cons (car set1)
	       (intersection-set (cdr set1) set2)))
	(else (intersection-set (cdr set1) set2))))

(define (union-set set1 set2)
  (if (null? set1)
    set2
    (union-set (cdr set1)
	       (adjoin-set (car set1) set2))))

#!

The above procedures define basic set operations for a simple representation of sets,
where the set is a list with elements only appearing once.

!#
