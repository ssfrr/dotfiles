Fdef				lazy function proxy

Inherits from: Object : AbstractFunction : Ref : Maybe

Placeholder for functions to calculate with.

See also: Maybe.
Related: Pdef, Tdef, Pdefn, Ndef
Overview: JITLib

	Fdef(name, func)
	Fdef(name)
	
		if no instance exists with this name, create a new one, otherwise return the existing one.
		If func is given, replace the old func with the new one.
				



// example

Fdef(\x, { 8 + 9 });

Fdef(\y, Fdef(\x) - 3);

Fdef(\y).value;

Fdef(\x, 3);

Fdef(\y).value;

Fdef(\x, { |x=0| x });


Fdef(\x).value(8);

Fdef(\y).value(8);


z = Fdef(\x) * Fdef(\y) + { 1.0.rand };

z.value;
z.value(400);





// sound example
(
s.boot;
SynthDef("gpdef", 
	{ arg out=0, freq=440, sustain=0.05, amp=0.1;
		var env;
		env = EnvGen.kr(Env.perc(0.01, sustain), doneAction:2) * amp;
		Out.ar(out, SinOsc.ar(freq, 0, env))
	}).add;
)

// fork a thread that plays some sounds
(
Fdef(\freq, 440);
Fdef(\dur, 0.2);

fork {
	loop {
		s.sendMsg("/s_new", "gpdef", -1, 1,1, \freq, Fdef(\freq).value);
		Fdef(\dur).value.wait;
	}
	
};
)

// some modifications

Fdef(\freq, Fdef(\midinote, 60).midicps);
Fdef(\midinote, { [67, 64, 65].choose });
Fdef(\midinote, { [67, 64, 65].choose } + Fdef(\offset));
Fdef(\offset, { 4.rand });
Fdef(\dur, 0.23);







