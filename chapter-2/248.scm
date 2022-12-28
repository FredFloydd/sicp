#!/usr/bin/guile -s
!#

#!

We have three main ways of organising data objects - conventional, data-directed and message-passing. If we
wish to add new types and operations to our system, we must do the following for each way:


Conventional:

Adding types -      Each new type must have appropriate constructors and selectors. We must update all of our
                    existing operations to manually check the type of the object when it is called, in order
                    to perform the correct operation for the type. We also must define specific operations
                    for the new type.

Adding operations - We must include checks for all the types of object in our procedure definition, and define
                    the new operation for every type.

Overall -           Adding types is a pain, adding operations is ok.


Data-directed:

Adding types -      We need to define appropriate constructors and selectors. We define each operation for the
                    type, then add them to our dispatch table.

Adding operations - We define the action of the new operation on each type, and add them to our dispatch table.

Overall -           Adding types is easy, adding operations is easy.


Message-passing:

Adding types -      We define the new type and its methods all in one go.

Adding operations - We must define the new operations for each type.


Data-directed organisation seems to be better for systems where we define lots of new operations, while
message-passing seems to be better for systems where we define lots of new types.

!#
