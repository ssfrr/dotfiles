HPF				2nd order Butterworth highpass filter

Inherits from: Object : AbstractFunction : UGen : Filter : LPF


HPF.ar(in, freq, mul, add)
HPF.kr(in, freq, mul, add)

A second order high pass filter. 
in - input signal to be processed
freq - cutoff frequency.


{ HPF.ar(Saw.ar(200,0.1), FSinOsc.kr(XLine.kr(0.7, 300, 20), 0, 3600, 4000), 5) }.play;

(
{ 	var ctl = HPF.kr(LFSaw.kr(5), SinOsc.kr(XLine.kr(0.07,30,20), 0, 35, 40)) ;
	SinOsc.ar(ctl * 200 + 500) * 0.1;
}.play;
)

(
{ 	var ctl = HPF.kr(LFSaw.kr(5,0.1), MouseX.kr(2, 200, 1));
	SinOsc.ar(ctl * 200 + 400) * 0.1;
}.play;
)


