Pdef				stream reference definition

Inherits from:  Object : AbstractFunction : Pattern : PatternProxy : TaskProxy : EventPatternProxy

Pdef is a class that provides an interface to its superclass EventPatternProxy, keeping a reference to a stream that can be replaced while playing. One pattern may be used in many streams in different places. A change in the pattern definition propagates through all streams.

Pdef(key) returns the instance 
Pdef(key, pat) stores the pattern and returns the instance, like Tdef and Ndef.

It can be used to store event Patterns globally. Changes in this global library have immediate effect.

For non-event patterns Pdefn is used instead.
For another use of Pdef see also recursive_phrasing
Graphical overview over all current Pdefs: PdefAllGui
Overview: JITLib


First Example

	s.boot;
	
	Pdef(\x, Pbind(\note, Pbrown(0, 6, 0.1, inf)));
	Pdef(\x).quant = 0; // no waiting.
	Pbindf(Pdef(\x), \dur, 0.03).play;
	Pbindf(Pdef(\x), \dur, 0.1, \ctranspose, 15).play;
	Pbindf(Pdef(\x), \dur, 0.3, \ctranspose, 2).play;
	// now change the definition
	Pdef(\x, Pbind(\note, Pseq([0, 3, 5, 7, 9, 11], inf)));
	Pdef(\x, Pbind(\freq, Pseq([1000, 1923, 245.2, 1718] / 1.2 + 0.1, inf)));
	


Creation / Class Methods

	*new(key, pattern)
		Store the pattern in a global dictionary under key, replacing its pattern with the new one.
		If the pattern is a function, Pdef creates a PlazyEnvir internall that dynamically creates the pattern returned from the function, applying the arguments from the inevent.
			
	*new(key)
		Access the pattern at that key (if none is given, a default silent event is created)
	
	*default
		Default source, if none is given. The default is an Event.silent of 1.0 beat duration.
		
	*removeAll
		Remove all proxies from the global dictionary (*all)
	
	*clear
		Clear all proxies, setting their source to silence.
	
	*all
	*all_(envir)
		Set or return the environment (IdentityDictionary) that stores all Pdefs.
			

	
Changing the definition / setting the source
One pattern may have many streams in different places. A change in the pattern definition Pdef propagates through all streams. The change does not have to be immediate - there is a scheme to schedule when the change becomes effective: a quant and clock (like elsewhere) and a condition.

			
	quant_(beats)
		Set the quantisation time for beat accurate scheduling. 
		quant can be an array [quant, phase, timingOffset, outset], or just [quant, phase] etc.
	
	*defaultQuant_(beats)
		Set the default quantisation for new instances (default: 1.0)
		This can be an array  [quant, phase, timingOffset, outset]
	
	condition_(func)
		Provide a condition under which the pattern is switched when a new one is inserted.
		The stream value and a count value is passed into the function.
		
	count(n)
		Create and update condition that simply counts up to n and switches the pattern then

	reset		
		Switch the pattern immediately (stuck conditions can be subverted by this).

	fadeTime_(beats)
		When the synthdefs that are used contain an \amp control, the patterns are replaced by crossfading the previous with the new over this time (in beats)
			
	envir_(event)
		Set the event for the Pdef. It is used to filter the incoming stream before it is  passed to the source pattern.  This is similar to NodeProxy-nodeMap. When set for the first time, the pattern is rebuilt.
	
	set(key, val, key2, val2, ...)
		Set arguments in the default event. If there is none, it is created and the pattern is rebuilt.
	
	map(key, pdefKey, key, pdefKey ...)
		Map Pdefn to the keys in the event.
	
	clear
		Set the source to nil
				
	endless
		Returns a Prout that plays the proxy endlessly, replacing nil with a default value (silent event). This allows to create streams that idle on until a new pattern is inserted.

			
			

Pdef as stream reference
A single Pdef may serve as a definition for multiple streams. These methods show how to fork off separate streams from one instance. Even if they run in different contexts, their definition may still be changed.	
	
	fork(clock, quant, event)
		Play an independent stream in parallel.
			quant can be an array of [quant, phase, offset], or a Quant value.
			
	embed(val)	
		Pass a value (typically an event) into the pattern inval, and embed the Pdef in the stream.
			
	embedInStream(inval)
		just like any pattern, embeds itself in stream
	


