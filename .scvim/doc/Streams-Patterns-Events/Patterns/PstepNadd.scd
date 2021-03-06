PstepNadd			pattern that returns combinatoric sums

superclass: PstepNfunc


combines an arbitrary number of patterns by summing (depth first traversal).
when a stream ends it is recreated from its pattern until the top stream ends.

see also: Pstep3add


	*new(pattern1, pattern2, ... patternN);
	
	
//examples


// comparing PstepNadd and Pstep3add (test)
(
x = PstepNadd(Pseq([1, 2, 3]), Pseq([10, 20, 30, 40]), Pseq([100, 200, 300])).asStream;
y = Pstep3add(Pseq([1, 2, 3]), Pseq([10, 20, 30, 40]), Pseq([100, 200, 300])).asStream;

50.do({ [x.next, y.next].postln });
)

// pattern return stream until the longest stream ended 
(
x = PstepNadd(
		Plazy({ "pattern1.asStream".postln; Pseq([1, 2, 3], 2) }), 
		Plazy({ "pattern2.asStream".postln; Pshuf([10, 20, 30, 40]) }), 
		Plazy({ "pattern3.asStream".postln; Pseq([100, 200, 300]) }),
		Plazy({  Pseries(1, 1, 4) * 0.01 })
	).asStream;
150.do({ x.next.postln });
)

// if the last pattern loops it the combinatorics loop there:
x = PstepNadd(Pseq([1, 2, 3]), Pseq([10, 20, 30, 40]), Pseq([100, 200, 300], inf)).asStream;
50.do({ x.next.postln });

// if the first pattern loops, the whole iteration loops as if it was used in a Pn(.., inf):
x = PstepNadd(Pseq([1, 2, 3], inf), Pseq([10, 20, 30, 40]), Pseq([100, 200, 300])).asStream;
y = Pn(PstepNadd(Pseq([1, 2, 3]), Pseq([10, 20, 30, 40]), Pseq([100, 200, 300])), inf).asStream;
150.do({ [x.next, y.next].postln });

// sound example
(
Pbind(
	\octave, 4,
	\degree, PstepNadd(
				Pseq([1, 2, 3]), 
				Pseq([0, -2, [1, 3], -5]), 
				Pshuf([1, 0, 3, 0], 2), 
				Pseq([1, -1], 5)
			),
	\dur, PstepNadd(
				Pseq([1, 0, 0, 1], 2),
				Pshuf([1, 1, 2, 1], 2)
		).loop * (1/8),
	\legato, Pn(Pshuf([0.2, 0.2, 0.2, 0.5, 0.5, 1.6, 1.4], 4), inf),
	\scale, #[0, 1, 3, 4, 5, 7, 8]
).play;
)








