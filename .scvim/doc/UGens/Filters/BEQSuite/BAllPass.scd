BAllPass		All Pass Filter.

BAllPass.ar(in, freq, rq, mul, add)

in - input signal to be processed.
freq - center frequency.
rq - the reciprocal of Q.  bandwidth / cutoffFreq. 

The B equalization suite is based on the Second Order Section (SOS) biquad UGen.

note: Biquad coefficient calculations imply certain amount of CPU overhead. These plugin UGens contain optimizations such that the coefficients get updated only when there has been a change to one of
the filter's parameters. This can cause spikes in CPU performance and should be considered when using several of these units.

see also: SOS, BLowPass, BLowPass4, BHiPass, BHiPass4, BPeakEQ, BLowShelf, BHiShelf, BBandPass, BBandStop

s.boot;
(
z = { // thru
BAllPass.ar(
	SoundIn.ar([0,1]),
	MouseX.kr(10,18000,\exponential),
	0.8, // rq
	0.5); // mul
}.play)
z.release;

(
z = { // like a bandpass
	var sig;
	sig = SoundIn.ar([0,1]), * 0.5;
	BAllPass.ar(sig, MouseX.kr(10,18000,\exponential), 0.8) + sig.neg
}.play)
z.release;


