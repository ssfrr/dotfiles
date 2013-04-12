Pbrown			brownian motion pattern

superclass: Pattern

Pbrown(lo, hi, step, length)

Returns a stream that behaves like a brownian motion. 

lo, hi - lower and upper boundary of values  (default: 0.0 and 1.0)
step - maximum change per step - the distribution is xrand2.  (default: 0.125)
length - number of values produced (default: inf)


See also: BrownNoise, Pgbrown


// example

(
var a;
a = Pbrown(0.0, 1.0, 0.1, inf);
c = a.asStream.nextN(500);
w = Window.new("Pbrown", Rect(10, 10, 540, 800));
// plot the values
c.plot(bounds: Rect(10, 10, 520, 380), discrete: true, parent: w);
// a histogram of the values
c.histo(500).plot(bounds: Rect(10, 410, 520, 380), parent: w);
)

(
var a;
a = Pbrown(0.0, 1.0, 0.2, inf);
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
a = Pbrown(0.0, 1.0, 0.1, inf).asStream;
{
	loop {
		Synth(\help_sinegrain, [\freq, a.next * 600 + 300]);
		0.02.wait;
	}
}.fork;
)



// parallel browninan motions
(
var a, x, f;
a = Pbrown(0.0, 1.0, 0.1, inf);

f = { |pattern, dt=0.02, min=300, max=900|
	{
		var x = pattern.asStream;
		loop {
			Synth.grain(\help_sinegrain, [\freq, x.next.linexp(0, 1, min, max), \sustain, dt]);
			dt.wait;
		}
	}.fork;
}.flop;

// 3 parallel motions
f.(a, [0.02, 0.08, 0.16]);
)






