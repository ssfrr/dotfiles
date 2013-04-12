<=				less than or equal

BinaryOperator

a <= b

Result is 1 if a <= b, otherwise it is 0. This can be useful for triggering purposes, among other things:

s = Server.local;
s.boot;

( // trigger an envelope
{
	var trig;
	trig = SinOsc.ar(1) <= 0;
	Out.ar(0,
		EnvGen.kr(Env.perc, trig, doneAction: 0) 
			* SinOsc.ar(440,0,0.1)
	)
}.play(s);)

( // trigger a synth 
SynthDef("help-EnvGen",{ arg out=0;
	Out.ar(out,
		EnvGen.kr(Env.perc,1.0,doneAction: 2) 
			* SinOsc.ar(440,0,0.1)
	)
}).send(s);

// This synth has no output. It only checks amplitude of input and looks for a transition from > 0.2
// to < 0.2

SynthDef("help-<= trig", {
	SendTrig.kr(Amplitude.kr(SoundIn.ar(0)) <= 0.2);
}).play(s);

// responder to trigger synth
OSCresponderNode(s.addr,'/tr',{ "triggered".postln; Synth.new("help-EnvGen") }).add;
)


