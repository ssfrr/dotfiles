BLowPass	12db/oct rolloff - 2nd order resonant Low Pass Filter.

Inherits from: Object : AbstractFunction : UGen : Filter : BEQSuite


BLowPass.ar(in, freq, rq, mul, add)

in - input signal to be processed
freq - cutoff frequency.
rq - the reciprocal of Q.  bandwidth / cutoffFreq. 

*sc(dummy, freq, rq)
	calculate filter coefficients.

The B equalization suite is based on the Second Order Section (SOS) biquad UGen.

note: Biquad coefficient calculations imply certain amount of CPU overhead. These plugin UGens contain optimizations such that the coefficients get updated only when there has been a change to one of
the filter's parameters. This can cause spikes in CPU performance and should be considered when using several of these units.

see also: SOS, BLowPass4, BHiPass, BHiPass4, BLowShelf, BHiShelf, BBandPass, BBandStop, BAllPass.

s.boot;
(
z = {
	BLowPass.ar(
		SoundIn.ar([0,1]),
		MouseX.kr(10,20000,\exponential), // cutoff freq.
		MouseY.kr(0.0, 1.0, \linear), // rq
		0.5); // mul
}.play
)
z.release;



