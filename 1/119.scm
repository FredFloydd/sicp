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

(define (fast-prime? n times)

  (define (even? n)
    (if (= (remainder n 2) 0)
      #t
      #f))

  (define (expmod b e m)
    (cond ((= e 0) 1)
	  ((even? e)
	   (remainder (square (expmod b (/ e 2) m))
		      m))
	  (else (remainder (* b (expmod b (- e 1) m))
			   m))))

  (define (fermat-test n)
    (define a (+ 2 (random (- n 2))))
    (= (expmod a n n) a))

  (cond ((= times 0) #t)
	((fermat-test n)
	 (fast-prime? n (- times 1)))
	(else #f)))

(define (timed-prime-test n)
  (define start-time (get-internal-real-time))
  (define found-prime? (fast-prime? n 5))
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

This modification improves our time complexity to O(log(n)). This means that the time
taken to test primes of order 1000000 is approximately twice that of those of order 1000.

!#
