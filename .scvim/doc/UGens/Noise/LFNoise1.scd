LFNoise1				ramp noise

LFNoise1.ar(freq, mul, add)
LFNoise1.kr(freq, mul, add)

Generates linearly interpolated random values at a rate. 
freq - approximate rate at which to generate random values.

see also: LFDNoise1, LFNoise0, LFNoise2

{ LFNoise1.ar(1000, 0.25) }.play;

// modulate frequency

{ LFNoise1.ar(XLine.kr(1000, 10000, 10), 0.25) }.play;

// as frequency modulator
(
{ SinOsc.ar(
		LFNoise1.ar(4, 400, 450),
		0, 0.2
	) 
}.play;
)

// freq is the rate of starting points
{ var freq = 1000; [LFNoise1.ar(freq), Impulse.ar(freq)] }.plot