Pdef as EventStreamPlayer
For live coding, each Pdef also may control one instance that plays one stream off it. This is an EventStreamPlayer, accessible in the instance variable player.

	play(clock, protoEvent, quant)
		Starts the Pdef and creates a player. 
		quant can be an array of [quant, phase, offset] or a Quant value.
			
	stop
		Stops the player
	
	player	
		Return the current player (if the Pdef is simply used in other streams this is nil)

	pause / resume / reset / mute / unmute
		Perform this method on the player.
			
	isPlaying 
		Returns true if player is running. If a Pdef is playing and its stream ends, it will schedule a stream for playing as soon as a new one is assigned to it. If it is stopped by stop, it won't.
		
		
	


Example: Pdef as stream reference



(
SynthDef("Pdefhelp", { arg out, freq, sustain=1, amp=1, pan;
	var env, u=1;
	env = EnvGen.kr(Env.perc(0.03, sustain), 1, doneAction:2);
	3.do { var d; d = exprand(0.01, 1); u = SinOsc.ar(d * 300, u, rrand(0.1,1.2) * d, 1) };
	Out.ar(out, Pan2.ar(SinOsc.ar(u + 1 * freq, 0, amp * env), pan));

}).store;
)
s.boot;

Pdef(\metronom, Pbind(\instrument, \Pdefhelp, \dur, 1, \degree, 16, \legato, 0.1)).play;

x = Pseq([Pdef(\a), Pdef(\b), Pdef(\c)], inf).play;

