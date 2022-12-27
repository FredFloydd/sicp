#!/usr/bin/guile -s
!#

(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

(define (leaf? object)
  (eq? (car object) 'leaf))

(define (symbol-leaf x)
  (cadr x))

(define (weight-leaf x)
  (caddr x))

(define (make-code-tree left right)
  (list left
	right
	(append (symbols left) (symbols right))
	(+ (weight left) (weight right))))

(define (left-branch tree)
  (car tree))

(define (right-branch tree)
  (cadr tree))

(define (symbols tree)
  (if (leaf? tree)
    (list (symbol-leaf tree))
    (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
    (weight-leaf tree)
    (cadddr tree)))

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
      '()
      (let ((next-branch
              (choose-branch (car bits) current-branch)))
        (if (leaf? next-branch)
          (cons (symbol-leaf next-branch)
                (decode-1 (cdr bits) tree))
          (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))

(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit -- CHOOSE-BRANCH" bit))))

(define (element-of-set? x set)
  (cond ((null? set) #nil)
	((eq? x (car set)) #t)
	(else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
    '()
    (let ((pair (car pairs)))
      (adjoin-set (make-leaf (car pair)    ; symbol
                             (cadr pair))  ; frequency
                  (make-leaf-set (cdr pairs))))))

(define (encode message tree)
  (if (null? message)
    '()
    (append (encode-symbol (car message) tree)
	    (encode (cdr message) tree))))

(define (encode-symbol symbol tree)
  (define (encode-iter result char object)
    (cond ((element-of-set? char (symbols (left-branch object)))
	   (if (leaf? (left-branch object))
	     (append result '(0))
	     (encode-iter (append result '(0)) char (left-branch object))))
	  ((element-of-set? char (symbols (right-branch object)))
	   (if (leaf? (right-branch object))
	     (append result '(1))
	     (encode-iter (append result '(1)) char (right-branch object))))
	  (else (error "bad symbol -- ENCODE-SYMBOL" char))))
  (encode-iter '() symbol tree))

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge leaf-set)
  (define (merge-smallest set)
    (adjoin-set (make-code-tree (car set)
				(cadr set))
		(cddr set)))
  (if (null? (cdr leaf-set))
    (car leaf-set)
    (successive-merge (merge-smallest leaf-set))))

(define pairs '((A 2) (BOOM 1) (GET 2) (JOB 2) (NA 16) (SHA 3) (YIP 8) (WAH 1)))

(define tree (generate-huffman-tree pairs))

(define message '(GET A JOB SHA NA NA NA NA NA NA NA NA GET A JOB SHA NA NA NA NA NA NA NA NA WAH YIP YIP YIP YIP YIP YIP YIP YIP SHA BOOM))

(define bits (encode message tree))

(display bits)
(newline)
(display (length bits))

#!

We can encode the message in 82 bits using out Huffman coding. If we used a fixed-length code for the eight symbol
alphabet, we would require three bits per character. As we have 86 characters, we would need 258 bits. We hav a very
large compression ratio in this case.

!#
