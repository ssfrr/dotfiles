absdif			absolute value of the difference

BinaryOperator

absdif(a, b)
a absdif: b
a.absdif(b)

Return the value of  abs(a - b). Finding the magnitude of the difference of two
values is a common operation.

// creates a rhythm
(
{ 
var mul;
mul = 0.2 absdif: FSinOsc.ar(2, 0, 0.5);
FSinOsc.ar(440, 0, mul);
}.play;)



