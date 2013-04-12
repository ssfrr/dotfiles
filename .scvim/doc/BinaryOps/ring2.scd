ring2			ring modulation plus both sources

BinaryOperator

Return the value of  ((a*b) + a + b). This is more efficient than using
separate unit generators for the multiply and adds.

See also *, ring1, ring2, ring3, ring4.

{ (FSinOsc.ar(800) ring2: FSinOsc.ar(XLine.kr(200,500,5))) * 0.125 }.play;

same as :

(
{
	var a, b;
	a = FSinOsc.ar(800);
	b = FSinOsc.ar(XLine.kr(200,500,5));
	((a * b) + a + b) * 0.125
}.play)



