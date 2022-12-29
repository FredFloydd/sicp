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

(define (attach-type type contents)
  (if (number? contents)
    contents
    (cons type contents)))

(define (type datum)
  (cond ((number? datum) 'number)
	((list? datum) (car datum))
	(else (error "Bad typed datum -- TYPE" datum))))

(define (contents datum)
  (cond ((number? datum) datum)
	((list? datum) (cdr datum))
	(else (error "Bad typed datum -- CONTENTS" datum))))


#!

This defines our type system

!#

(define (operate op obj)
  (let ((proc (get (type obj) op)))
    (if (not (null? proc))
      (proc (contents obj))
      (error "Operator undefined for this type -- OPERATE"
	     (list op obj)))))

(define (operate-2 op arg1 arg2)
  (let ((t1 (type arg1)))
    (if (eq? t1 (type arg2))
      (let ((proc (get t1 op)))
	(if (not (null? proc))
	  (proc (contents arg1) (contents arg2))
	  (error "Operator undefined on this type -- OPERATE-2"
		 (list op arg1 arg2))))
      (error "Operands not of the same type -- OPERATE-2"
	     (list op arg1 arg2)))))

(define (add x y)
  (if (and (number? x) (number? y))
    (+ x y)
    (operate-2 'add x y)))

(define (sub x y)
  (if (and (number? x) (number? y))
    (- x y)
    (operate-2 'sub x y)))

(define (mul x y)
  (if (and (number? x) (number? y))
    (* x y)
    (operate-2 'mul x y)))

(define (div x y)
  (if (and (number? x) (number? y))
    (/ x y)
    (operate-2 'div x y)))

#!

This defines our system for operating on generic data types

#!

(define (real-part-rectangular z)
  (car z))

(define (imag-part-rectangular z)
  (cdr z))

(define (magnitude-rectangular z)
  (sqrt (+ (square (car z))
	   (square (cdr z)))))

(define (angle-rectangular z)
  (atan (cdr z) (car z)))

(put 'rectangular 'real-part real-part-rectangular)
(put 'rectangular 'imag-part imag-part-rectangular)
(put 'rectangular 'magnitude magnitude-rectangular)
(put 'rectangular 'angle angle-rectangular)

(define (real-part-polar z)
  (* (car z) (cos (cdr z))))

(define (imag-part-polar z)
  (* (car z) (sin (cdr z))))

(define (magnitude-polar z)
  (car z))

(define (angle-polar z)
  (cdr z))

(put 'polar 'real-part real-part-polar)
(put 'polar 'imag-part imag-part-polar)
(put 'polar 'magnitude magnitude-polar)
(put 'polar 'angle angle-polar)

(define (real-part obj)
  (operate 'real-part obj))

(define (imag-part obj)
  (operate 'imag-part obj))

(define (magnitude obj)
  (operate 'magnitude obj))

(define(angle obj)
  (operate 'angle obj))

#!

These define our selectors for general complex numbers

!#

(define (+c z1 z2)
  (make-rectangular (+ (real-part z1) (real-part z2))
		    (+ (imag-part z1) (imag-part z2))))

(define (-c z1 z2)
  (make-rectangular (- (real-part z1) (real-part z2))
		    (- (imag-part z1) (imag-part z2))))

(define (*c z1 z2)
  (make-polar (* (magnitude z1) (magnitude z2))
	      (+ (angle z1) (angle z2))))

(define (/c z1 z2)
  (make-polar (/ (magnitude z1) (magnitude z2))
	      (- (angle z1) (angle z2))))

(define (make-complex z)
  (attach-type 'complex z))

(define (+complex z1 z2)
  (make-complex (+c z1 z2)))

(define (-complex z1 z2)
  (make-complex (-c z1 z2)))

(define (*complex z1 z2)
  (make-complex (*c z1 z2)))

(define (/complex z1 z2)
  (make-complex (/c z1 z2)))

(put 'complex 'add +complex)
(put 'complex 'sub -complex)
(put 'complex 'mul *complex)
(put 'complex 'div /complex)

#!

These define our ways of performing our basic operations on complex numbers.

We can now do the same with our rational package:

!#

(define (make-fraction n d)
  (define (gcd a b)
    (if (= b 0)
      a
      (gcd b (remainder a b))))
  (let ((g (gcd n d)))
    (if (> (* n d) 0)
      (list (abs (/ n g)) (abs (/ d g)))
      (list (- (abs (/ n g))) (abs (/ d g))))))

(define (numerator r)
  (car r))

(define (denominator r)
  (cadr r))

(define (+r r1 r2)
  (make-fraction (+ (* (numerator r1)
		       (denominator r2))
		    (* (denominator r1)
		       (numerator r2)))
		 (* (denominator r1)
		    (denominator r2))))
(define (-r r1 r2)
  (make-fraction (- (* (numerator r1)
		       (denominator r2))
		    (* (denominator r1)
		       (numerator r2)))
		 (* (denominator r1)
		    (denominator r2))))

(define (*r r1 r2)
  (make-fraction (* (numerator r1)
		    (numerator r2))
		 (* (denominator r1)
		    (denominator r2))))

(define (/r r1 r2)
  (make-fraction (* (numerator r1)
		    (denominator r2))
		 (* (denominator r1)
		    (numerator r2))))

(define (make-rational r)
  (attach-type 'rational r))

(define (+rat r1 r2)
  (make-rational (+r r1 r2)))

(define (-rat r1 r2)
  (make-rational (-r r1 r2)))

(define (*rat r1 r2)
  (make-rational (*r r1 r2)))

(define (/rat r1 r2)
  (make-rational (/r r1 r2)))

(put 'rational 'add +rat)
(put 'rational 'sub -rat)
(put 'rational 'mul *rat)
(put 'rational 'div /rat)

#!

Our system now has functionality to operate on normal numbers, rational numbers and complex
numbers:

!#

(define n1 5)
(define n2 3)

(define r1 (make-rational (make-fraction 1 2)))
(define r2 (make-rational (make-fraction 3 4)))

(define c1 (make-complex (make-rectangular 3 4)))
(define c2 (make-complex (make-polar 5 1)))

(display (add n1 n2))
(newline)
(display (mul n1 n2))
(newline)
(display (add r1 r2))
(newline)
(display (mul r1 r2))
(newline)
(display (add c1 c2))
(newline)
(display (mul c1 c2))
