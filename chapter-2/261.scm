#!/usr/bin/guile -s
!#

; Create and install methods for adding, subtracting and multiplying polynomials

(define (+poly p1 p2)
  (if (same-variable? (variable p1) (variable p2))
    (make-polynomial (variable p1)
		     (+terms (term-list p1)
			     (term-list p2)))
    (error "Polynomials not in same variable -- +POLY" (list p1 p2))))

(define (-poly p1 p2)
  (if (same-variable? (variable p1) (variable p2))
    (make-polynomial (variable p1)
		     (-terms (term-list p1)
			     (term-list p2)))
    (error "Polynomials not in same variable -- -POLY" (list p1 p2))))

(define (*poly p1 p2)
  (if (same-variable? (variable p1) (variable p2))
    (make-polynomial (variable p1)
		     (*terms (term-list p1)
			     (term-list p2)))
    (error "Polynomials not in same variable -- *POLY" (list p1 p2))))


(put 'polynomial 'add +poly)
(put 'polynomial 'mul *poly)

; Sub-procedures for addition, subtraction and multiplication for dense lists

(define (+terms-dense L1 L2)
  (cond ((empty-termlist? L1) L2)
	((empty-termlist? L2) L1)
	(else (cons (add (first-term L1)
			 (first-term L2))
		    (+terms-dense (rest-terms L1)
				  (rest-terms L2))))))
(define (-terms-dense L1 L2)
  (cond ((empty-termlist? L1) L2)
	((empty-termlist? L2) L1)
	(else (cons (sub (first-term L1)
			 (first-term L2))
		    (-terms-dense (rest-terms L1)
				  (rest-terms L2))))))

(define (*terms-dense L1 L2)
  (if (empty-termlist? L1)
    (the-empty-termlist)
    (+terms-dense (*-term-by-all-terms-dense (first-term L1) L2)

  )

(define (add-at-order L coeff order)
  (if (zero? order)
    (cons (add (first-term L)
	       coeff)
	  (rest-terms L))
    (cons (first-term L)
	  (add-at-order (rest-terms L)
			coeff
			(- order 1)))))

; Implementation of dense term lists

(define (

; Implementation of polynomials as an arithmetic type

(define (make-polynomial variable term-list)
  (attach-type 'polynomial (cons variable term-list)))

(define (variable p)
  (car p))

(define (term-list p)
  (cdr p))

; Definition of zero check for polynomials

(define (termlist-zero? L)
  (if (empty-termlist? L)
    #t
    (and (zero? (first-term L))
	 (termlist-zero? (rest-terms L)))))

(define (poly-zero? p)
  (termlist-zero? (term-list p)))

(put 'polynomial '=zero? poly-zero?)
