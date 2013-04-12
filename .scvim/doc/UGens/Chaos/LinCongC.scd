LinCongC		linear congruential chaotic generator

LinCongC.ar(freq, a, c, m, xi, mul, add)

	freq - iteration frequency in Hertz
	a - multiplier amount
	c - increment amount
	m - modulus amount
	xi - initial value of x

A cubic-interpolating sound generator based on the difference equation:
	
	xn+1 = (axn + c) % m
	
The output signal is automatically scaled to a range of [-1, 1].


// default initial params
{ LinCongC.ar(MouseX.kr(20, SampleRate.ir)) * 0.2 }.play(s);

// randomly modulate params
(
{ LinCongC.ar(
	LFNoise2.kr(1, 1e4, 1e4), 
	LFNoise2.kr(0.1, 0.5, 1.4), 
	LFNoise2.kr(0.1, 0.1, 0.1),
	LFNoise2.kr(0.1)
) * 0.2 }.play(s);
)

// as frequency control...
(
{ 
SinOsc.ar(
	LinCongC.ar(
		40, 
		LFNoise2.kr(0.1, 0.1, 1), 
		LFNoise2.kr(0.1, 0.1, 0.1),
		LFNoise2.kr(0.1),
		0, 500, 600
	)	
) * 0.4 }.play(s);
)


