FBSineL		feedback sine with chaotic phase indexing

FBSineL.ar(freq, im, fb, a, c, xi, yi, mul, add)

	freq - iteration frequency in Hertz
	im - index multiplier amount
	fb - feedback amount
	a  - phase multiplier amount
	c - phase increment amount
	xi - initial value of x
	yi - initial value of y

A linear-interpolating sound generator based on the difference equations:
	
	xn+1 = sin(im*yn + fb*xn)
	yn+1 = (ayn + c) % 2pi

This uses a linear congruential function to drive the phase indexing of a sine wave.  For 
im = 1, fb = 0, and a = 1 a normal sinewave results.

// default initial params
{ FBSineL.ar(SampleRate.ir/4) * 0.2 }.play(s);

// increase feedback
{ FBSineL.ar(SampleRate.ir, 1, Line.kr(0.01, 4, 10), 1, 0.1) * 0.2 }.play(s);

// increase phase multiplier
{ FBSineL.ar(SampleRate.ir, 1, 0, XLine.kr(1, 2, 10), 0.1) * 0.2 }.play(s);

// modulate frequency and index multiplier
{ FBSineL.ar(LFNoise2.kr(1, 1e4, 1e4), LFNoise2.kr(1,16,17), 1, 1.005, 0.7) * 0.2 }.play(s);

// randomly modulate params
(
{ FBSineL.ar(
	LFNoise2.kr(1, 1e4, 1e4), 
	LFNoise2.kr(1, 32, 33), 
	LFNoise2.kr(1, 0.5),
	LFNoise2.kr(1, 0.05, 1.05),
	LFNoise2.kr(1, 0.3, 0.3)
) * 0.2 }.play(s);
)


