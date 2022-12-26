#!/usr/bin/guile -s
!#

(define (length x)
  (define (length-iter a count)
    (if (null? a)
      count
      (length-iter (cdr a) (+ count 1))))
  (length-iter x 0))

(define (nth n x)
  (cond ((= n 0) (car x))
	((= (length x) 1) x)
	(else (nth (- n 1) (cdr x)))))

(define (last x)
  (if (null? (cdr x))
    (car x)
    (last (cdr x))))

(define (append x y)
  (if (null? x)
    y
    (cons (car x) (append (cdr x) y))))

(define (fringe x)
  (define (fringe-iter x a)
      (cond ((null? x) a)
	    ((list? (car x)) (append (append a
					     (fringe (car x)))
				     (fringe (cdr x))))
	    (else (append (append a
				  (list (car x)))
			  (fringe (cdr x))))))
  (fringe-iter x (list)))

#!

This procedure 'flattens' lists

!#
