InTrig				generate a trigger anytime a bus is set

Inherits from: Object : AbstractFunction : UGen : MultiOutUGen : AbstractIn

*kr(bus, numChannels)

bus - the index of the bus to read in from.
numChannels - the number of channels (i.e. adjacent buses) to read in. The default is 1. You cannot modulate this number by assigning it to an argument in a SynthDef.

Any time the bus is "touched" ie. has its value set (using "/c_set" etc.), a single impulse trigger will be generated. Its amplitude is the value that the bus was set to.


s = Server.local;
b = Bus.control(s, 1);

SynthDef("help-InTrig", { arg out=0, busnum=0;
	var inTrig;
	inTrig = InTrig.kr( busnum );
	Out.ar(out, 
		EnvGen.kr(Env.perc, gate: inTrig, levelScale: inTrig ) * SinOsc.ar
	)
}).play(s, [\out, 0, \busnum, b]);



b.set(1.0);

b.value = 1.0;

b.value = 0.2;

b.value = 0.1;

compare with In example.




