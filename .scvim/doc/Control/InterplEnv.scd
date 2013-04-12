InterplEnv					envelope specification

superclass: Object

An InterplEnv is a specification for a segmented envelope. InterplEnvs can be used both server-side, by an IEnvGen within a SynthDef, and clientside, with methods such as at. An InterplEnv can have any number of segments. An InterplEnv can have several shapes for its segments.

Differences between InterplEnv and Env

InterplEnvs do not have release or loop nodes.  They are of a fixed duration. Mostly, it is meant to be used with IEnvGen, where 'times' are actually an index into the envelope shape.

Basic Creation

*new(levels, times, curves, offset = 0.0)

	Create a new envelope specification.
	levels - an array of levels. The first level is the initial value of the envelope.
	times - an array of durations of segments in seconds. There should be one fewer duration than there are levels.
	curve - this parameter determines the shape of the envelope segments.
	The possible values are:
		'step' - flat segments
		'linear' - linear segments, the default
		'exponential' - natural exponential growth and decay. In this case, the levels must all be nonzero
					and the have the same sign.
		'sine' - sinusoidal S shaped segments.
		'welch' - sinusoidal segments shaped like the sides of a Welch window.
		a Float - a curvature value for all segments.
		An Array of Floats - curvature values for each segments.
	offset - used to offset an envelope into negative starttimes. 

Instance Methods
		
plot(size)

	Plot this envelope's shape in a window.
	size - The size of the plot. The default is 400.
	
	
asArray

	Converts the Env to an Array in a specially ordered format. This allows for Env parameters to be settable arguments in a SynthDef. See example above under *newClear.
	
Client-side Access and Stream Support

at(time)

	Returns the value of the InterplEnv at time.
	
		InterplEnv([0, 1, 0.707], [0.2, 1.3], [\lin, \sin]).at(0.5);
				


