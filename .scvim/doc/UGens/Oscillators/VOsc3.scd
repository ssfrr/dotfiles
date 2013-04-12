VOsc3			three variable wavetable oscillators

VOsc3.ar(table, freq1, freq2, freq3, mul, add)

A wavetable lookup oscillator which can be swept smoothly across wavetables. All the wavetables must be allocated to the same size. Fractional values of table will interpolate between two adjacent tables. This unit generator contains three oscillators at different frequencies, mixed together.

This oscillator requires at least two buffers to be filled with a wavetable format signal.  This preprocesses the Signal into a form which can be used efficiently by the Oscillator.  The buffer size must be a power of 2.

This can be achieved by creating a Buffer object and sending it one of the "b_gen" messages ( sine1, sine2, sine3 ) with the wavetable flag set to true.  

This can also be achieved by creating a Signal object and sending it the 'asWavetable' message, saving it to disk, and having the server load it from there.

If you use Buffer objects to manage buffer numbers, you can use the *allocConsecutive method to allocate a continuous block of buffers. See the Buffer helpfile for details. Note that since VOsc uses fractional buffer numbers you will need to call bufnum on any Buffer objects which are used directly as UGen inputs.

table - buffer index. Can be swept continuously among adjacent wavetable buffers of the same size.
freq1, freq1, freq3 - frequencies in Hertz of the three oscillators
phase - phase offset or modulator in radians

note about wavetables:
VOsc3 requires the b_gen sine1 wavetable flag to be ON.


(
s = Server.local;
// allocate and fill tables 0 to 7
8.do({ arg i;
	var n, a;
	// allocate table
	s.sendMsg(\b_alloc, i, 1024); 
	// generate array of harmonic amplitudes
	n = (i+1)**2;
	a = Array.fill(n, { arg j; ((n-j)/n).squared.round(0.001) });
	// fill table
	s.performList(\sendMsg, \b_gen, i, \sine1, 7, a);
});
)

(
SynthDef("help-VOsc",{ arg out=0, bufoffset=0, freq=240;
	var x;
	// mouse x controls the wavetable position
	x = MouseX.kr(0,7);
	Out.ar(out,
		VOsc3.ar(bufoffset+x, freq+[0,1],freq+[0.37,1.1],freq+[0.43, -0.29], 0.3)
	)
}).play(s,[\out, 0, \bufoffset, 0]);
)

(
8.do({ arg i;
	var a;
	s.sendMsg(\b_alloc, i, 1024); // allocate table
	// generate array of harmonic amplitudes
	a = Array.fill(i, 0) ++ [0.5, 1, 0.5];
	// fill table
	s.performList(\sendMsg, \b_gen, i, \sine1, 7, a);
});
)

(
8.do({ arg i;
	var a, n;
	s.sendMsg(\b_alloc, i, 1024); // allocate table
	// generate array of harmonic amplitudes
	n = (i+1)*8;
	a = Array.fill(n,0);
	(n>>1).do({ arg i; a.put(n.rand, 1) });
	// fill table
	s.performList(\sendMsg, \b_gen, i, \sine1, 7, a);
});
)

(
8.do({ arg i;
	var a;
	s.sendMsg(\b_alloc, i, 1024); // allocate table
	// generate array of harmonic amplitudes
	n = (i+1)**2;
	a = Array.fill(n, { arg j; 1.0.rand2 });
	// fill table
	s.performList(\sendMsg, \b_gen, i, \sine1, 7, a);
});
)

(
var a;
a = Array.fill(64, { arg j; 1.0.rand2 });
8.do({ arg i;
	s.sendMsg(\b_alloc, i, 1024); // allocate table
	// generate array of harmonic amplitudes
	n = (i+1)**2;
	// fill table
	s.performList(\sendMsg, \b_gen, i, \sine1, 7, a.extend(n.asInteger));
});
)

(
var a;
a = Array.fill(64, { arg j; 1/(j+1) });
8.do({ arg i;
	s.sendMsg(\b_alloc, i, 1024); // allocate table
	// generate array of harmonic amplitudes
	n = (i+1)**2;
	// fill table
	s.performList(\sendMsg, \b_gen, i, \sine1, 7, a.extend(n.asInteger));
});
)




