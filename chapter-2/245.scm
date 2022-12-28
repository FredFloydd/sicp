#!/usr/bin/guile -s
!#

(define global-array '())

(define (make-entry k v) (list k v))
(define (key entry) (car entry))
(define (value entry) (cadr entry))

(define (put op type item)
  (define (put-helper k array)
    (cond ((null? array) (list(make-entry k item)))
          ((equal? (key (car array)) k) array)
          (else (cons (car array) (put-helper k (cdr array))))))
  (set! global-array (put-helper (list op type) global-array)))

(define (get op type)
  (define (get-helper k array)
    (cond ((null? array) #f)
          ((equal? (key (car array)) k) (value (car array)))
          (else (get-helper k (cdr array)))))
  (get-helper (list op type) global-array))

#!

This defines put and get functions, which are not supplied by guile.

!#


(define (deriv exp var)
  (cond ((constant? exp) 0)
	((variable? exp)
	 (if (same-variable? exp var) 1 0))
	(else ((get (operator exp) 'deriv) (operands exp) var))))

(define (operator exp)
  (car exp))

(define (operands exp)
  (cdr exp))

#!

This re-writes our symbolic differentiation procedure in a data-directed way. In our table
we will have a column called 'deriv which contains methods for how to differentiate expressions
with given operators. If our expression is neither a constant nor a single-variable, we
apply the function found in the 'deriv row for that operator to our expression. We can't
assimilate the constant? or same-variable? predicates into our dispatch because they operate
on atomic data - numbers and symbols respectively. These do not have a type in the same way as
our operator expressions.

!#

(define (constant? x)
  (number? x))

(define (variable? x)
  (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (make-sum a1 a2)
  (list '+ a1 a2))

(define (make-product m1 m2)
  (list '* m1 m2))

(define (addend s)
  (car s))

(define (augend s)
  (cadr s))

(define (multiplier p)
  (car p))

(define (multiplicand p)
  (cadr p))

(define (deriv-sum s var)
  (make-sum (deriv (addend s) var)
	    (deriv (augend s) var)))

(define (deriv-product p var)
  (make-sum (make-product (multiplier p)
			  (deriv (multiplicand p) var))
	    (make-product (deriv (multiplier p) var)
			  (multiplicand p))))

#!

These procedures give methods for differentiating products and sums of expressions. We can install
them into our dispatch via the following:

!#

(put '+ 'deriv deriv-sum)
(put '* 'deriv deriv-product)

#!

We can extend the functionality of our program by including other types of expression. For example,
we can include powers via:

!#

(define (make-power b p)
  (list '** b p))

(define (base e)
  (car e))

(define (power e)
  (cadr e))

(define (deriv-power e var)
  (make-product (power e)
		(make-product (make-power (base e)
						   (make-sum (power e) -1))
			      (deriv (base e) var))))

(put '** 'deriv deriv-power)

#!

We can now differentiate expressions made up of sums, products and powers.

!#

#!

If we indexed our dispatch like:

((get 'deriv (operator exp)) (operands exp) var)

The only change we would need to make is in our put function.

!#
