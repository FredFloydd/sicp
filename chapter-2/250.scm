#!/usr/bin/guile -s
!#

#!

With our type system, the interpreter will evaluate the following expression via:

(add (make-complex (make-rectangular 3 4))
     (make-complex (make-polar 5 1)))

(operate-2 'add
	   (make-complex (make-rectangular 3 4))
	   (make-complex (make-polar 5 1)))

(operate-2 'add
	   (complex (make-rectangular 3 4))
	   (complex (make-polar 5 1)))

(+complex (make-rectangular 3 4)
	  (make-polar 5 1))

(make-complex (+c (make-rectangular 3 4)
		  (make-polar 5 1)))

(complex (make-rectangular (+ (real-part (make-rectangular 3 4))
			      (real-part (make-polar 5 1)))
			   (+ (imag-part (make-rectangular 3 4))
			      (imag-part (make-polar 5 1)))))

(complex (make-rectangular (+ (operate 'real-part
				       (make-rectangular 3 4))
			      (operate 'real-part
				       (make-polar 5 1)))
			   (+ (operate 'imag-part
				       (make-rectangular 3 4))
			      (operate 'imag-part
				       (make-polar 5 1)))))

(complex (make-rectangular (+ (real-part-rectangular (make-rectangular 3 4))
			      (real-part-polar (make-polar 5 1)))
			   (+ (imag-part-rectangular (make-rectangular 3 4))
			      (imag-part-polar (make-polar 5 1)))))

The complex symbol was used to find the appropriate method for adding complex numbers,
+complex. This was stripped off when the operate-2 procedure was called, which sent the
contents of the two objects to the function +complex.

!#
