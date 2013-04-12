sqrsum			square of the sum

BinaryOperator

Return the value of  (a + b)**2. This is more efficient than using
separate unit generators for each operation.

{ (FSinOsc.ar(800) sqrsum: FSinOsc.ar(XLine.kr(200,500,5))) * 0.125 }.play;

same as :

(
{
	var a, b, c;
	a = FSinOsc.ar(800);
	b = FSinOsc.ar(XLine.kr(200,500,5));
	c = a + b;
	(c * c) * 0.125
}.play)



