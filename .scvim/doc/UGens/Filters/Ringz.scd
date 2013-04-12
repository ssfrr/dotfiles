Ringz			ringing filter

Inherits from: Object : AbstractFunction : UGen : Filter 

Ringz.ar(in, freq, decaytime, mul, add)
Ringz.kr(in, freq, decaytime, mul, add)


Ringz is the same as Resonz, except that instead of a resonance parameter, the bandwidth is
specified in a 60dB ring decay time. One Ringz is equivalent to one component of the Klank UGen.


in - input signal to be processed
freq - resonant frequency in Hertz
decaytime - the 60 dB decay time of the filter


See also: DynKlank


{ Ringz.ar(Dust.ar(3, 0.3), 2000, 2) }.play

{ Ringz.ar(WhiteNoise.ar(0.005), 2000, 0.5) }.play

// modulate frequency
{ Ringz.ar(WhiteNoise.ar(0.005), XLine.kr(100,3000,10), 0.5) }.play

{ Ringz.ar(Impulse.ar(6, 0, 0.3),  XLine.kr(100,3000,10), 0.5) }.play

// modulate ring time
{ Ringz.ar(Impulse.ar(6, 0, 0.3),  2000, XLine.kr(4, 0.04, 8)) }.play

// modulate ring time opposite direction
{ Ringz.ar(Impulse.ar(6, 0, 0.3), 2000, XLine.kr(0.04, 4, 8)) }.play


(
{ 
	var exciter;
	exciter = WhiteNoise.ar(0.001);
	Mix.arFill(10, {
		Ringz.ar(exciter, 
			XLine.kr(exprand(100.0,5000.0), exprand(100.0,5000.0), 20),
			0.5)
	})
}.play
)


