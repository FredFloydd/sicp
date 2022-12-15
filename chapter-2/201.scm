#!/usr/bin/guile -s
!#

(define (gcd a b)
  (if (= b 0)
    a
    (gcd b (remainder a b))))

(define (make-rat n d)
  (let ((g (gcd n d)))
    (if (> (* n d) 0)
      (cons (abs (/ n g)) (abs (/ d g)))
      (cons (- (abs (/ n g))) (abs (/ d g))))))

#!

This process initialises rational numbers as a pair, where the numerator and denominator
are coprime, and in the case of negative rationals, the numerator is negative.

!#
