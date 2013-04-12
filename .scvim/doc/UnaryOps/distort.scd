distort			nonlinear distortion

a.distort
distort(a)

(
{
	var a;
	a = Line.ar(-4, 4, 0.01);
	a.distort
}.plot)

{ FSinOsc.ar(500, 0.0, XLine.kr(0.1, 10, 10)).distort * 0.25 }.scope;




