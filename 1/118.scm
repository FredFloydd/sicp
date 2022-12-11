#!/usr/bin/guile -s
!#

(define (square x)
  (* x x))

(define (divides? a b)
  (= (remainder b a) 0))

(define (next divisor)
  (if (= divisor 2)
    3
    (+ divisor 2)))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
	((divides? test-divisor n) test-divisor)
	(else (find-divisor n (next test-divisor)))))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (prime? n)
  (= (smallest-divisor n) n))

(define (timed-prime-test n)
  (define start-time (get-internal-real-time))
  (define found-prime? (prime? n))
  (define elapsed-time (- (get-internal-real-time) start-time))
  (cond (found-prime?
	  (display n)
	  (display "***")
	  (display elapsed-time)
	  (display "\n"))))

(define (search-for-primes low high)
  (cond ((> low high) 0)
	(else (timed-prime-test low)
	      (search-for-primes (+ low 2) high))))

(search-for-primes 100001 1000000)

#!

This modification to the algorithm in the previous question almost exactly halves the
time required to find a prime. This is as expected.

!#
