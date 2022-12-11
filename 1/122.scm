#!/usr/bin/guile -s
!#

(define (square x)
  (* x x))

(define (even-sign n)
  (define (even-exponent n)
    (/ (- (square n)
	  1)
       8))
  (if (even? (even-exponent n))
    1
    -1))

(define (odd-sign a n)
  (define (odd-exponent a n)
    (/ (* (- a 1)
	  (- n 1))
       4))
  (if (even? (odd-exponent a n))
    1
    -1))

(define (jacobi a n)
  (cond ((= a 1) 1)
	((even? a) (* (jacobi (/ a 2) n)
		      (even-sign n)))
	(else (* (jacobi (remainder n a) a)
		 (odd-sign a n)))))

(define (expmod b e m)
  (cond ((= e 0) 1)
	((even? e)
	 (remainder (square (expmod b (/ e 2) m))
		    m))
	(else
	  (remainder (* b (expmod b (- e 1) m))
		     m))))

(define (test-exponent n)
  (/ (- n 1) 2))

(define (jacobi-check a n)
  (if (= (remainder (+ (jacobi a n)
		       n)
		    n)
	 (expmod a (test-exponent n) n))
    #t
    #f))

(define (gcd a b)
  (if (= b 0)
    a
    (gcd b (remainder a b))))

(define (prime? n value checks)
  (cond ((= checks 0) (display n)
		      (display "\n")
		      #t)
	((= (gcd n value) 1) (if (jacobi-check value n)
			       (prime? n (+ value 1) (- checks 1))
			       #f))
	(else (prime? n (+ value 1) checks))))

(define (find-primes start end checks)
  (cond ((> start end) 0)
	(else (prime? start 3 checks)
	      (find-primes (+ start 2) end checks))))

(find-primes 1001 10000 10)

#!

This algorithm is capable of probabilistically finding primes in O(log(n)) time. We can be confident to one part
in 2^(checks) that the number is prime. The time the algorithm takes will increase linearly in the number of checks,
but the confidence grows exponentially.

!#
