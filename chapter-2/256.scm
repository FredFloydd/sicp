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

(define (attach-type type type-index contents)
  (if (number? contents)
    contents
    (cons (cons type type-index) contents)))

(define (type datum)
  (cond ((number? datum) 'number)
	((list? datum) (caar datum))
	(else (error "Bad typed datum -- TYPE" datum))))

(define (type-index datum)
  (cond ((number? datum) 0)
	((list? datum) (cdar datum))
	(else (error "Type has no above type -- ABOVE-TYPE" datum))))

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
  (attach-type 'complex 3 z))

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
  (attach-type 'rational 1 r))

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

Define real number system:

!#

(define (make-real r)
  (attach-type 'real 2 r))

(define (+real r1 r2)
  (make-real (+ r1 r2)))

(define (-real r1 r2)
  (make-real (- r1 r2)))

(define (*real r1 r2)
  (make-real (* r1 r2)))

(define (/real r1 r2)
  (make-real (/ r1 r2)))

(put 'real 'add +real)
(put 'real 'sub -real)
(put 'real 'mul *real)
(put 'real 'div /real)

#!

If we have the types integer, rational, real and complex, we can raise the types lower
down objects to higher objects. If we represent integers as numbers, rationals as a
numerator and denominator, reals as numbers and complex numbers in either polar or
rectangular form, then we can define specific raising operators:

!#

(define (integer->rational n)
  (make-rational (make-fraction n 1)))

(define (rational->real r)
  (make-real (/ (numerator r) (denominator r))))

(define (real->complex n)
  (make-complex (make-rectangular n 0)))

#!

These can then be installed into our coercion table using:

!#

(put 'integer 'raise integer->rational)
(put 'rational 'raise rational->real)
(put 'real 'raise real->complex)

#!

Now we can define a generic raising operator.

!#

(define (raise n)
  (if (not (null? (get (type n) 'raise)))
    (operate 'raise n)
    (error "Type cannot be raised further -- RAISE" n)))

#!

This allows us to define operate-2 such that it raises arguments to a sufficient level for them to
have operations applied to them:

!#

(define (operate-2 op obj1 obj2)
  (let ((t1 (type obj1))
	(t2 (type obj2)))
    (if (eq? t1 t2)
      (let ((proc (get t1 op)))
	(if (not (null? proc))
	  (proc (contents obj1) (contents obj2))
	  (error "Operator undefined on this type -- OPERATE-2"
		 (list op obj1 obj2))))
      (let ((ind1 (type-index obj1))
	    (ind2 (type-index obj2)))
	(if (< ind1 ind2)
	  (operate-2 op (raise obj1) obj2)
	  (operate-2 op obj1 (raise obj2)))))))

(display (add 5 (make-complex (make-rectangular 2 3))))
