SharedOut			write to a shared control bus

Inherits from: Object : AbstractFunction : UGen : AbstractOut

SharedOut.kr(bus, channelsArray)

Reads from a control bus shared between the internal server and the SC client. Control rate only. Reading from a shared control bus on the client is synchronous. When not using the internal server use the get method of Bus (or /c_get in messaging style) or SendTrig with an OSCresponder or OSCresponderNode.
bus - the index of the shared control bus to read from
channelsArray - an Array of channels or single output to write out. You cannot change the size of this once a SynthDef has been built.

(
// only works with the internal server
s = Server.internal;
s.boot;
)

(
SynthDef("help-SharedOut", {
	SharedOut.kr(0, SinOsc.kr(0.2));
}).send(s);
)

(
s.sendMsg(\s_new, "help-SharedOut", x = s.nextNodeID, 0, 1);
s.sendMsg(\n_trace, x);

// poll the shared control bus
Routine({
	30.do({
		s.getSharedControl(0).postln;
		0.2.wait;
	});
}).play;
)


s.quit;



