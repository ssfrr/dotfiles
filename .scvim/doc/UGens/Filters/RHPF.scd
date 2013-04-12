RHPF

Inherits from: Object : AbstractFunction : UGen : Filter : RLPF

RHPF.ar(in, freq, q, mul, add)
RHPF.kr(in, freq, q, mul, add)

A resonant high pass filter. 
in - input signal to be processed
freq - cutoff frequency.
rq - the reciprocal of Q.  bandwidth / cutoffFreq. 

// modulate cutoff frequency

{ RHPF.ar(Saw.ar(200,0.1), FSinOsc.kr(XLine.kr(0.7,300,20), 0, 3600, 4000), 0.2) }.play;

// filter a modulator

(
{ 	var ctl = RHPF.kr(LFSaw.kr(2), SinOsc.kr(XLine.kr(0.07,30,20), 0, 35, 40), 0.05);
	SinOsc.ar(ctl * 200 + 500) * 0.2;
}.play;
)


