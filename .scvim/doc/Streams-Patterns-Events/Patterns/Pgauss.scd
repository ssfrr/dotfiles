Pgauss			random values that follow a Gaussian Distribution

superclass: Pattern


Pgauss(mean, standardDeviation, length)
		
		mean				The mean of the distribution (defaults to 0.0)
		standardDeviation		The spread of values around the mean.
		length				number of values produced  (default: inf)
		

This pattern uses the Box-Müller transform to generate a gaussian distribution from uniformly distributed values: 
sqrt(-2 * log(1.0.rand)) * sin(2pi.rand)



// example

(
var a;
a = Pgauss(0.0, 100, inf);
c = a.asStream.nextN(500);
w = Window.new("Pgauss", Rect(10, 10, 540, 800));
// plot the values
c.plot(bounds: Rect(10, 10, 520, 380), discrete: true, parent: w);
// a histogram of the values
c.histo(500).plot(bounds: Rect(10, 410, 520, 380), parent: w);
)

(
var a, c, w;
a = Pgauss(0.0, 10.0, inf);
c = a.asStream.nextN(500);
w = Window.new("Pgauss", Rect(10, 10, 540, 800));
// plot the values
c.plot(bounds: Rect(10, 10, 520, 380), discrete: true, parent: w);
// a histogram of the values
c.histo(500).plot(bounds: Rect(10, 410, 520, 380), parent: w);
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
a = Pgauss(0.0, 1.0,inf).asStream;
{
	loop {
		Synth(\help_sinegrain, [\freq, a.next * 600 + 300]);
		0.02.wait;
	}
}.fork;
)


