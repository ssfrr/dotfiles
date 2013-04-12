Pan4			four channel equal power pan

Pan4.ar(in, xpos, ypos, level)

Four channel equal power panner.
in - input signal
xpos - x  pan position from -1 to +1(left to right)
ypos - y pan position from -1 to +1 (back to front)
level - a control rate level input.

Outputs are in order LeftFront, RightFront, LeftBack, RightBack.

// You'll only hear the front two channels on a stereo setup.
(
SynthDef("help-Pan4", { 
	Out.ar(0, Pan4.ar(PinkNoise.ar, FSinOsc.kr(2), FSinOsc.kr(1.2), 0.3)) 
}).play;
)

play({ Pan4.ar(PinkNoise.ar, -1,  0, 0.3) }); // left pair
play({ Pan4.ar(PinkNoise.ar,  1,  0, 0.3) }); // right pair
play({ Pan4.ar(PinkNoise.ar,  0, -1, 0.3) }); // back pair
play({ Pan4.ar(PinkNoise.ar,  0,  1, 0.3) }); // front pair

play({ Pan4.ar(PinkNoise.ar,  0,  0, 0.3) }); // center



