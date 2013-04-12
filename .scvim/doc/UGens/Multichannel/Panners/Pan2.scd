Pan2			two channel equal power pan

Pan2.ar(in, pos, level)

Two channel equal power panner.
in - input signal
pos - pan position, -1 is left, +1 is right
level - a control rate level input


SynthDef("help-Pan2", { Out.ar(0, Pan2.ar(PinkNoise.ar(0.4), FSinOsc.kr(2), 0.3)) }).play;



