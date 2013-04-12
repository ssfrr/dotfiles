ring1			ring modulation plus first source

BinaryOperator

Return the value of  ((a*b) + a). This is more efficient than using
separate unit generators for the multiply and add.

See also *, ring1, ring2, ring3, ring4.

{ (FSinOsc.ar(800) ring1: FSinOsc.ar(XLine.kr(200,500,5))) * 0.125 }.play;

same as :

(
{
	var a, b;
	a = FSinOsc.ar(800);
	b = FSinOsc.ar(XLine.kr(200,500,5));
	((a * b) + a) * 0.125
}.play)

normal ring modulation:

(
{
	var a, b;
	a = FSinOsc.ar(800);
	b = FSinOsc.ar(XLine.kr(200,500,5));
	(a * b) * 0.125
}.play)


