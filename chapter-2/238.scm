#!/usr/bin/guile -s
!#

(define (lookup given-key set-of-records)
  (cond ((null? set-of-records) #nil)
	((= given-key (key (entry set-of-records)))
	 (entry set-of-records))
	((< given-key (key (entry set-of-records)))
	 (lookup given-key (left-branch set-of-records)))
	((> given-key (key (entry set-of-records)))
	 (lookup given-key (right-branch set-of-records)))))

#!

This procedure defines a lookup procedure for entries in a database identified by keys,
where the database is structured as a binary tree.

!#
