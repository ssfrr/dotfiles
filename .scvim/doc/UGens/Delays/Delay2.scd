Delay2				two sample delay

Delays the input by 2 samples.
Delay2.ar(in, mul, add)

in - input to be delayed.

(
plot({
	var z;
	z = Dust.ar(1000);
	[z, z - Delay2.ar(z)] 	// [ original, subtract delayed from original ]
}))





