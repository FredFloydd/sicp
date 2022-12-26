#!/usr/bin/guile -s
!#


(define (square x)
  (* x x))

(define (square-list x)
  (if (null? x)
    #nil
    (cons (square (car x))
	  (square-list (cdr x)))))

(define numbers (list 1 2 3 4 5 6))

(display (square-list numbers))
