NumRunningSynths			number of currently running synths

superclass: InfoUGenBase



	*ir
			


// example: frequency is derived from the number of synths running
(
SynthDef("numRunning", { arg out;
	Out.ar(out, SinOsc.ar(NumRunningSynths.ir * 200 + 400, 0, 0.1)); 
}).send(s); 
)

s.sendMsg("/s_new", "numRunning", -1, 0, 0);
s.sendMsg("/s_new", "numRunning", -1, 0, 0);
s.sendMsg("/s_new", "numRunning", -1, 0, 0);
s.sendMsg("/s_new", "numRunning", -1, 0, 0);


