BRF				2nd order Butterworth band reject filter

Inherits from: Object : AbstractFunction : UGen : Filter : BPF


BRF.ar(in, freq, rq, mul, add)
BRF.kr(in, freq, rq, mul, add)


A second order low pass filter. 
in - input signal to be processed
freq - centre frequency in Hertz.
rq - the reciprocal of Q. bandwidth / cutoffFreq. 


{ BRF.ar(Saw.ar(200, 0.1), FSinOsc.kr(XLine.kr(0.7, 300, 20), 0, 3800, 4000), 0.3) }.play;

{ BRF.ar(Saw.ar(200, 0.5), MouseX.kr(100, 10000, 1), 0.3) }.play;


	// BRF on control signals:
(
{ 	var vib = BRF.kr(SinOsc.kr([1, 3, 10], 0, [1, 0.5, 0.25]).sum, MouseX.kr(1, 10, 1), 0.3);
	SinOsc.ar(vib * 200 + 600) * 0.2 }.play;
)


