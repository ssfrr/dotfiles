BPeakEQ		parametric equalizer.

BPeakEQ.ar(in, freq, rq, db, mul, add)

in - input signal to be processed
freq - center frequency.
rq - the reciprocal of Q.  bandwidth / cutoffFreq.
db - boost/cut the center frequency (in dBs).

The B equalization suite is based on the Second Order Section (SOS) biquad UGen.

note: Biquad coefficient calculations imply certain amount of CPU overhead. These plugin UGens contain optimizations such that the coefficients get updated only when there has been a change to one of
the filter's parameters. This can cause spikes in CPU performance and should be considered when using several of these units.

see also: SOS, BLowPass, BLowPass4, BHiPass, BHiPass4, BLowShelf, BHiShelf, BBandPass, BBandStop, BAllPass.

s.boot;
(
z = { // toy with boost/cut
BPeakEQ.ar(
	SoundIn.ar([0,1]),
	MouseX.kr(20,20000,\exponential),
	0.8,  // rq
	MouseY.kr(12.0, -12.0, \linear),
	0.5); // mul
}.play)
z.release;

(
z = { // toy with rq
BPeakEQ.ar(
	SoundIn.ar([0,1]),
	MouseX.kr(20,20000,\exponential),
	MouseY.kr(10, 0.4, \linear),  // rq
	6, // boost/cut - +6dB
	0.5); // mul
}.play)
z.release;


