Pprob				random values with arbitrary probability distribution

superclass: Patterns

creates an integral table on instantiation (cpu intensive) which is then used by the streams
to generate random values efficiently. 

Pprob(distribution, lo, hi, length, tableSize)

	distribution
		desired probability distribution (histogram) 
	lo, hi
		lower and upper bounds of the resulting values
	length
		number of values to repeat
	tableSize
		resample table to this size. If the size of the distribution is 
		smaller than 64, it is (linearly) resampled to this minimum size

	distribution_(list)
		set the distribution, the table is recalculated
	tableSize_(n)
		set the resample size, the table is recalculated




// a consistency test
(
var a = Pprob([0,0,0,0,1,1,1,1,3,3,6,6,9].scramble);
var b = a.asStream;
b.nextN(800).sort.plot("sorted distribution");
b.nextN(800).sort.plot("sorted distribution, again");
)


// comparison: emulate a linrand
(
var a, b, x, y;
a = Pprob([1, 0]);
x = Pfunc({ 1.0.linrand });

b = a.asStream;
y = x.asStream;

postf("Pprob mean: % linrand mean: % \n", b.nextN(800).mean, y.nextN(800).mean);

b.nextN(800).sort.plot("this is Pprob");
y.nextN(800).sort.plot("this is linrand");
)


// compare efficiency

bench { Pprob([0, 1]) } // this is fairly expensive
bench { 16.do { Pseq([0, 1] ! 32) } }

x = Pprob([0, 1]).asStream;
y = Pseq([0, 1], inf).asStream;

bench { 100.do { x.next } }; // this very efficient
bench { 100.do { y.next } };



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
var t;
a = Pprob([0, 0, 1, 0, 1, 1, 0, 0], 60, 80);
t = a.asStream;
Routine({
	loop({
	Synth(\help_sinegrain, [\freq, t.next.midicps]);
	0.01.wait;
	})
}).play;
)

a.distribution = [0, 1];
a.distribution = [1, 0];
a.distribution = [0, 0, 0, 0, 1, 0];
a.distribution = [0, 1, 0, 0, 0, 0];

// higher resolution results in a more accurate distribution:
a.tableSize = 512;
a.tableSize = 2048;





