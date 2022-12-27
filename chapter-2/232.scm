#!/usr/bin/guile -s
!#

(define (constant? x)
  (number? x))

(define (variable? x)
  (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (make-sum a1 a2)
  (cond ((and (number? a1) (number? a2)) (+ a1 a2))
	((number? a1) (if (= a1 0)
			a2
			(list a1 '+ a2)))
	((number? a2) (if (= a2 0)
			a1
			(list a1 '+ a2)))
	(else (list a1 '+ a2))))

(define (make-product m1 m2)
  (cond ((and (number? m1) (number? m2)) (* m1 m2))
	((number? m1)
	 (cond ((= m1 0) 0)
	       ((= m1 1) m2)
	       (else (list m1 '* m2))))
	((number? m2)
	 (cond ((= m2 0) 0)
	       ((= m2 1) m1)
	       (else (list m1 '* m2))))
	(else (list m1 '* m2))))

(define (sum? x)
  (if (list? x)
    (eq? (cadr x) '+)
    #nil))

(define (addend s)
  (car s))

(define (augend s)
  (caddr s))

(define (product? x)
  (if (list? x)
    (eq? (cadr x) '*)
    #nil))

(define (multiplier p)
  (car p))

(define (multiplicand p)
  (caddr p))

(define (deriv exp var)
  (cond ((constant? exp) 0)
	((variable? exp)
	 (if (same-variable? exp var)
	   1
	   0))
	((sum? exp)
	 (make-sum (deriv (addend exp) var)
		   (deriv (augend exp) var)))
	((product? exp)
	 (make-sum
	   (make-product (multiplier exp)
			 (deriv (multiplicand exp) var))
	   (make-product (deriv (multiplier exp) var)
			 (multiplicand exp))))))


#!

This version of our differentiation procedure will take input with infix operators, such
as (5 + (3 * x)). We have only changed the constructors and selectors.

!#
