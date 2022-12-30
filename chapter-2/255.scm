#!/usr/bin/guile -s
!#

#!

If we have the types integer, rational, real and complex, we can raise the types lower
down objects to higher objects. If we represent integers as numbers, rationals as a
numerator and denominator, reals as numbers and complex numbers in either polar or
rectangular form, then we can define specific raising operators:

!#

(define (interger->rational n)
  (make-rational (make-fraction n 1)))

(define (rational->real r)
  (/ (numerator r) (denominator r)))

(define (real->complex n)
  (make-complex (make-rectangular n 0)))

#!

These can then be installed into our coercion table using:

!#

(put 'integer 'raise integer->rational)
(put 'rational 'raise rational->real)
(put 'real 'raise real->complex)

#!

Now we can define a generic raising operator:

!#

(define (raise n)
  (operate 'raise n))
