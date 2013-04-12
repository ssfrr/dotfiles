PauseSelf			when triggered, pause enclosing synth

Inherits from: Object : AbstractFunction : UGen

pause enclosing synth when input signal crosses from non-positive to positive
	
PauseSelf.kr(in)  in - input signal

see also: FreeSelf

	
	// example
	
	(
	SynthDef(\pauseSelf_help, {|out, t_trig|
		PauseSelf.kr(t_trig);
		Out.ar(out, SinOsc.ar(400,0,0.2));
	}).send(s);
	)
	
	a = Synth(\pauseSelf_help);
	a.set(\t_trig, 1);
	a.run(true);
	a.set(\t_trig, 1);
	a.free;


