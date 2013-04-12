difsqr			difference of squares

BinaryOperator

difsqr(a, b)
a difsqr: b
a.difsqr(b)

Return the value of  (a*a) - (b*b). This is more efficient than using
separate unit generators for each operation.

{ (FSinOsc.ar(800) difsqr: FSinOsc.ar(XLine.kr(200,500,5))) * 0.125 }.play;

same as :

(
{
	var a, b;
	a = FSinOsc.ar(800);
	b = FSinOsc.ar(XLine.kr(200,500,5));
	((a * a) - (b * b)) * 0.125
}.play)



