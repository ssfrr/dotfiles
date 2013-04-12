SomeUGen			explanation of the what SomeUGen does

SomeUGen.ar(arg1, arg2, mul, add)
SomeUGen.kr(arg1, arg2, mul, add)

Here is a short prose explanation of what the UGen does, and any other relevant points.
arg1 - explanation of arg1 and default value if applicable
arg2 - explanation of arg2 and default value if applicable

See also: SinOsc [other related UGens...]


// what this example does
x = { SomeUGen.ar(XLine.kr(2000, 200), 0, 0.5) }.play;
x.free;

// what this example does
(
x = SynthDef(\helpSomeUGen, { 
	Out.ar(0, SomeUGen.ar(SinOsc.ar(XLine.kr(1, 1000, 9), 0, 200, 800), 0, 0.25)); 
}).play; 
)
x.free;


