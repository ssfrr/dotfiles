Rossler				chaotic function

Rossler.ar(chaosParam, dt, mul, add)

The Rossler attractor is a well known chaotic function.
The chaosParam can be varied from 1.0 to 25.0 with a dt of 0.04.
Valid ranges for chaosParam vary depending on dt.
chaosParam - a Float.
dt - time step parameter. Default is 0.04.

//not defined yet!

(
SynthDef("help-Rossler", { arg out=0;
	Out.ar(out, 
		Rossler.ar(4, 0.08)
	)
}).play;
)

(
a = SynthDef("help-Rossler", { arg out=0, param=4, dt=0.04;
	Out.ar(out, 
		Rossler.ar(param, dt)
	)
}).play;
)

a.set(\param, 2.5);
a.set(\dt, 0.02);




