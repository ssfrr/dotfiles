BHiShelf		Hi Shelf.

BHiShelf.ar(in, freq, rs, db, mul, add)

in - input signal to be processed.
freq - center frequency.
rs - the reciprocal of S.  Shell boost/cut slope. When S = 1, the shelf slope is as steep as it can be and remain monotonically increasing or decreasing gain with frequency.  The shelf slope, in  dB/octave, remains proportional to S for all other values for a fixed freq/SampleRate.ir and db.
db - gain. boost/cut the center frequency in dBs.

The B equalization suite is based on the Second Order Section (SOS) biquad UGen.

note: Biquad coefficient calculations imply certain amount of CPU overhead. These plugin UGens contain optimizations such that the coefficients get updated only when there has been a change to one of
the filter's parameters. This can cause spikes in CPU performance and should be considered when using several of these units.

see also: SOS, BLowPass, BLowPass4, BHiPass, BHiPass4, BPeakEQ, BLowShelf, BBandPass, BBandStop, BAllPass.

s.boot;
(
z = { // toy around with boost/cut
BHiShelf.ar(
	SoundIn.ar([0,1]),
	MouseX.kr(2200,18000,\exponential),
	1.0,  // rs
	MouseY.kr(18.0, -18.0, \linear),
	0.5); // mul
}.play)
z.release;

(
z = { // toy around with rs
BHiShelf.ar(
	SoundIn.ar([0,1]),
	MouseX.kr(2200,18000,\exponential),
	MouseY.kr(0.1, 1.0, \linear),  // rs
	6,	// db
	0.5); // mul
}.play)
z.release;


