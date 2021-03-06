EventPatternProxy				event stream reference

superclass: TaskProxy



keeps a reference to a stream that can be replaced while playing.
Multiple streams are thus handled without creating dependancies.

related: Pdef


	*new(source)
		create a new instance with a pattern (the source).
		the pattern should be an event pattern (see Pdef)

	*default
		a default source, if none is given. the default is a Pbind with resting notes of 1.0 beat duration
		
	source_(obj)
		set the source (a pattern). If a quantization is given, schedule this change to the next beat
		(pattern_(..) is equivalent)
	
	clear	set the source to nil
	
	quant_(beats)
		set the quantization value. can be an array  [quant, phase, offset, outset]
	
	quant
		get the quantization value
	
	*defaultQuant_(beats)
		set the default quantization value for the class. (default: 1.0)

	
	fadeTime_(beats)
			when the synthdefs that are used contain an \amp control, the patterns are replaced
			by crossfading the previous with the new over this time (in beats)
	
	envir_(event)
			provide a default event for the Pdef. It is used to filter the incoming stream before it
			is  passed to the source pattern.  This is similar to NodeProxy-nodeMap.
			When set for the first time, the pattern is rebuilt.
	
	set(key, val, key2, val2, ...)
			set arguments in the default event. If there is none, it is created and the pattern is rebuilt.
			



a) using as stream reference
	

	asStream
			returns an instance of RefStream, which updates its stream as soon as the pattern
			is changed.
	
	embedInStream(inval)
			just like any pattern, embeds itself in stream
	
	
	
	
b) using as EventStreamPlayer


	play(clock, protoEvent, quant)
			starts the EventPatternProxy and creates a player. 
			if you want to play multiple instances, use .fork(clock, quant, protoEvent)
			quant can be an array of [quant, phase, offset, outset]
			
	stop
			stops the player
	
	player	
			the current player (if the Pdef is simply used in other streams this is nil)

	pause / resume / reset / mute / unmute
			perform player method 
			
	isPlaying 
			returns true if Pdef is running.
			if a Pdef is playing and its stream ends, it will schedule a stream for playing 
			as soon as a new one is assigned to it.
		
	




a) embedding EventPatternProxy in streams:



(
SynthDef("Pdefhelp", { arg out, freq, sustain=1, amp=1, pan;
	var env, u=1;
	env = EnvGen.kr(Env.perc(0.03, sustain), 1, doneAction:2);
	5.do { var d; d = exprand(0.01, 1); u = SinOsc.ar(d * 300, u, rrand(0.1,1.2) * d, 1) };
	Out.ar(out, Pan2.ar(SinOsc.ar(u + 1 * freq, 0, amp * env), pan));

}).store;
)
s.boot;

#a, b, c, m = { EventPatternProxy.new } ! 4;

m.play;
m.source = Pbind(\instrument, \Pdefhelp, \dur, 1, \degree, 16, \legato, 0.1);

