PatternProxy				stream reference

superclass: Pattern



keeps a reference to a stream that can be replaced while playing.
Multiple streams are thus handled without creating dependancies.

related: Pdefn

	*new(source)
		create a new instance with a pattern (the source).
		the pattern should be a value pattern (see Pdefn)
		
		for event pattern proxy, see: EventPatternProxy
		instead of a pattern, a function can be passed in, creating a routine.
	
	*default
		a default source, if none is given. the default is 1.0 (it is not 0.0 in order to make it safe for durations)
	
	source_(obj)
		set the source. If a quantization is given, schedule this change to the next beat
		
	clear	set the source to nil
	
	quant_
		set the quantization value
		
	quant
		get the quantization value
		
	
	*defaultQuant_
		set the default quantization value for the class. (default: nil)
	
	condition_(func)
			provide a condition under which the pattern is switched when a new one is inserted.
			the stream value and a count is passed into the function
			the methods count_(n) simply counts up to n and switches the pattern then
		
	reset		
			switch the pattern immediately. (stuck conditions can be subverted by this)


	embedInStream(inval)
			just like any pattern, embeds itself in stream
	
	PatternProxy implements some methods for the benefits of its subclasses Pdefn/Pdef/Tdef which
	are not useful for PatternProxy, EventStreamProxy and TaskProxy.
	
	envir_(event)
			provide a default environment for the proxy. 
			If given,  it is used as an environment for the routine 
			function. When set for the first time, the routine pattern is rebuilt.
	
	set(key, val, key2, val2, ...)
			set arguments in the environment. 
			If there is none, it is created and the pattern is rebuilt.

	endless
			returns a Proutine that plays the proxy endlessly, replacing nil with a default
			value (1). This allows to create streams that idle on until a new pattern is inserted.

// example

a = PatternProxy(Pseq([1, 2, 3], inf));

x = Pseq([0, 0, a], inf).asStream;

t = Task({ loop({ x.next.postln; 0.3.wait }) }).play;


a.source = Pseq([55, 66, 77], inf);
a.source = Pseq([55, 66, 77], 1);

t.stop;


// PatternProxy, like Pdefn can be accessed in multiple streams

(
SynthDef("Pdefhelp", { arg out, freq, sustain=1, amp=1, pan;
	var env, u=1;
	env = EnvGen.kr(Env.perc(0.03, sustain), 1, doneAction:2);
	5.do { var d; d = exprand(0.01, 1); u = SinOsc.ar(d * 300, u, rrand(0.1,1.2) * d, 1) };
	Out.ar(out, Pan2.ar(SinOsc.ar(u + 1 * freq, 0, amp * env), pan));

}).store;
s.boot;
)

(
x = PatternProxy.new;
x.source = Pseq([0, 3, 2], inf);

Pset(\instrument, \Pdefhelp, 
	Ppar([
	Pbind(\degree, x),
	Pbind(\degree, x, \dur, 1/3)
])
).play;
)

x.source = Prand([0, 3, [1s, 4]], inf);

x.source = Pn(Pshuf([0, 3, 2, 7, 6], 2), inf);



// if quant is set, the update is done at the next beat or whatever is specified:

x.quant = 4;
x.source = Pn(Pseries(0, 1, 8), inf);

x.quant = nil; // reactivate immediacy

(
x.source = Prout {
	loop {
	4.do { |i|
		#[2, 3, 4].choose.yield;
		#[5, 0, 11].choose.yield;
		#[6, 3, 4].choose.do { |j| (i % j).yield };
	}
	}
}
)




