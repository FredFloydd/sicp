#!/usr/bin/guile -s
!#

#!

If the expression (car ''abracadabra) is typed in, then the interpreter will expand it as:

(car '(quote abracadabra))
(quote)

If instead we typed (cdddr '(this list contains '(a quote))), then we obtain:

(cdddr (this list contains '(a quote)))
(cddr (list contains '(a quote)))
(cdr (contains '(a quote)))
((quote (a quote)))

!#
