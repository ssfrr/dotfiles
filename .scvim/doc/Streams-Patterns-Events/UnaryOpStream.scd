UnaryOpStream			stream modified by a unary operator 

superclass: Stream

see also BinaryOpStream, NAryOpStream

A UnaryOpStream is created as a result of a unary math operation on a Stream. 
It is defined to respond to next by returning the result of the math operation
on the next value from the stream. It responds to reset by resetting the Stream.


x = Routine { 6.do { arg i; i.yield; } }.squared;
x.dump

(
x = Routine { 6.do { arg i; i.yield; } }.squared;
x.next.postln;
x.next.postln;
x.next.postln;
x.next.postln;
x.next.postln;
x.next.postln;
x.next.postln;
)