a.source = Pbind(\instrument, \Pdefhelp, \dur, 0.25, \degree, Pseq(#[0, 5, 4, 3]));
b.source = Pbind(\instrument, \Pdefhelp, \dur, 0.125, \degree, Pseq(#[7, 8, 7, 8]));
c.source = Pbind(\instrument, \Pdefhelp, \dur, 0.25, \degree, Pseq(#[0, 1, 2], 2));

x = Pseq([a, b, c], inf).play;


c.source = Pbind(\instrument, \Pdefhelp, \dur, 0.25, \degree, Pseq(#[4, 3, 1, 2]*3));


// infinite loops are scheduled (to ths clock's next beat by default) and released:

a.source = Pbind(\instrument, \Pdefhelp, \dur, 0.753, \degree, Pseq(#[0, 5, 4, 3, 2], inf));
a.source = Pbind(\instrument, \Pdefhelp, \dur, 0.125, \degree, Pseq(#[0, 5, 4, 3] + 1, 1));
a.source = Pbind(\instrument, \Pdefhelp, \dur, 0.25, \degree, Pseq(#[0, 5, 4, 3] - 1, 1));

a.source = Pbind(\instrument, \Pdefhelp, \dur, 0.125, \degree, Pseq(#[0, 5] - 1, 1));
a.source = Pbind(\instrument, \Pdefhelp, \dur, 0.753, \degree, Pshuf(#[0, 5, 4, 3, 2], inf));

x.stop;
m.stop;

// EventPatternProxy can be used in multiple patterns

(
x = Ppar([
	Pbindf(Pn(a, inf),
		\gtranspose, Pstutter(8, Pseq(#[0, 2, 0, 3],inf))
	),
	Pbindf(Pn(a, inf),
		\gtranspose, Pstutter(8, Pseq(#[7, 4, 0, 3],inf)), 
		\dur, 0.6
	),
	Pbindf(Pn(a, inf),
		\degree, Pseq(#[0, 5, 4, 3, 2, 3, 2], 1)
	)
]).play;
)

a.source = Pbind(\instrument, \Pdefhelp, \dur, 0.1, \degree, Pseq(#[0, 1, 0, 1, 2], inf));

a.source = Pbind(\instrument, \Pdefhelp, \dur, 0.2, \degree, Pseq([0, 4], inf));

a.source = Pbind(\instrument, \Pdefhelp, \dur, 0.2, \degree, Pseq([0, 4, Prand([6, 8b],2)], inf));

a.source = Pbind(\instrument, \Pdefhelp, \dur, 0.1, \degree, Pseq(#[0, 1b, 1, 2b, 2, 3, 4b, 4, 5], inf));

a.set(\detune, -50); // set environment
a.set(\detune, 0);

x.stop;




b) playing EventPatternProxy

		
(
// load a synthdef
s.boot;
SynthDef("gpdef", 
	{ arg out=0, freq=440, sustain=0.05, amp=0.1, pan;
		var env;
		env = EnvGen.kr(Env.perc(0.01, sustain), doneAction:2) * amp;
		Out.ar(out, Pan2.ar(SinOsc.ar(freq, 0, env), pan))
	}).store;
)


#x, y = {EventPatternProxy.new} ! 2;

x.play; // play them. A silent resting pattern is used.
y.play; 


// assign various patterns to it:

x.source = Pbind(\dur, 0.25, \instrument, \gpdef); 
x.source = Pbind(\dur, 0.25, \degree, Pseq([3, 4, 5b, 6], inf), \instrument, \gpdef);
x.source = Pbind(\dur, 0.25, \degree, Pseq([3, 4, 5b, 6]+1, inf), \instrument, \gpdef);
y.source = Pbind(\dur, 0.25, \degree, Pseq([3, 4, 5b, 6]-1, inf), \instrument, \gpdef);
y.source = Pbind(\dur, 0.25, \degree, Pseq([3, 4, 5b]-2, inf), \instrument, \gpdef);

// using fadeTime:

y.fadeTime = 8.0;
y.source = Pbind(\dur, 0.125, \degree, Pseq([3, 4, 5b, 6]+4.rand, inf), \instrument, \gpdef);
y.source = Pbind(\dur, 0.25, \degree, Pseq([3, 4, 5b, 6]-2, inf), \instrument, \gpdef);

(
x.source = Pbind(
		\dur, 1 / 6, 
		\degree, Pseq([3, 4, Prand([8, 2, 3, 9, 10],1) - 5, 6]+1, inf), 
		\instrument, \gpdef
		)
	);
)
(
x.source = Pbind(
		\dur, 0.25, 
		\degree, Pseq([3, 4, Prand([8, 2, 3, 9, 10],1), 6], inf), 
		\instrument, \gpdef)
	);
)
x.stop;



// tempo change
TempoClock.default.tempo = 1.3;
y.source = Pbind(\dur, 0.25, \degree, Pseq([3, 4, 5, 6]+1, inf), \instrument, \gpdef);

// drop in ending patterns

x.play;
x.fadeTime = nil;

x.source = Pbind(\dur, 0.25, \degree, Pseq([3, [7,4], 5, 6]-2), \instrument, \gpdef);
x.source = Pbind(\dur, 0.125, \degree, Pseq([3, [7,4], 5, 4]-3), \instrument, \gpdef);
x.source = Pbind(\dur, 0.35, \degree, Pseq([3, [7,4], 5, 4, 3]-3), \instrument, \gpdef);
x.source = Pbind(\dur, 0.25, \degree, Pshuf([3, [7,4], 5, 6]-2), \instrument, \gpdef);



TempoClock.default.tempo = 1.0;
x.stop;
y.stop;




