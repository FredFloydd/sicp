#!/usr/bin/guile -s
!#

(define (square-list x)
  (define (iter list answer)
    (if (null? list)
      answer
      (iter (cdr list)
	    (cons (square (car list))
		  answer))))
  (iter x #nil))

#!

This method for squaring will also unintentionally reverse the order of the list. This is because
the procedure successively appends the first item of list onto the front of answer. This causes
the initially first item in list to be successively pushed backwards.

!#

(define (square-list x)
  (define (iter list answer)
    (if (null? list)
      answer
      (iter (cdr list)
	    (cons answer
		  (square (car list))))))
  (iter x #nil))

#!

This also doesn't work, as initially answer has the value of nil. This means the start of the list
will be a cons with nil as its first item, and the rest of the list as its cdr. This isn't what we
want.

!#
