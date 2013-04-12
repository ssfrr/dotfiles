LinPan2			two channel linear pan

LinPan2.ar(in, pos, level)

Two channel linear panner. This one sounds more like the Rhodes tremolo than Pan2.
in - input signal
pos - pan position, -1 is left, +1 is right
level - a control rate level input

play({ LinPan2.ar(PinkNoise.ar(0.4), FSinOsc.kr(2)) });

SynthDef("help-LinPan2", {  Out.ar(0, LinPan2.ar(FSinOsc.ar(800, 0, 0.1), FSinOsc.kr(3))) }).play;




