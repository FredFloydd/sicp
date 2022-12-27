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

(define (intersection-set set1 set2)
  (if (or (null? set1) (null? set2))
    '()
    (let ((x1 (car set1))
	  (x2 (car set2)))
      (cond ((= x1 x2)
	     (cons x1
		   (intersection-set (cdr set1)
				     (cdr set2))))
	    ((< x1 x2)
	     (intersection-set (cdr set1)
			       set2))
	    ((< x2 x1)
	     (intersection-set set1
			       (cdr set2)))))))

(define (union-set set1 set2)
  (if (null? set1)
    set2
    (let ((x1 (car set1))
	  (x2 (car set2)))
      (cond ((= x1 x2)
	     (cons x1 (union-set (cdr set1)
				 (cdr set2))))
	    ((< x1 x2)
	     (cons x1 (union-set (cdr set1)
				 set2)))
	    ((< x2 x1)
	     (cons x2 (union-set set1
				 (cdr set2))))))))

#!

These methods fully extend our set manipulation procedures to ordered lists. Note that intersection
and union now have a time complexity of O(n).

!#
