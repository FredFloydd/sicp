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
			(list '+ a1 a2)))
	((number? a2) (if (= a2 0)
			a1
			(list '+ a1 a2)))
	(else (list '+ a1 a2))))

(define (make-product m1 m2)
  (cond ((and (number? m1) (number? m2)) (* m1 m2))
	((number? m1)
	 (cond ((= m1 0) 0)
	       ((= m1 1) m2)
	       (else (list '* m1 m2))))
	((number? m2)
	 (cond ((= m2 0) 0)
	       ((= m2 1) m1)
	       (else (list '* m1 m2))))
	(else (list '* m1 m2))))

(define (sum? x)
  (if (list? x)
    (eq? (car x) '+)
    #nil))

(define (addend s)
  (cadr s))

(define (augend s)
  (caddr s))

(define (product? x)
  (if (list? x)
    (eq? (car x) '*)
    #nil))

(define (multiplier p)
  (cadr p))

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

This defines differentiation for simple expressions with sums and products. We can extend this to include
differentiation of exponents as follows:

!#

(define (exponentiation? x)
  (if (list? x)
    (eq? (car x) '**)
    #nil))

(define (base e)
  (cadr e))

(define (exponent e)
  (caddr e))

(define (make-exponentiation b e)
  (cond ((and (number? b) (number? e)) (exp b e))
	((number? e)
	 (cond ((= e 0) 1)
	       ((= e 1) b)
	       (else (list '** b e))))
	((number? b)
	 (cond ((= 0 b) 0)
	       ((= 1 b) 1)
	       (else (list '** b e))))
	(else (list '** b e))))

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
			 (multiplicand exp))))
	((exponentiation? exp)
	 (make-product
	   (make-product (exponent exp)
			 (make-exponentiation (base exp) (make-sum (exponent exp) -1)))
	   (deriv (base exp) var)))))

#!

Care needs to be taken over what expressions are put into the procedure, as currently
we cannot differentiate expressions of the form (** x x). For this, more sophisticated
algebra is required.

#!
