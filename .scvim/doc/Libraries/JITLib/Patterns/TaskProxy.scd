TaskProxy				event stream reference

superclass: PatternProxy

Keeps a reference to a task (time pattern) that can be replaced while playing.
It plays on when the old stream ended and a new stream is set and schedules the changes to the beat.


related: Tdef


	*new(source)
		create a new instance with a function (the source).
		the source should be a routine function (see Tdef) or a pattern of time values.

	*default
		a default source, if none is given. the default is a loop that does nothing with a 1.0 beat wait time
		
	
	source_(obj)
		set the source. If a quantization is given, schedule this change to the next beat
		the object is a routine function, which is evaluated in a protected way, so that
		failure will notify the proxy that it has stopped. 
		The object can also be a pattern of time values.

	clear	set the source to nil
	
	quant_(beats)
		set the quantization value. can be a pair [quant, offset]
	
	quant
		get the quantization value
	
	*defaultQuant_(beats)
		set the default quantization value for the class. (default: 1.0)
		can be a pair [quant, offset]
	
	condition_(func)
			provide a condition under which the pattern is switched when a new one is inserted.
			the stream value and a count is passed into the function.
			the methods count_(n) simply counts up to n and switches the pattern then
	
	reset		
			switch the pattern immediately. (stuck conditions can be subverted by this)
			
	envir_(event)
			provide a default environment for the proxy. 
			If given,  it is used as an environment for the routine 
			function. When set for the first time, the routine pattern is rebuilt.
	
	set(key, val, key2, val2, ...)
			set arguments in the environment. 
			If there is none, it is created and the routine pattern is rebuilt.
	
	endless
			returns a Proutine that plays the proxy endlessly, replacing nil with a default
			value (1 s. wait time). This allows to create streams that idle on until a new pattern is inserted.
		

			

a) using it as stream reference
	
	source_	
			set the routine function / pattern (internally done by *new(key, obj)
			
	
	embedInStream(inval)
			just like any stream, embeds itself in stream
	
	
	
b) using it as EventStreamPlayer

	play(clock, protoEvent, quant)
			starts the TaskProxy and creates a player. 
			if you want to play multiple instances, use .playOnce(clock, protoEvent, quant)
			quant can be an array of [quant, phase]
			
	stop
			stops the player
	
	player	
			the current player (if the TaskProxy is simply used in other streams this is nil)

	pause / resume / reset / mute / unmute
			perform player method 
			
	isPlaying 
			returns true if TaskProxy is running.
			if a TaskProxy is playing and its stream ends, it will schedule a stream for playing 
			as soon as a new one is assigned to it.
		
	




a) using TaskProxy as a player


// create an empty Tdef and play it.
x = TaskProxy.new;
x.play; 


x.source =  { loop { "ggggggggggggggggg9999ggg999ggg999gg".scramble.postln; 0.5.wait; } };


x.source = { loop { "---------////----------------------".scramble.postln; 0.25.wait; } };
x.source = { loop { thisThread.seconds.postln; 1.wait; } };
x.source = { loop { thisThread.seconds.postln; 1.01.wait; } };

TempoClock.default.tempo = 2;

x.source = { "the end".postln };
x.source = { "one more".postln };
x.source = { 10.do { "ten more".scramble.postln; 0.25.wait; } };
x.source = { loop { "many more".scramble.postln; 0.25.wait; } };

TempoClock.default.tempo = 1;

x.stop;
x.play;
x.stop;




// sound example

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
x.play;

(
x.source = { 
	loop {
		s.sendMsg("/s_new", "pdef_grainlet", -1,0,0, \freq, rrand(600, 640));
		0.1.wait;
	}
}
)

(
x.source = { 
	var x;
	x = Pseries(300, 20, 100).loop.asStream;
	loop {
		s.sendMsg("/s_new", "pdef_grainlet", -1,0,0, \freq, x.next);
		0.05.wait;
	}
}
)

(
x.source = { 
	var x;
	x = Plazy { Pseries(300 + 300.rand, 10 + 30.rand, 10 + 30.rand) }.loop.asStream;
	loop {
		s.sendMsg("/s_new", "pdef_grainlet", -1,0,0, \freq, x.next);
		0.05.wait;
	}
}
)

// metronome
(
y = TaskProxy { 
	loop { s.sendMsg("/s_new", "pdef_grainlet", -1,0,0, \freq, 1500); 1.wait; } 
};
y.play;
)

// play ending stream once
(
x.source = { 
	var x, dt;
	dt = [0.1, 0.125, 0.05].choose;
	x = Plazy { Pseries(1300 + 300.rand, 110 + 130.rand, 16) }.asStream;
	x.do { arg item;
		s.sendMsg("/s_new", "pdef_grainlet", -1,0,0, \freq, item);
		dt.wait;
	}
}
)

... and so on ...

x.stop;
y.stop;




b) embedding TaskProxy into other Tasks / Routines


(
#a, c = { TaskProxy.new } ! 2;
a.source = { "one".postln; 1.wait; "two".postln };
c.source = { var z; z = Synth(\default); 0.5.wait; z.release };
r = Task {
	"counting...".postln;
	2.wait;
	a.embedInStream;
	1.wait;
	c.embedInStream;
	"done.".postln;
};
)

r.play; // play a stream

c.source = { var z; z = Synth(\default, [\freq, 300]); 1.5.wait; z.release }; // change the def

r.reset;
r.play;

// of course TaskProxies can be used in other Tdefs:
(
b = TaskProxy.new;
b.source = {
	"counting...".postln;
	2.wait;
	a.embedInStream;
	1.wait;
	c.embedInStream;
	"done.".postln;
};
)
b.playOnce;

// if one wants to branch off a stream in a separate thread, asStream is used.
(
Routine {
	c.asStream.play;
	0.1.wait;
	c.asStream.play;
	0.1.wait;
	a.asStream.play;

}.play;
)



