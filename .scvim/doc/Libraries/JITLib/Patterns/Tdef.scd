Tdef				task reference definition

Inherits from:  Object : AbstractFunction : Pattern : PatternProxy : TaskProxy


Pdefn provides an interface to its superclass TaskProxy.Tdef keeps a reference to a task (time pattern) that can be replaced while playing. It continues playing when the old stream ended and a new stream is set and schedules the changes to the beat. One Tdef may be used in many tasks in different places. A change in the task definition Tdef propagates through all tasks.

Tdef(key) returns the instance
Tdef(key, func) defines the task and returns the instance, like Pdef and Ndef.

See also: TaskProxy, Task, Routine
Graphical overview over all current Tdefs: TdefAllGui.
Overview: JITLib


First Example

	Tdef(\x, { loop { 0.5.wait; "aaaaaaaaaaaaaazz".scramble.postln } }).play;
	Tdef(\x, { loop { 0.125.wait; "aazz".scramble.postln } });
	Tdef(\x, { loop { 0.5.wait; (note: 14.rand).play } });
	Tdef(\x, { loop { 0.5.wait; (note: 14.rand + [0, 3, 6, 7].keep(4.rand)).play } });
	Tdef(\x).stop;
	Tdef(\x).play;
	Tdef(\x).clear;
	

	
Creation / Class Methods

	*new(key, func)
		Store the task in a global dictionary under key, replacing its routine function with the new one.
					
	*new(key)
		Access the pattern at that key (if none is given, a default task is created)
	
	*default
		Default source, if none is given. The default task has a function that waits in 1.0 beat steps and does nothing.
		
	*removeAll
		Remove all proxies from the global dictionary (*all)
	
	*clear
		Clear all proxies, setting their source to silence.
	
	*all
	*all_(envir)
		Set or return the environment (IdentityDictionary) that stores all instances.
		
		
Changing the definition / setting the source
One Tdef may have many tasks in different places. A change in the task definition Tdef propagates through all tasks. The change does not have to be immediate - there is a scheme to schedule when the change becomes effective: a quant and clock (like elsewhere) and a condition.
			
				
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
		Switch the task immediately (stuck conditions can be subverted by this).
			
	envir_(event)
		Set the environment (an event) for the Tdef. It is passed as first argument into the Task function.
	
	set(key, val, key2, val2, ...)
		Set arguments in the default event. If there is none, it is created and the task routine is rebuilt.
	
	clear
		Set the source to nil
				
	endless
		Returns a Prout that plays the task endlessly, replacing nil with a default value 1. This allows to create streams that idle on until a new pattern is inserted.




Tdef as stream reference
A single Tdef may serve as a definition for multiple tasks. These methods show how to fork off separate routines from one instance. Even if they run in different contexts, their definition may still be changed.
	
	
	fork(clock, quant, event)
		Play an independent task in parallel.
			quant can be an array of [quant, phase, offset], or a Quant value.
			
	embed(val)	
		Pass a value (typically an event) into the task function, and embed the Tdef in the stream.
			
	embedInStream(inval)
		just like any pattern, embeds itself in stream
	

	
Tdef as EventStreamPlayer
For live coding, each Tdef also may control one instance that plays one task. This is a PauseStream, accessible in the instance variable player.

	
	play(clock, protoEvent, quant)
		Starts the Tdef and creates a player. 
		quant can be an array of [quant, phase, offset] or a Quant value.
			
	stop
		Stops the player
	
	player	
		Return the current player (if the Tdef is simply used in other streams this is nil)

	pause / resume / reset / mute / unmute
		Perform this method on the player.
			
	isPlaying 
		Returns true if player is running. If a Tdef is playing and its stream ends, it will schedule a stream for playing as soon as a new one is assigned to it. If it is stopped by stop, it won't.
		




Example: Tdef as a Task player


Tdef(\x).play; // create an empty Tdef and play it.

Tdef(\x, { loop({ "ggggggggggggggggg9999ggg999ggg999gg".scramble.postln; 0.5.wait; }) });


Tdef(\x, { loop({ "---------////----------------------".scramble.postln; 0.25.wait; }) });
Tdef(\x, { loop({ thisThread.seconds.postln; 1.wait; }) });
Tdef(\x, { loop({ thisThread.seconds.postln; 1.01.wait; }) });

TempoClock.default.tempo = 2;

Tdef(\x, { "the end".postln });
Tdef(\x, { "one more".postln });
Tdef(\x, { 10.do({ "ten more".scramble.postln; 0.25.wait; }) });
Tdef(\x, { loop({ "lots more".scramble.postln; 0.25.wait; }) });

TempoClock.default.tempo = 1;

Tdef(\x).stop;
Tdef(\x).play;

Tdef(\x).clear;


// sound example

(
// load a synthdef
s.boot;
SynthDef(\pdef_grainlet, 
	{ arg out=0, freq=440, sustain=0.05;
		var env;
		env = EnvGen.kr(Env.perc(0.01, sustain, 0.3), doneAction:2);
		Out.ar(out, SinOsc.ar(freq, 0, env))
	}).add;
)
Tdef(\x).play;

