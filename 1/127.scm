#!/usr/bin/guile -s
!#

(define (filtered-accumulator predicate combiner null-value a b term next)

  (define (iter a result)
    (cond ((> a b) result)
	  ((predicate a b) (iter (next a)
			   (combiner (term a)
				     result)))
	  (else (iter (next a)
		      result))))

  (iter a null-value))


#!

This procdure defines an even more general accumulator which chooses to combine terms or
not based off a predicate. We can use this to find the sums of the squares the prime numbers
in the interval a <= p <= b via:

!#

(define (sum-squares-of-primes n)

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
	  ((fermat-test n) (fast-prime? n (- times 1)))
	  (else #f)))

  (define (prime? a b)
    (fast-prime? a 10))

  (define (add a b)
    (+ a b))

  (define (square a)
    (* a a))

  (define (inc a)
    (+ a 1))

  (filtered-accumulator prime? add 0 100 200 square inc))

(display (sum-squares-of-primes 100))
(display "\n")

#!

We can also find the product of all positive integers i < n such that gcd(i,n) = 1:

!#

(define (coprime-product n)

  (define (gcd a b)
    (if (= b 0)
      a
      (gcd b (remainder a b))))

  (define (coprime? a b)
    (= (gcd a b) 1))

  (define (times a b)
    (* a b))

  (define (identity a)
    a)

  (define (inc a)
    (+ a 1))

(filtered-accumulator coprime? times 1 0 n identity inc))

(display (coprime-product 8))
