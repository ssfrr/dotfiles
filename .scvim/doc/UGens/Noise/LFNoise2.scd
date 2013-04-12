LFNoise2				quadratic noise

LFNoise2.ar(freq, mul, add)
LFNoise2.kr(freq, mul, add)

Generates quadratically interpolated random values at a rate.
freq - approximate rate at which to generate random values.

see also: LFDNoise3, LFNoise0, LFNoise1

Note: quadratic interpolation means that the noise values can occasionally extend beyond the normal range of +-1, if the freq varies in certain ways. If this is undesirable then you might like to clip2 the values, or use a linearly-interpolating unit instead.

{ LFNoise2.ar(1000, 0.25) }.play;

// modulate frequency

{ LFNoise2.ar(XLine.kr(1000, 10000, 10), 0.25) }.play;

// as frequency modulator
(
{ SinOsc.ar(
		LFNoise2.ar(4, 400, 450),
		0, 0.2
	) 
}.play;
)

// freq is the rate of interpolation points
{ var freq = 1000; [LFNoise2.ar(freq), Impulse.ar(freq)] }.plot


