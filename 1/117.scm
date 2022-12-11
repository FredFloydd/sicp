#!/usr/bin/guile -s
!#

(define (square x)
  (* x x))

(define (divides? a b)
  (= (remainder b a) 0))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
	((divides? test-divisor n) test-divisor)
	(else (find-divisor n (+ test-divisor 1)))))

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

(search-for-primes 10000001 100000000)

#!

From testing the time taken for the algorithm to find primes, it appears that the
process grows slightly slower that O(sqrt(n)). The prediction is close to what is
observed however, with a hundred-fold increase in size of number corresponding to
an increase of time of ~8 times.

!#
