BPF				2nd order Butterworth bandpass filter

Inherits from: Object : AbstractFunction : UGen : Filter 


BPF.ar(in, freq, rq, mul, add)
BPF.kr(in, freq, rq, mul, add)


A second order Butterworth bandpass filter. 

in - input signal to be processed
freq - centre frequency in Hertz.
rq - the reciprocal of Q.  bandwidth / cutoffFreq. 


// modulate filter frequency with a sine
{ BPF.ar(Saw.ar(200, 0.5), SinOsc.kr(XLine.kr(0.7, 300, 20), 0, 3600, 4000), 0.3) }.play;

// modulate filter frequency with the cursor position
{ BPF.ar(Saw.ar(200, 0.5), MouseX.kr(100, 10000, 1), 0.3) }.play;

// BPF on control signals:
(
{ 	var vib = BPF.kr(PinkNoise.kr, MouseX.kr(1, 100, 1), 0.3) * 10;
	SinOsc.ar(vib * 200 + 600) * 0.2 }.play;
)


