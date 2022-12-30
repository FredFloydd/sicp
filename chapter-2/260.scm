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

; Sub-procedures for addition, subtraction and multiplication

(define (+terms L1 L2)
  (cond ((empty-termlist? L1) L2)
	((empty-termlist? L2) L1)
	(else
	  (let ((t1 (first-term L1))
		(t2 (first-term L2)))
	    (cond ((> (order t1) (order t2))
		   (adjoin-term t1
				(+terms (rest-terms L1) L2)))
		  ((< (order t1) (order t2))
		   (adjoin-term t2
				(+terms L1 (rest-terms L2))))
		  (else
		    (adjoin-term (make-term (order t1)
					    (add (coeff t1)
						 (coeff t2)))
				 (+terms (rest-terms L1)
					 (rest-terms L2)))))))))

(define (-terms L1 L2)
  (cond ((empty-termlist? L1) (negate L2))
	((empty-termlist? L2) L1)
	(else
	  (let ((t1 (first-term L1))
		(t2 (first-term L2)))
	    (cond ((> (order t1) (order t2))
		   (adjoin-term t1
				(-terms (rest-terms L1) L2)))
		  ((< (order t1) (order t2))
		   (adjoin-term t2
				(-terms L1 (rest-terms L2))))
		  (else
		    (adjoin-term (make-term (order t1)
					    (sub (coeff t1)
						 (coeff t2)))
				 (-terms (rest-terms L1)
					 (rest-terms L2)))))))))

(define (negate L)
  (if (empty-termlist? L)
    (the-empty-termlist)
    (adjoin-term (make-term (order (first-term L))
			    (sub 0 (coeff (first-term L))))
		 (negate (rest-terms L)))))

(define (*terms L1 L2)
  (if (empty-termlist? L1)
    (the-empty-termlist)
    (+terms (*-term-by-all-terms (first-term L1) L2)
	    (*terms (rest-terms L1) L2))))

(define (*-term-by-all-terms t1 L)
  (if (empty-termlist? L)
    (the-empty-termlist)
    (let ((t2 (first-term L)))
      (adjoin-term (make-term (add (order t1) (order t2))
			      (mul (coeff t1) (coeff t2)))
		   (*-term-by-all-terms t1
					(rest-terms L))))))

; Implementation of term lists

(define (adjoin-term term term-list)
  (if (zero? (coeff term))
    term-list
    (cons term term-list)))

(define (the-empty-termlist)
  '())

(define (first-term term-list)
  (car term-list))

(define (rest-terms term-list)
  (cdr term-list))

(define (empty-termlist? term-list)
  (null? term-list))

; Implementation of terms

(define (make-term order coeff)
  (list order coeff))

(define (order term)
  (car term))

(define (coeff term)
  (cdr term))

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
