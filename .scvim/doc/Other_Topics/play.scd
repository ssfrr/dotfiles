play


start a process


this message is of common use in sc. Different objects respond to it in various
ways, but the simple meaning is: start a process.
It is usually implemented by objects in contributed libraries as well.

play usually returns the playing object which might not be the same as the one
the message was sent to.

opposite: stop



clock.play(stream)
returns: the clock
	
	(
	r = Routine.new({ "...playing".postln; 1.wait; "ok, that was it".postln });
	SystemClock.play(r);
	)

routine.play(clock)
returns: the routine

	Routine.new({ "...playing".postln; 1.wait; "ok, that was it".postln }).play;


stream.play(clock)
returns the stream
	the stream will loop until it returns nil
	
	FuncStream({ "ok, that was it".postln; 1 }).play;
	
	
pausestream.play(clock) / task.play(clock)
returns the stream

	a = PauseStream.new(FuncStream.new({ "ok, that was it".postln; 1 }));
	a.play;
	a.stop;
	a.play;
	a.stop;
	
	a = Task.new({ loop({ "ok, that was it".postln; 1.wait; }) });
	a.play;
	a.stop;
	
	
pattern.play(clock, protoEvent)
returns: an EventStreamPlayer

	(
	Pseq([
		Pbind(\freq, Pn(500, 1)),
		Pbind(\dur, Pn(0.1, 1))
	], 2).play;
	)





Playing single Synths from SynthDefs on the server


The following play messages both cause a SynthDef to be written, send it to the server 
and start a synth with it there.

Note that they should not be used in quickly running automated processes,
as there are more efficient alternatives (see SynthDefsVsSynths)



function.play(target, outbus, fadeTime, addAction, args)

See Function
returns: a Synth
	
	outbus: on what bus to play (default: 0)
	fadeTime: in what time to fade out when released (defaulr: 0.02)
	addAction: where to add the node (\addToHead by default)
	args: controls to set when starting the synth


a = { PinkNoise.ar([0.1, 0.1]) }.play;
a.release;

// setting argument
a = { |freq = 500| HPF.ar(PinkNoise.ar([1, 1] * 0.4), freq) }.play;
a.set(\freq, 1000)
a.release;

// passing argument with play:
a = { |freq = 500| HPF.ar(PinkNoise.ar([1, 1] * 0.4), freq) }.play(args: [\freq, 10000]);


// note that you can use Out ugens but you do not need to
{ Out.ar(1, PinkNoise.ar(0.1)) }.play;
{ XOut.ar(0, MouseX.kr(0,1), PinkNoise.ar(0.1*[1,1])) }.play; // mouse x controls level




synthDef.play(target, args, addAction)
returns: a Synth
	
	Note that you need an out ugen to hear the result.
	Examples of how to write to the busses in the helpfiles: Out / ReplaceOut / XOut / OffsetOut
	
	Nevertheless, synths can also run without any writing activity: (see e.g. SendTrig)
	
	Some operations provide an out ugen internally: see for example function.play, which plays out
	to a bus number provided in the argument passed to .play


(
x = SynthDef("test", { arg out, amp=0.1;
	var sound;
	sound = PinkNoise.ar(amp * [1,1]);
	Out.ar(out, sound);
}).play;
)

//set the synth
x.set(\amp, 0.2);
//free the synth
x.free;


note: Synth.play(function), is synonymous. for backwards compatibility with sc2






	


