BBandPass		Band Pass Filter.

BBandPass.ar(in, freq, bw, mul, add)

in - input signal to be processed.
freq - center frequency.
bw - the bandwidth in octaves between -3 dB frequencies

The B equalization suite is based on the Second Order Section (SOS) biquad UGen.

note: Biquad coefficient calculations imply certain amount of CPU overhead. These plugin UGens contain optimizations such that the coefficients get updated only when there has been a change to one of
the filter's parameters. This can cause spikes in CPU performance and should be considered when using several of these units.

see also: SOS, BLowPass, BLowPass4, BHiPass, BHiPass4, BPeakEQ, BLowShelf, BHiShelf, BBandStop, BAllPass.

s.boot;
(
z = {
BBandPass.ar(
	SoundIn.ar([0,1]),
	MouseX.kr(20,20000,\exponential),
	MouseY.kr(0.0, 10.0, \linear), // bw
	0.5); // mul
}.play)
z.release;

(
z = {
BBandPass.ar(
	WhiteNoise.ar ! 2,
	MouseX.kr(20,20000,\exponential),
	MouseY.kr(0.0, 10.0, \linear), // bw
	0.5); // mul
}.play)
z.release;


