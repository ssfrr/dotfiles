Formlet			FOF-like filter

Inherits from: Object : AbstractFunction : UGen : Filter 

Formlet.ar(in, freq, attacktime, decaytime, mul, add)
Formlet.kr(in, freq, attacktime, decaytime, mul, add)


This is a resonant filter whose impulse response is like that of a sine wave with a Decay2 envelope over it.
It is possible to control the attacktime and decaytime.

Formlet is equivalent to:

Ringz(in, freq, decaytime) - Ringz(in, freq, attacktime)

Note that if attacktime == decaytime then the signal cancels out and if attacktime > decaytime
then the impulse response is inverted.

The great advantage to this filter over FOF is that there is no limit to the number of overlapping
grains since the grain is just the impulse response of the filter.

in - input signal to be processed
freq - resonant frequency in Hertz
attackTime - 60 dB attack time in seconds.
decayTime - 60 dB decay time in seconds.



{ Formlet.ar(Impulse.ar(20, 0.5), 1000, 0.01, 0.1) }.play;

{ Formlet.ar(Blip.ar(XLine.kr(10,400,8), 1000, 0.1), 1000, 0.01, 0.1) }.play;

(
// modulating formant frequency
{ 
	var in;
	in = Blip.ar(SinOsc.kr(5,0,20,300), 1000, 0.1);
	Formlet.ar(in, XLine.kr(1500,700,8), 0.005, 0.04);
}.play;
)

(
// mouse control of frequency and decay time.
{ 
	var in;
	in = Blip.ar(SinOsc.kr(5,0,20,300), 1000, 0.1);
	Formlet.ar(in, 
		MouseY.kr(700,2000,1), 
		0.005, MouseX.kr(0.01,0.2,1));
}.play;
)

(
// mouse control of frequency and decay time.
{ 
	var freq;
	freq = Formlet.kr(
		Dust.kr(10 ! 2), 
		MouseY.kr(7,200,1), 
		0.005, MouseX.kr(0.1,2,1)
	);
	SinOsc.ar(freq * 200 + [500, 600] - 100) * 0.2
}.play;
)



