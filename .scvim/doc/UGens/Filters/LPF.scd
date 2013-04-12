LPF				2nd order Butterworth lowpass filter

Inherits from: Object : AbstractFunction : UGen : Filter 

LPF.ar(in, freq, mul, add)
LPF.kr(in, freq, mul, add)


A second order low pass filter. 
in - input signal to be processed
freq - cutoff frequency.

{ LPF.ar(Saw.ar(200, 0.1), SinOsc.kr(XLine.kr(0.7, 300, 20), 0, 3600, 4000)) }.play;


// control rate version is still erratic sometimes:
(
{ var ctl = LPF.kr(LFPulse.kr(8), SinOsc.kr(XLine.kr(1, 30, 5)) + 2);
	SinOsc.ar(ctl * 200 + 400) * 0.2 
}.play;
)

(
{ var ctl = LPF.kr(LFPulse.kr(8), MouseX.kr(2, 50, 1));
	SinOsc.ar(ctl * 200 + 400)  * 0.2
}.play;
)


