#!/usr/bin/guile -s
!#

#!

We can export procedures in the mentioned way because operate can be called from within
functions that are in the dispatch table. For example, in the evaluation of (magnitude z),
we have:

(magnitude z)

(magnitude (complex (rectangular 3 4)))

(operate 'magnitude (complex (rectangular 3 5)))

(magnitude (rectangular 3 5))

(operate 'magnitude (rectangular 3 5))

(magnitude-rectangular (rectangular 3 5))

We have two calls to operate, the first invokes the magnitude procedure of a general complex
number, then the second invokes the magnitude of a rectangular complex number.

!#
