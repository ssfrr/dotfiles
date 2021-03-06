IEnvGen				envelope generator for polling values from an InterplEnv

superclass: UGen

	*ar(ienvelope, index, mul, add)
	*kr(ienvelope, index, mul, add)

	Plays back break point envelopes from the index point. The envelopes are instances of the InterplEnv 	class. See the InterplEnv help file for more info. 

	
	ienvelope 	an instance of InterplEnv (this is static for the life of the UGen)
	index		a point to access within the InterplEnv


// example

SynthDef(\test, {arg gate = 1;
	var env, sin;
	sin = SinOsc.ar(440, 0, 1);
	env = InterplEnv([0, 0.6, 0.3, 1.0, 0], [0.1, 0.02, 0.4, 1.1], [\lin, \exp, -6, \sin]).plot;	Out.ar(0, sin * 
		// use MouseX to index into the InterplEnv to control amps
		IEnvGen.kr(env, MouseX.kr(0, env.times.sum)) *
		EnvGen.kr(Env.asr(0.01, 1, 0.01), gate, doneAction: 2);
		)
}).load(s);

s = Server.internal.boot;
s.scope;

s.sendMsg(\s_new, \test, a = s.nextNodeID, 0, 1);
s.sendMsg(\n_set, a, \gate, 0);

// index with an SinOsc ... mouse controls amplitude of SinOsc
SynthDef(\test, {
	var env, sin;
	sin = SinOsc.ar(440, 0, MouseX.kr(0, 1));
	// use offset so negative values of SinOsc will map into the InterplEnv
	env = InterplEnv([-1, -0.7, 0.7, 1], [ 0.8666, 0.2666, 0.8668 ], \lin, -1.0);
	Out.ar(0, IEnvGen.ar(env, sin)) 
}).load(s);

s.sendMsg(\s_new, \test, a = s.nextNodeID, 0, 1);
s.sendMsg(\n_free, a);


// index with Amplitude of input, control freq of SinOsc
SynthDef(\test, {arg inbus;
	var env, point;
	point = Amplitude.ar(In.ar(inbus), 0.01, 0.2);
	// use offset so negative values of SinOsc will map into the InterplEnv
	env = InterplXYC([[0, 330, \exp], [0.5, 440, \exp], [1.0, 1760]]);
	Out.ar(1, SinOsc.ar(IEnvGen.kr(env, point), 0, 0.2)) 
}).load(s);

s.sendMsg(\s_new, \test, a = s.nextNodeID, 0, 1, \inbus, s.options.numOutputBusChannels);
s.sendMsg(\n_free, a);


