RLPF				resonant low pass filter

Inherits from: Object : AbstractFunction : UGen : Filter 

A resonant low pass filter.

RLPF.ar(in, freq, rq, mul, add)
RLPF.kr(in, freq, rq, mul, add)

in - input signal to be processed
freq - cutoff frequency.
rq - the reciprocal of Q.  bandwidth / cutoffFreq. 

See also: RHPF, LPF

// modulate cutoff frequency
{ RLPF.ar(Saw.ar(200, 0.1), FSinOsc.kr(XLine.kr(0.7, 300, 20), 0, 3600, 4000), 0.2) }.play;


// filter a modulator
(
{ 
var ctl = RLPF.ar(Saw.ar(5, 0.1), 25, 0.03);
 SinOsc.ar(ctl * 200 + 400) * 0.2;
}.play;
)

(
{ 
var ctl = RLPF.ar(Saw.ar(5, 0.1), MouseX.kr(2, 200, 1), MouseY.kr(0.01, 1, 1));
 SinOsc.ar(ctl * 200 + 400) * 0.2;
}.play;
)


