BLowPass4	24db/oct rolloff - 4th order resonant Low Pass Filter. [1]

BLowPass4.ar(in, freq, rq, mul, add)

in - input signal to be processed
freq - cutoff frequency.
rq - the reciprocal of Q.  bandwidth / cutoffFreq.

The B equalization suite is based on the Second Order Section (SOS) biquad UGen.

note: Biquad coefficient calculations imply certain amount of CPU overhead. These plugin UGens contain optimizations such that the coefficients get updated only when there has been a change to one of
the filter's parameters. This can cause spikes in CPU performance and should be considered when using several of these units.

[1] this is a composite pseudo UGen. BLowPass4 is built by cascading 2 SOS sections.

see also: SOS, BLowPass, BHiPass, BHiPass4, BPeakEQ, BLowShelf, BHiShelf, BBandPass, BBandStop, BAllPass.

s.boot;
(
z = {
	BLowPass4.ar(
		SoundIn.ar([0,1]),
		MouseX.kr(10,20000,\exponential), // cutoff freq.
		MouseY.kr(0.1, 1.0, \linear), // rq - compensate for 2 biquad sections.
		0.5); // mul
}.play)
z.release;