Pdef(\a, Pbind(\instrument, \Pdefhelp, \dur, 0.25, \degree, Pseq(#[0, 5, 4, 3])));
Pdef(\b, Pbind(\instrument, \Pdefhelp, \dur, 0.125, \degree, Pseq(#[7, 8, 7, 8])));
Pdef(\c, Pbind(\instrument, \Pdefhelp, \dur, 0.25, \degree, Pseq(#[0, 1, 2], 2)));




Pdef(\c, Pbind(\instrument, \Pdefhelp, \dur, 0.25, \degree, Pseq(#[4, 3, 1, 2]*3)));


// infinite loops are scheduled (to ths clock's next beat by default) and released:

Pdef(\a, Pbind(\instrument, \Pdefhelp, \dur, 0.753, \degree, Pseq(#[0, 5, 4, 3, 2], inf)));
Pdef(\a, Pbind(\instrument, \Pdefhelp, \dur, 0.125, \degree, Pseq(#[0, 5, 4, 3] + 1, 1)));
Pdef(\a, Pbind(\instrument, \Pdefhelp, \dur, 0.25, \degree, Pseq(#[0, 5, 4, 3] - 4, 1)));

Pdef(\a, Pbind(\instrument, \Pdefhelp, \dur, 0.125, \degree, Pseq(#[0, 5] - 1, 1)));
Pdef(\a, Pbind(\instrument, \Pdefhelp, \dur, 0.753, \degree, Pshuf(#[0, 5, 4, 3, 2], inf)));

x.stop;
Pdef(\metronom).stop;

// Pdef can be used in multiple patterns:

(
x = Ppar([
	Pbindf(Pn(Pdef(\a), inf),
		\gtranspose, Pstutter(8, Pseq(#[0, 2, 0, 3],inf))
	),
	Pbindf(Pn(Pdef(\a), inf),
		\gtranspose, Pstutter(8, Pseq(#[7, 4, 0, 3],inf)), 
		\dur, 0.6
	),
	Pbindf(Pn(Pdef(\a), inf),
		\degree, Pseq(#[0, 5, 4, 3, 2, 3, 2], 1)
	)
]).play;
)

Pdef(\a, Pbind(\instrument, \Pdefhelp, \dur, 0.1, \degree, Pseq(#[0, 1, 0, 1, 2], inf)));

Pdef(\a, Pbind(\instrument, \Pdefhelp, \dur, 0.2, \degree, Pseq([0, 4], inf)));

Pdef(\a, Pbind(\instrument, \Pdefhelp, \dur, 1, \degree, Pseq([0, 4], inf)));

Pdef(\a, Pbind(\instrument, \Pdefhelp, \dur, 0.2, \degree, Pseq([0, 4, Prand([6, 8b],2)], inf)));

Pdef(\a, Pbind(\instrument, \Pdefhelp, \dur, 0.1, \degree, Pseq(#[0, 1b, 1, 2b, 2, 3, 4b, 4, 5], inf)));

// using a fade time, the above changes are crossfaded
Pdef(\a).fadeTime = 2;

Pdef(\a, Pbind(\instrument, \Pdefhelp, \dur, 0.2, \degree, Pseq([0, 4, Prand([6, 8b],2)], inf)));

// ...

Pdef(\a).set(\detune, -50); // set environment
Pdef(\a).set(\detune, 0);

x.stop;


Example: Pdef as EventStreamPlayer

		
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


Pdef(\x); // creates a Pdef with a default pattern.


Pdef(\x).play; // play it. A silent resting pattern is used.
Pdef(\y).play; // play a second one (automatically instantiated)


// assign various patterns to it:

Pdef(\x, Pbind(\dur, 0.25, \instrument, \gpdef)); 
Pdef(\x, Pbind(\dur, 0.25, \degree, Pseq([3, 4, 5b, 6], inf), \instrument, \gpdef));
Pdef(\x, Pbind(\dur, 0.25, \degree, Pseq([3, 4, 5b, 6]+1, inf), \instrument, \gpdef));
Pdef(\y, Pbind(\dur, 0.25, \degree, Pseq([3, 4, 5b, 6]-1, inf), \instrument, \gpdef));
Pdef(\y, Pbind(\dur, 0.25, \degree, Pseq([3, 4, 5b]-2, inf), \instrument, \gpdef));

// using fadeTime:

Pdef(\y).fadeTime = 8.0;
Pdef(\y, Pbind(\dur, 0.125, \degree, Pseq([3, 4, 5b, 6]+4.rand, inf), \instrument, \gpdef));
Pdef(\y, Pbind(\dur, 0.25, \degree, Pseq([3, 4, 5b, 6]-2, inf), \instrument, \gpdef));

(
Pdef(\x, Pbind(
		\dur, 1 / 6, 
		\degree, Pseq([3, 4, Prand([8, 2, 3, 9, 10],1) - 5, 6]+1, inf), 
		\instrument, \gpdef
		)
	);
)
(
Pdef(\x, Pbind(
		\dur, 0.25, 
		\degree, Pseq([3, 4, Prand([8, 2, 3, 9, 10],1), 6], inf), 
		\instrument, \gpdef)
	);
)
Pdef(\x).stop;

Pdef(\x).play;

// tempo change
TempoClock.default.tempo = 1.3;
Pdef(\y, Pbind(\dur, 0.25, \degree, Pseq([3, 4, 5, 6]+1, inf), \instrument, \gpdef));

// drop in ending patterns

Pdef(\x, Pbind(\dur, 0.25, \degree, Pseq([3, [7,4], 5, 6]-2), \instrument, \gpdef));
Pdef(\x, Pbind(\dur, 0.125, \degree, Pseq([3, [7,4], 5, 4]-3), \instrument, \gpdef));
Pdef(\x, Pbind(\dur, 0.35, \degree, Pseq([3, [7,4], 5, 4, 3]-3), \instrument, \gpdef));
Pdef(\x, Pbind(\dur, 0.25, \degree, Pshuf([3, [7,4], 5, 6]-2), \instrument, \gpdef));


// clear all.
Pdef(\x).clear; 
Pdef(\y).clear; 
TempoClock.default.tempo = 1.0;


// GUI example: see also 
PdefAllGui(18);



Example: Recursion

Pdefs can be used recursively under the condition that the stream call structure allows it.
a structure like the following works:


Pdef(\x, Pseq([Pbind(\instrument, \gpdef), Pdef(\x)], inf)); 
Pdef(\x).play;

but the following would crash, because .embedInStream is called recursively with no limit:

// Pdef(\y, Pseq([Pdef(\y), Pbind(\instrument, \gpdef)], inf));


Example: Quantizing and outset

When quantizing to a larger number of beats, the changes become very slow if one has to wait for the next beat. Providing an outset quant value is a way to make the change so that it appears as if it had been done at the previous grid point already. The stream is fast forwarded to the current position relative to the quant grid.
Providing a number larger than zero, the next possible quant point is used as outset.

For example, if quant is 32, and one has just missed the first beat when changing the pattern,
one has to wait for 32 beats until the change happens. Using an outset of 1, it is assumed that you had already
changed the pattern at the first beat, the stream is fast forwarded to the time it would be at now if you had done so. The new pattern is inserted at the next beat (outset=1).

quant can be: [quant, phase, timingOffset, outset]

Note: This fast forwarding might create a cpu peak if the pattern is very complex/fast or
quant is very long. This is hard to avoid, so it simply has to be taken into account.


// examples
(
Pdef(\x).quant_([8, 0, 0, 1]);
Pdef(\y).quant_([8, 0.5, 0, 1]); // phase: half a beat
Pdef(\x).play;
Pdef(\y).play;
)

Pdef(\x, Pbind(\degree, Pseq((0..7)+2, inf)));
Pdef(\y, Pbind(\degree, Pseq((0..7)-2, inf)));
Pdef(\x, Pbind(\degree, Pseq((0..7)+2, inf), \dur, 0.5));
Pdef(\y, Pbind(\degree, Pseq((0..7).scramble-2, inf), \dur, 0.25, \legato, 0.3));
Pdef(\x, Pbind(\degree, Pseq((0..7), inf)));

Pdef(\x, Pbind(\degree, Pseq([ 1, 5, 6, 7, 0, 3, 2, 4 ], inf), \dur, 1));
Pdef(\x, Pbind(\degree, Pseq([ 0, 2, 2, 4, 0, 4, 0, 4 ], inf), \dur, 1));

Pdef(\x).quant_([8, 1/3, 0, 1]); // phase: 1/6 beat relative to y
Pdef(\x, Pbind(\degree, Pseq([ 1, 1, 1, 7, 0, 2, 2, 4 ], inf), \legato, 0.1));
Pdef(\x, Pbind(\degree, Pseq([ 3, 3, 3, 4b ], inf), \legato, 0.1));
Pdef(\y, Pbind(\degree, Pseq((0..7).scramble-4, inf), \dur, 0.25, \legato, 0.3));




// some testing
(
var quant = #[8, 0, 0, 1]; // quantise to 8 beats, no phase, insert quant to 1 beat
Pdef(\x).quant_(quant);
Pdef(\x).play;
Routine { loop { 8.do { |i| ("uhr:"+i).postln; 1.wait } } }.play(quant:quant);
Pbind(\degree, Pseq((0..7), inf)).play(quant:quant);
)

Pdef(\x, Pbind(\degree, Pseq((0..7)+2, inf)).trace(\degree));
Pdef(\x, Pbind(\degree, Pseq((0..7), inf) + [0, 3]).trace(\degree));
Pdef(\x, Pbind(\degree, Pseq((0..7), inf) + [0, 6], \dur, 0.5).trace(\degree));


Pdef(\x).fadeTime = 8;

Pdef(\x, Pbind(\degree, Pseq((0..7), inf)).trace(\degree));
Pdef(\x, Pbind(\degree, Pseq((0..7).reverse, inf) + [0, 6], \dur, 0.5));

Pdef(\x).fadeTime = nil;
Pdef(\x).quant = 1;

Pdef(\x, Pbind(\degree, Pseq((0..7), inf)).trace(\degree));

Pdef(\x).quant = 8;
Pdef(\x, Pbind(\degree, Pseq((0..7), inf)).trace(\degree));



Example: Update condition

In order to be able to switch to a new pattern under a certain condition, the instance variable
condition can be set to a function that returns a boolean. Value and a count index are passed to the function.
The condition is always valid for the next pattern inserted. For stuck conditions, the reset message can be used.

As counting up (such as "every nth event, a swap can happen") is a common task, there is a method for this,
called count(n).


Pdef(\x).play;
Pdef(\x).quant = 0; // we don't want quant here.
Pdef(\x, Pbind(\degree, Pseq((0..5), inf), \dur, 0.3)).condition_({ |val, i| i.postln % 6 == 0 });
Pdef(\x, Pbind(\degree, Pseq((0..7) + 5.rand, inf), \dur, 0.3)).condition_({ |val, i| (i % 8).postln == 0 });

// the above is equivalent to:
Pdef(\x, Pbind(\degree, Pseq((0..7) + 5.rand, inf), \dur, 0.3)).count(8);

// the value that is sent in is the event, so decisions can be made dependent on the event's fields



reset
 
// reset to change immediately:
Pdef(\x).reset;









