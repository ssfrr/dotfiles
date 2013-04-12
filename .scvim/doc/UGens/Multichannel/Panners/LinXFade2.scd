LinXFade2			two channel linear crossfade

LinXFade2.ar(inA, inB, pan, level)

Two channel linear crossfader.

inA - an input signal
inB - another input signal
pan - cross fade position from -1 to +1
level - a control rate level input

play({ LinXFade2.ar(FSinOsc.ar(800, 0, 0.2), PinkNoise.ar(0.2), FSinOsc.kr(1)) });



