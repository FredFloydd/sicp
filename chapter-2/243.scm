#!/usr/bin/guile -s
!#

#!

If we have a Huffman tree for an alphabet of N symbols, with relative frequencies of 1,2,4,...,2^(N-1),
then we will have a tree that looks like this:


N=5

             {A B C D E} 31


      A 16               {B C D E} 15


                    B 8            {C D E} 7


                                C 4         {D E} 3


                                          D 2     E 1



N=10

          {A B C D E F G H I J} 1023


      A 512                     {B C D E F G H I J} 511


                            B 256                {C D E F G H I J} 255


                                             C 128                {D E F G H I J} 127


                                                               D 64             {E F G H I J} 63


                                                                              E 32         {F G H I J} 31


The {F G H I J} tree looks the same as the N=5 tree. In order to encode the most frequent symbol, we
always need one bit. In order to encode the least frequent symbol we always need N-1 bits.

!#
