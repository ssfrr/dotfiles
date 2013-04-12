Pseg				timed embedding of values

superclass: Pstep

Pseg(levelpattern, durpattern, curvepattern, repeats)

Pseg defines a function of time as a breakpoint envelope using the same parameters as Env.  These patterns 
can be used to describe tempo or dynamic variations independent of the rhythmic patterns that express them.

	levelpattern - The first level is the initial value of the envelope, all subsequent values are interpolated
	If durpattern is nil, then levelpattern specifies the entire envelope by returning arrays of the form: 
		[level, dur, curve]
	durpattern - duration of segments in seconds. 
	curvepattern - this parameter determines the shape of the envelope segments.
	The possible values are:
		'step' - flat segments
		'linear' - linear segments, the default
		'exponential' - natural exponential growth and decay. In this case, the levels must all be nonzero
					and the have the same sign.
		'sine' - sinusoidal S shaped segments.
		'welch' - sinusoidal segments shaped like the sides of a Welch window.
		a Float - a curvature value for all segments.
		An Array of Floats - curvature values for each segments.

 

// change a parameter
(
Pbind(
	\note,  Pseg( Pseq([1, 5],inf), Pseq([4, 1],inf), \linear),
	\dur, 0.1
).play;
)

(
Pbind(
	\freq,  Pseg( Pseq([400, 1500], inf), Pseq([4, 4],inf), Pseq([\linear, \exp],inf)),
	\dur, 0.1
).play;
)






