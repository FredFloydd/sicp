#!/usr/bin/guile -s
!#

#!

We can represent integers purely in terms of procedures. An implementation of the concept of
zero, and a procedure for adding one are given by:

!#

(define zero
  (lambda (f) (lambda (x) (x))))

(define (1+ n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

#!

In this system, we obtain the following procedures for one and two:

!#

(define one
  (+1 zero))

(define two
  (+1 one))

#!

These evaluate to:

(+1 zero)
(lambda (f) (lambda (x) (f ((zero f) x))))
(lambda (f) (lambda (x) (f ((lambda (f) (lambda (x) (x))) x))))
(lambda (f) (lambda (x) (f ((lambda (x) (x)) x))))
(lambda (f) (lambda (x) (f x)))
(lambda (f) (f x))

(+1 one)
(lambda (f) (lambda (x) (f ((one f) x))))
(lambda (f) (lambda (x) (f ((lambda (f) (f x)) f) x)))
(lambda (f) (lambda (x) (f ((f x)))))
(lambda (f) (lambda (x) (f (f x))))
(lambda (f) (f (f x)))

Thus, our integers correspond to multiple applications of functions to inputs. We can
define addition in this case by saying:

!#

(define (add num1 num2)
  (lambda (f) (num1 (num2 x)))