(
Tdef(\x, { 
	loop({
		s.sendMsg("/s_new", "pdef_grainlet", -1,0,0, \freq, rrand(600, 640));
		0.1.wait;
	})
})
)

(
Tdef(\x, { 
	var x;
	x = Pseries(300, 20, 100).loop.asStream;
	loop({
		s.sendMsg("/s_new", "pdef_grainlet", -1,0,0, \freq, x.next);
		0.05.wait;
	})
})
)

(
Tdef(\x, { 
	var x;
	x = Plazy({ Pseries(300 + 300.rand, 10 + 30.rand, 10 + 30.rand) }).loop.asStream;
	loop({
		s.sendMsg("/s_new", "pdef_grainlet", -1,0,0, \freq, x.next);
		0.05.wait;
	})
})
)

// metronome
Tdef(\y, { loop({ s.sendMsg("/s_new", "pdef_grainlet", -1,0,0, \freq, 1500); 1.wait; }) }).play;

// play ending stream once
(
Tdef(\x, { 
	var x, dt;
	dt = [0.1, 0.125, 0.05].choose;
	x = Plazy({ Pseries(1300 + 300.rand, 110 + 130.rand, 16) }).asStream;
	x.do({ arg item;
		s.sendMsg("/s_new", "pdef_grainlet", -1,0,0, \freq, item);
		dt.wait;
	})
})
)

// ... and so on ...

Tdef(\x).stop;
Tdef.removeAll;



Embed and fork: Tdef within other Tasks / Routines.


// embed plays tdefs in sequence within a task.
(
Tdef(\a, { "one".postln; 1.wait; "two".postln });
Tdef(\c, { var z; z = Synth(\default); 0.5.wait; z.release });
r = Task({
	"counting...".postln;
	2.wait;
	Tdef(\a).embed;
	1.wait;
	Tdef(\c).embed;
	"done.".postln;
});
)

r.play; // play a stream

Tdef(\c, { var z; z = Synth(\default, [\freq, 300]); 1.5.wait; z.release }); // change the def

r.reset;
r.play;

// of course Tdefs can be used in other Tdefs:
(
Tdef(\a, { 10.do { |i| (" a: " + i).postln; 0.3.wait; } });
Tdef(\b, { 15.do { |i| ("\t\t b: " + i).postln; 0.2.wait; } });
Tdef(\c, { 5.do { |i| ("\t\t\t\t c: " + i).postln; 0.5.wait; } });

Tdef(\d, {
	"embed - sequence.".postln;
	1.wait;
	Tdef(\a).embed;
	1.wait;
	Tdef(\b).embed;
	1.wait; 
	Tdef(\c).embed;
	
	"done.".postln;
});
)
Tdef(\d).play;

// to start a tdef in its own separate thread, thus branching into parallel threads, 
// one can use .fork, or .playOnce
(
Tdef(\a, { 10.do { |i| (" a: " + i).postln; 0.3.wait; } });
Tdef(\b, { 15.do { |i| ("\t\t b: " + i).postln; 0.2.wait; } });
Tdef(\c, { 5.do { |i| ("\t\t\t\t c: " + i).postln; 0.5.wait; } });

Tdef(\d, {
	"fork - parallel.".postln;
	1.wait;
	Tdef(\a).fork;
	1.wait;
	Tdef(\b).fork;
	1.wait; 
	Tdef(\c).fork;
	
	"done.".postln;
});
)






Tdef as a time pattern
Instead of using a Pdefn for time values, it can be useful to use a Tdef. When changing its source, it keeps the stream of values synchronized to its clock.


(
// load a synthdef
s.boot;
SynthDef("pdef_grainlet", 
	{ arg out=0, freq=440, sustain=0.05;
		var env;
		env = EnvGen.kr(Env.perc(0.01, sustain, 0.3), doneAction:2);
		Out.ar(out, SinOsc.ar(freq, 0, env))
	}).store;
)




Tdef(\z, Pseq([1, 1, 1, 0.5, 0.5], inf));

(
	Pset(\instrument, \pdef_grainlet, 
		Ppar([
			Pbind(
				\dur, Tdef(\z),
				\note, Pseq([1, 3, 2, 1, 0], inf),
				\x, Pfunc { TempoClock.default.elapsedBeats.postln } // posts the onset times
			),
			Pbind(
				\dur, 4, // reference beat
				\sustain, 0.1,
				\note, 8
			)
		])
	).play(quant:1);
)


Tdef(\z, Prand([1, 1, 0.23, 0.5, 0.5], inf)); // exchange time pattern
Tdef(\z, Pseq([1, 1, 1, 1], inf)); // pattern stays in sync.
Tdef(\z, Pseq([1, 1, 1, 0.5, 0.5], inf)); // but might be in different order.
									// to avoid this, set quant to an appropriate value.




