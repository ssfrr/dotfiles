QuadC		general quadratic map chaotic generator

QuadC.ar(freq, a, b, c, xi, mul, add)

	freq - iteration frequency in Hertz
	a, b, c - equation variables
	xi - initial value of x

A cubic-interpolating sound generator based on the difference equation:
	
	xn+1 = axn2 + bxn + c
	

// default params
{ QuadC.ar(SampleRate.ir/4) * 0.2 }.play(s);

// logistic map 
// equation: x1 = -r*x0^2 + r*x0
(
{ var r;
	r = MouseX.kr(3.5441, 4);	// stable range
	QuadC.ar(SampleRate.ir/4, r.neg, r, 0, 0.1) * 0.4;
}.play(s);
)

// logistic map as frequency control
(
{ var r;
	r = MouseX.kr(3.5441, 4);	// stable range
	SinOsc.ar(QuadC.ar(40, r.neg, r, 0, 0.1, 800, 900)) * 0.4;
}.play(s);
)


