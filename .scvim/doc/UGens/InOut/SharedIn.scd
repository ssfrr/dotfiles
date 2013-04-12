SharedIn			read from a shared control bus

Inherits from: Object : AbstractFunction : UGen : MultiOutUGen : AbstractIn

SharedIn.kr(bus, numChannels)

Reads from a control bus shared between the internal server and the SC client. Control rate only. Writing to a shared control bus from the client is synchronous. When not using the internal server use node arguments or the set method of Bus (or /c_set in messaging style). 

bus - the index of the shared control bus to read from
numChannels - the number of channels (i.e. adjacent buses) to read in. The default is 1. You cannot modulate this number by assigning it to an argument in a SynthDef.

(
// only works with the internal server
s = Server.internal;
s.boot;
)

(
SynthDef("help-SharedIn1", {
	Out.ar(0, SinOsc.ar(Lag.kr(SharedIn.kr(0, 1), 0.01), 0, 0.2));
}).send(s);
SynthDef("help-SharedIn2", {
	Out.ar(1, SinOsc.ar(Lag.kr(SharedIn.kr(0, 1), 0.01, 1.5), 0, 0.2));
}).send(s);
)

(
s.setSharedControl(0, 300); // an initial value
s.sendMsg(\s_new, "help-SharedIn1", x = s.nextNodeID, 0, 1);
s.sendMsg(\s_new, "help-SharedIn2", y = s.nextNodeID, 0, 1);

Routine({
	30.do({
		s.setSharedControl(0, 300 * (10.rand + 1));
		0.2.wait;
	});
	s.sendMsg(\n_free, x);
	s.sendMsg(\n_free, y);
}).play;
)


s.quit;



