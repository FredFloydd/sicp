#!/usr/bin/guile -s
!#

(define (length x)
  (define (length-iter a count)
    (if (null? a)
      count
      (length-iter (cdr a) (+ count 1))))
  (length-iter x 0))

(define (nth n x)
  (cond ((= n 0) (car x))
	((= (length x) 1) x)
	(else (nth (- n 1) (cdr x)))))

(define (last x)
  (if (null? (cdr x))
    (car x)
    (last (cdr x))))

(define (append x y)
  (if (null? x)
    y
    (cons (car x) (append (cdr x) y))))

(define (reverse x)
  (define (reverse-iter x a n)
    (cond ((= n -1) a)
	  (else (reverse-iter
		  x (append a (list (nth n x))) (- n 1)))))
  (let ((index (- (length x) 1)))
    (reverse-iter x (list) index)))

#!

After much pain, this finally works!

!#
