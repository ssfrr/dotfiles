ring3			ring modulation variant

BinaryOperator

Return the value of  (a*a *b). This is more efficient than using
separate unit generators for each multiply.

See also *, ring1, ring2, ring3, ring4.

{ (FSinOsc.ar(800) ring3: FSinOsc.ar(XLine.kr(200,500,5))) * 0.125 }.play;

same as :

(
{
	var a, b;
	a = FSinOsc.ar(800);
	b = FSinOsc.ar(XLine.kr(200,500,5));
	(a * a * b) * 0.125;
}.play)



