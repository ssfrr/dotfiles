FreeSelf			when triggered, free enclosing synth

Inherits from: Object : AbstractFunction : UGen

free enclosing synth when input signal crosses from non-positive to positive
	
FreeSelf.kr(in)  in - input signal

see also: PauseSelf

	// example
	
	(
	SynthDef(\freeSelf_help, { |out, t_trig|
		FreeSelf.kr(t_trig);
		Out.ar(out, SinOsc.ar(400,0,0.2));
	}).send(s);
	)
	
	a = Synth(\freeSelf_help);
	a.set(\t_trig, 1);

	// a single impulse SynthDef:
	
	(
	SynthDef(\dirac, { |out, amp=0.1|
		var u = Impulse.ar(0);
		FreeSelf.kr(u);
		Out.ar(out, u * amp); 
			// multiply by amp after using for release, so amp = 0 
			// doesn't cause synth buildup.
	}).send(s);
	)
	
	(
	Task {
		loop({
			fork {
				exprand(34, 156).do {|i|
					i = i + 1;
					Synth.grain(\dirac, [\amp, 1 / i]);
					(0.006 * i).wait;
				};
			};	
			1.wait;
		})
	} .play;
	)
	


