#!/usr/bin/guile -s
!#

#!

For this proof let t = (1 + sqrt(5)) / 2 and let s = (1 - sqrt(5)) / 2. Assume that:

Fib(n) = (t^n - s^n) / sqrt(5)

We see that for Fib(1) and Fib(2):

Fib(1) = (1 + sqrt(5) - 1 + sqrt(5)) / (2*sqrt(5)) = 1

Fib(2) = (1 + 2*sqrt(5) + 5 - 1 + 2*sqrt(5) - 5) / (4*sqrt(5)) = 1

This rule works for out first two Fibonacci numbers. If we assume the rule to work for
n = k, then check if it works for n = (k+1):

Fib(k+1) = Fib(k) + Fib(k-1)
         = (t^k - s^k) / sqrt(5) + (t^(k-1) + s^(k-1)) / sqrt(5)
         = (t^(k-1)(t+1) - s^(k-1)(s-1)) / sqrt(5)

We can now use the fact that by definition:

t^2 = t+1
s^2 = s-1

To give:

Fib(k+1) = (t^(k+1) - s^(k+1)) / sqrt(5)

As expected. The formula thus holds for all positive integers n. As |s| < 1, as n increases
we find that Fib(n) -> t^n. We can thus use some of our previous procedures to calculate
Fibonacci numbers in logarithmic time:

!#

(define (fib n)

  (define (square x)
    (* x x))

  (define (sqrt x)

    (define (abs x)
      (if (> x 0)
	x
	(- x)))

    (define (average x y)
      (/ (+ x y) 2))

    (define (improve guess x)
      (average guess (/ x guess)))

    (define (good-enough? guess prev_guess)
      (< (abs(- guess prev_guess)) (* guess 0.001)))

    (define (sqrt-iter guess prev_guess x)
      (if (good-enough? guess prev_guess)
	guess
	(sqrt-iter (improve guess x)
		   guess
		   x)))

    (sqrt-iter 1 2 x))

  (define (fast-exp a b n)

    (define (even? n)
      (= (remainder n 2) 0))
    (cond ((= n 0) a)
	  ((even? n) (fast-exp a (square b) (/ n 2)))
	  (else (fast-exp (* a b) b (- n 1)))))

  (floor (/ (fast-exp 1
		      (/ (+ (sqrt 5)
			    1)
			 2)
		      n)
	    (sqrt 5))))

#!

This method will not be practical unless n is fairly small, as we can only store the value of
t to a finite level of precision. With each exponent the floating point errors will compound,
leading to large deviation from the correct value of the function.

!#
