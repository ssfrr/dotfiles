-				subtraction

BinaryOp

a - b

Subtracts the output of a ugen from something else.

(
{
var z;
z = FSinOsc.ar(800,0.25);
z - z	// results in silence
}.play)



