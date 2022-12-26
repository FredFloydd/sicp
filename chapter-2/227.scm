#!/usr/bin/guile -s
!#

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

#!

We have selectors for the left and right branches of a mobile, and length and structures on a branch of:

!#

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (car (cdr mobile)))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (car (cdr branch)))

#!

We can use these selectors to find the total weight of a mobile:

!#

(define (mobile-weight mobile)
  (define (is-primitive? branch)
    (number? (branch-structure branch)))

  (define (branch-weight branch)
    (if (is-primitive? branch)
      (branch-structure branch)
      (mobile-weight (branch-structure branch))))

  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))

#!

We can also check that a mobile is balanced:

!#

(define (balanced? mobile)
  (define (is-primitive? branch)
    (number? (branch-structure branch)))

  (define (branch-weight branch)
    (if (is-primitive? branch)
      (branch-structure branch)
      (mobile-weight (branch-structure branch))))

  (define (branch-moment branch)
    (* (branch-length branch) (branch-weight branch)))

  (define (branch-balanced? branch)
    (if (is-primitive? branch)
      #t
      (balanced? (branch-structure branch))))

  (let ((left (left-branch mobile))
	(right (right-branch mobile)))
    (and (branch-balanced? left)
	 (branch-balanced? right)
	 (= (branch-moment left) (branch-moment right)))))


#!

If we changed our constructors to use cons instead of list, the only change we would need to make to our
code is to just use (cdr branch) instead of (car (cdr branch)) in our selectors.

!#
