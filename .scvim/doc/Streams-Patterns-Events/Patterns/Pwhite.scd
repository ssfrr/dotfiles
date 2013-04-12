Pwhite		random values with uniform distribution

superclass: Pattern


Pwhite(lo, hi, length)
		
		lo, hi			lower and upper boundary of values (default: 0.0 and 1.0)
		length		number of values produced  (default: inf)
		
		

// example


(
var a;
a = Pwhite(0.0, 1.0, inf);
c = a.asStream.nextN(500);
w = Window.new("Pwhite", Rect(10, 10, 540, 800));
// plot the values
c.plot(bounds: Rect(10, 10, 520, 380), discrete: true, parent: w);
// a histogram of the values
c.histo(500).plot(bounds: Rect(10, 410, 520, 380), parent: w);
)

(
var a;
a = Pwhite(0.0, 1.0, inf);
a.asStream.nextN(1000).plot;
)


// sound example
(
SynthDef(\help_sinegrain, 
	{ arg out=0, freq=440, sustain=0.05;
		var env;
		env = EnvGen.kr(Env.perc(0.01, sustain, 0.2), doneAction:2);
		Out.ar(out, SinOsc.ar(freq, 0, env))
	}).add;
)


(
var a;
a = Pwhite(0.0, 1.0, inf).asStream;
{
	loop {
		Synth(\help_sinegrain, [\freq, a.next * 600 + 300]);
		0.02.wait;
	}
}.fork;
)

// this is equivalent to:
(
{
	loop {
		Synth(\help_sinegrain, [\freq, rrand(0.0, 1.0) * 600 + 300]);
		0.02.wait;
	}
}.fork;
)






