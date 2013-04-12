LFNoise0					step noise

LFNoise0.ar(freq, mul, add)
LFNoise0.kr(freq, mul, add)

Generates random values at a rate.
freq - approximate rate at which to generate random values.

see also: LFDNoise0, LFNoise1, LFNoise2


{ LFNoise0.ar(1000, 0.25) }.play;

// modulate frequency

{ LFNoise0.ar(XLine.kr(1000, 10000, 10), 0.25) }.play;

// as frequency modulator
(
{ SinOsc.ar(
		LFNoise0.ar(4, 400, 450),
		0, 0.2
	) 
}.play;
)

// freq is the rate of starting points
{ var freq = 1000; [LFNoise0.ar(freq), Impulse.ar(freq)] }.plot


