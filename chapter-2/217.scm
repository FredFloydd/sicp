#!/usr/bin/guile -s
!#

(define (length x)
  (define (length-iter a count)
    (if (null? a)
      count
      (length-iter (cdr a) (+ count 1))))
  (length-iter x 0))

(define (last x)
  (if (null? (cdr x))
    x
    (last (cdr x))))

(define (append x y)
  (if (null? x)
    y
    (cons (car x) (append (cdr x) y))))
