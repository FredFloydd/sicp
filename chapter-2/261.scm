#!/usr/bin/guile -s
!#

; Define put and get functions

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

; Defines type system for dispatching

(define (attach-type type type-index contents)
  (if (number? contents)
    contents
    (list type type-index contents)))

(define (type datum)
  (cond ((number? datum) 'number)
	((list? datum) (car datum))
	(else (error "Bad typed datum -- TYPE" datum))))

(define (type-index datum)
  (cond ((number? datum) 0)
	((list? datum) (cdr datum))
	(else (error "Type has no above type -- ABOVE-TYPE" datum))))

(define (contents datum)
  (cond ((number? datum) datum)
	((list? datum) (cddr datum))
	(else (error "Bad typed datum -- CONTENTS" datum))))

(define (variable? x)
  (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

; Create and install methods for adding, subtracting and multiplying polynomials

(define (+poly p1 p2)
  (if (same-variable? (variable p1) (variable p2))
    (make-polynomial (variable p1)
		     (+terms-dense (term-list p1)
				   (term-list p2)))
    (error "Polynomials not in same variable -- +POLY" (list p1 p2))))

(define (-poly p1 p2)
  (if (same-variable? (variable p1) (variable p2))
    (make-polynomial (variable p1)
		     (-terms-dense (term-list p1)
				   (term-list p2)))
    (error "Polynomials not in same variable -- -POLY" (list p1 p2))))

(define (*poly p1 p2)
  (if (same-variable? (variable p1) (variable p2))
    (make-polynomial (variable p1)
		     (*terms-dense (term-list p1)
				   (term-list p2)))
    (error "Polynomials not in same variable -- *POLY" (list p1 p2))))


(put 'polynomial 'add +poly)
(put 'polynomial 'mul *poly)

; Sub-procedures for addition, subtraction and multiplication for dense lists

(define (+terms-dense L1 L2)
  (cond ((empty-termlist? L1) L2)
	((empty-termlist? L2) L1)
	(else (cons (+ (first-term L1)
			 (first-term L2))
		    (+terms-dense (rest-terms L1)
				  (rest-terms L2))))))
(define (-terms-dense L1 L2)
  (cond ((empty-termlist? L1) L2)
	((empty-termlist? L2) L1)
	(else (cons (- (first-term L1)
			 (first-term L2))
		    (-terms-dense (rest-terms L1)
				  (rest-terms L2))))))

(define (*terms-dense L1 L2)
  (define (*-iter L1 L2 order)
    (if (empty-termlist? L1)
      (the-empty-termlist)
      (+terms-dense (*-term-by-all-terms-dense (first-term L1) order L2)
		  (*-iter (rest-terms L1) L2 (+ order 1)))))
  (*-iter L1 L2 0))

(define (*-term-by-all-terms-dense coeff order L)
  (define (*-all-iter order2 L2 res)
    (if (empty-termlist? L2)
      (the-empty-termlist)
      (add-at-order (*-all-iter (+ order2 1)
				(rest-terms L2)
				res)
		    (* coeff (first-term L2))
		    (+ order order2))))
  (*-all-iter 0 L (the-empty-termlist)))

(define (add-at-order L coeff order)
  (cond ((empty-termlist? L) (add-at-order '(0) coeff order))
	((zero? order) (cons (+ (first-term L)
				coeff)
		       (rest-terms L)))
	(else (cons (first-term L)
		    (add-at-order (rest-terms L)
				  coeff
				  (- order 1))))))

; Implementation of dense term lists

(define (the-empty-termlist)
  '())

(define (first-term term-list)
  (car term-list))

(define (rest-terms term-list)
  (cdr term-list))

(define (empty-termlist? term-list)
  (eq? (the-empty-termlist) term-list))

; Implementation of polynomials as an arithmetic type

(define (make-polynomial variable term-list)
  (attach-type 'polynomial 4 (cons variable term-list)))

(define (variable p)
  (caaddr p))

(define (term-list p)
  (cdaddr p))

; Definition of zero check for polynomials

(define (termlist-zero? L)
  (if (empty-termlist? L)
    #t
    (and (zero? (first-term L))
	 (termlist-zero? (rest-terms L)))))

(define (poly-zero? p)
  (termlist-zero? (term-list p)))

(put 'polynomial '=zero? poly-zero?)
