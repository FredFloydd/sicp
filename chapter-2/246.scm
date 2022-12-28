#!/usr/bin/guile -s
!#

#!

If we wish to be able to access any records or data of employees, we need each department to
supply the following procedures for their specific implementation of the database:

dept-get-record

dept-get-salary

These can then be installed into a data-directed dispatch via:

(put 'get-record 'dept dept-get-record)

(put 'get-salary 'dept dept-get-salary)

Once all the departments have done this, we will have a dispatch table containing methods for
each department which obtains an employee's record, and their salary from their record. The
general procedure get-record can then be implemented to find any employee's record. This
requires that departments identify their records with a type, which tells the dispatch
which method to look up.

We can then implement a find-employee-record procedure which searches all departments for a
given employee:

(define (find-employee-record name file-list)
  (cond ((null? file-list) #nil)
	((get-record (car file-list)) (get-record (car file-list)))
	(else (find-employee-record name (cdr file-list)))))

If a new company is taken over, the new companies simply need to add procedures for obtaining
employee information to the dispatch.

!#
