Busses

Now a little bit more about busses on the server. Busses are named after the busses or sends in analog mixing desks, and they serve a similar purpose: Routing signals from one place to another. In SC this means to or from the audio hardware, or between different synths. They come in two types: audio rate and control rate. As you've probably guessed, the former routes audio rate signals and the latter routes control rate signals.

The control rate busses are fairly simple to understand, each one has an index number, starting from 0.

Audio rate busses are similar, but require slightly more explanation. A server app will have a certain number of output and input channels. These correspond to the first audio busses, with outputs coming before inputs. 

For example, if we imagine a server with two output channels and two input channels (i.e. stereo in and out) then the first two audio busses (index 0 and index 1) will be the outputs, and the two immediately following those (index 2 and index 3) will be the inputs. Writing audio out to one of the output busses will result in sound being played from your speakers, and reading audio in from the input busses will get sound into SC for things like recording and processing (providing you have a source such as a microphone connected to your computer's or audio interface's inputs).

The remaining audio busses will be 'private'. These are used simply to send audio and control signals between various synths. Sending audio to a private bus will not result in sound in your speakers unless you reroute it later to one of the output busses. These 'private' busses are often used for things like an 'effects send', i.e. something that requires further processing before it's output.

The number of control and audio busses available, as well as the number of input and output channels is set at the time the server app is booted.(See ServerOptions for information on how to set the number of input and output channels, and busses.)

Writing to or Reading from Busses

We've already seen Out.ar, which allows you to write (i.e. play out) audio to a bus. Recall that it has two arguments, an index, and an output, which can be an array of UGens (i.e. a multichannel output) or a single UGen.

To read in from a bus you use another UGen: In. In's 'ar' method also takes two arguments: An index, and the number of channels to read in. If the number of channels is greater than one, than In's output will be an Array. Execute the following examples, and watch the post window:

	In.ar(0, 1); // this will return 'an OutputProxy'
	In.ar(0, 4); // this will return an Array of 4 OutputProxies

An OutputProxy is a special kind of UGen that acts as a placeholder for some signal that will be present when the synth is running. You'll probably never need to deal with one directly, so don't worry about them, just understand what they are so that you'll recognise them when you see them in the post window and elsewhere.

In and Out also have 'kr' methods, which will read and write control rate signals to and from control rate busses. Note that Out.kr will convert an audio rate signal to control rate (this is called 'downsampling'), but that the reverse is not true: Out.ar needs an audio rate signal as its second arg.

	// This throws an error. Can't write a control rate signal to an audio rate bus
	{Out.ar(0, SinOsc.kr)}.play;
	
	// This will work as the audio rate signal is downsampled to control rate
	Server.internal.boot;
	{Out.kr(0, SinOsc.ar)}.scope;	

(This limitation is not universal amongst audio rate UGens however, and most will accept control rate signals for some or all of their arguments. Some will even convert control rate inputs to audio rate if needed, filling in the extra values through a process called interpolation.)

You'll note that when multiple Synths write to the same bus, there output is summed, or in other words, mixed.

	(
	SynthDef("tutorial-args", { arg freq = 440, out = 0; 
		Out.ar(out, SinOsc.ar(freq, 0, 0.2)); 
	}).send(s);
	)
	// both write to bus 1, and their output is mixed
	x = Synth("tutorial-args", ["out", 1, "freq", 660]);
	y = Synth("tutorial-args", ["out", 1, "freq", 770]);

Creating a Bus Object

There is a handy client-side object to represent server busses: Bus. Given that all you need is an In or Out Ugen and an index to write to a bus, you might wonder what one would need a full-fledged Bus object for. Well, much of the time you don't, particularly if all you're doing is playing audio in and out. But Bus does provide some useful functionality. We'll get to that in a second, but first lets look at how to make one.

Just as many UGens have ar and kr methods, Bus has two commonly used creation methods: Bus-audio and Bus-control. These each take two arguments: a Server object, and the number of channels.

	b = Bus.control(s, 2); // Get a two channel control Bus
	c = Bus.audio(s); 		// Get a one channel private audio Bus (one is the default)

You may be wondering what a 'two channel' bus is, since we haven't mentioned these before. You should recall that when Out has an Array as its second argument it will write the channels of the Array to consecutive busses. Recall this example from SynthDefs and Synths:
	
	(
	SynthDef.new("tutorial-SinOsc-stereo", { var outArray;
		outArray = [SinOsc.ar(440, 0, 0.2), SinOsc.ar(442, 0, 0.2)];
		Out.ar(0, outArray); // writes to busses 0 and 1 
	}).play;
	)
	
The truth is that there aren't multichannel busses per se, but Bus objects are able to represent a series of busses with consecutive indices. The encapsulate several adjacent sever-side busses into a single Bus object, allowing you to treat them as a group. This turns out to be rather handy.

When you're working with so-called 'private' busses (i.e. anything besides the input and output channels; all control busses are 'private') you generally want to make sure that that bus is only used for exactly what you want. The point after all is to keep things separate. You could do this by carefully considering which indices to use, but Bus allows for this to be done automatically. Each Server object has a bus allocator, and when you make a Bus object, it reserves those private indices, and will not give them out again until freed. You can find out the index of a Bus by using its 'index' method. Normally however, you will not need to store this value, as instances of Bus can be passed directly as UGen inputs or Synth args.

	s.reboot; // this will restart the server app and thus reset the bus allocators
	
	b = Bus.control(s, 2);	// a 2 channel control Bus
	b.index; 				// this should be zero
	b.numChannels 		// Bus also has a numChannels method
	c = Bus.control(s);	
	c.numChannels;		// the default number of channels is 1
	c.index;				// note that this is 2; b uses 0 and 1
	
So by using Bus objects to represent adjacent busses, you can guarantee that there won't be a conflict. Since the indices are allocated dyamically, you can change the number of channels of a Bus in your code (for instance because you now need to route a multichannel signal), and you're still guaranteed to be safe. If you were simply 'hard allocating' busses by using index numbers, you might have to adjust them all to make room for an extra adjacent channel, since the indices need to be consecutive! This is a good example of the power of objects: By encapsulating things like index allocation, and providing a layer of abstraction, they can make your code more flexible.

You can free up the indices used by a Bus by calling its 'free' method. This allows them to be reallocated.

	b = Bus.control(s, 2);
	b.free; // free the indices. You can't use this Bus object after that 
	
Note that this doesn't actually make the bus on the server go away, it's still there. 'free' just lets the allocator know that you're done using this bus for the moment, and it can freely reallocate its index.

Now here's another advantage when working with private audio rate busses. As we said above, the first few busses are the output and input channels. So if we want to use the first private bus, all we need to do is add those together, right? Consider our server app with 2 output and 2 input channels. The first private audio bus is index 4. (0, 1, 2, 3 ... 4!) So we write our code, and give the appropriate Out UGen 4 as its index arg. 

But what happens if we later decide to change the number of output channels to 6? Now everything that was written to our private bus is going out one of the output channels! A Server's audio bus allocator will only assign private indices, so if you change the number of input or output channels it will take this into account when you execute your code. Again this makes your code more flexible.

Busses in Action

So here are two examples using busses. The first is with a control rate bus.

	(
	SynthDef("tutorial-Infreq", { arg bus, freqOffset = 0;
		// this will add freqOffset to whatever is read in from the bus
		Out.ar(0, SinOsc.ar(In.kr(bus) + freqOffset, 0, 0.5));
	}).send(s);
	
	SynthDef("tutorial-Outfreq", { arg freq = 400, bus;
		Out.kr(bus, SinOsc.kr(1, 0, freq/40, freq));
	}).send(s);
	
	b = Bus.control(s,1);
	)
	
	(
	x = Synth.new("tutorial-Outfreq", [\bus, b]);
	y = Synth.after(x, "tutorial-Infreq", [\bus, b]);
	z = Synth.after(x, "tutorial-Infreq", [\bus, b, \freqOffset, 200]);
	)
	x.free; y.free; z.free; b.free;

Both y and z read from the same bus, the latter just modifies the frequency control signal by adding a constant value of 200 to it. This is more efficient than having two separate control oscillators to control frequency. This sort of strategy of connecting together synths, each of which does different things in a larger process, can be very effective in SC.

Now an example with an audio bus. This is the most complicated example we've seen so far, but should give you some idea of how to start putting all the things we've learned together. The code below will use two Synths as sources, one creating pulses of PinkNoise (a kind of Noise which has less energy at high frequencies than at low), and another creating pulses of Sine Waves. The pulses are created using the UGens Impulse and Decay2. These are then reverberated using a chain of AllpassC, which is a kind of delay.

Note the construction 16.do({ ... }), below. This makes the chain by evaluating the function 16 times. This is a very powerful and flexible technique, as by simply changing the number, I can change the number of evaluations. See Integer for more info on Integer-do.

	(
	// the arg direct will control the proportion of direct to processed signal
	SynthDef("tutorial-DecayPink", { arg outBus = 0, effectBus, direct = 0.5;
		var source;
		// Decaying pulses of PinkNoise. We'll add reverb later.
		source = Decay2.ar(Impulse.ar(1, 0.25), 0.01, 0.2, PinkNoise.ar);
		// this will be our main output
		Out.ar(outBus, source * direct);
		// this will be our effects output
		Out.ar(effectBus, source * (1 - direct));
	}).send(s);
	
	SynthDef("tutorial-DecaySin", { arg outBus = 0, effectBus, direct = 0.5;
		var source;
		// Decaying pulses of a modulating Sine wave. We'll add reverb later.
		source = Decay2.ar(Impulse.ar(0.3, 0.25), 0.3, 1, SinOsc.ar(SinOsc.kr(0.2, 0, 110, 440)));
		// this will be our main output
		Out.ar(outBus, source * direct);
		// this will be our effects output
		Out.ar(effectBus, source * (1 - direct));
	}).send(s);
	
	SynthDef("tutorial-Reverb", { arg outBus = 0, inBus;
		var input;
		input = In.ar(inBus, 1);
		
		// a low rent reverb
		// aNumber.do will evaluate it's function argument a corresponding number of times
		// {}.dup(n) will evaluate the function n times, and return an Array of the results
		// The default for n is 2, so this makes a stereo reverb
		16.do({ input = AllpassC.ar(input, 0.04, { Rand(0.001,0.04) }.dup, 3)});
		
		Out.ar(outBus, input);
	}).send(s);
	
	b = Bus.audio(s,1); // this will be our effects bus
	)
	
	(
	x = Synth.new("tutorial-Reverb", [\inBus, b]);
	y = Synth.before(x, "tutorial-DecayPink", [\effectBus, b]);
	z = Synth.before(x, "tutorial-DecaySin", [\effectBus, b, \outBus, 1]);
	)
	
	// Change the balance of wet to dry
	y.set(\direct, 1); // only direct PinkNoise
	z.set(\direct, 1); // only direct Sine wave
	y.set(\direct, 0); // only reverberated PinkNoise
	z.set(\direct, 0); // only reverberated Sine wave
	x.free; y.free; z.free; b.free;

Note that we could easily have many more source synths being processed by the single reverb synth. If we'd built the reverb into the source synths we'd be duplicating effort. But by using a private bus, we're able to be more efficient.

More Fun with Control Busses

There are some other powerful things that you can do with control rate busses. For instance, you can map any arg in a running synth to read from a control bus. This means you don't need an In UGen. You can also write constant values to control busses using Bus' 'set' method, and poll values using its 'get' method. 

	(
	// make two control rate busses and set their values to 880 and 884. 
	b = Bus.control(s, 1); b.set(880);
	c = Bus.control(s, 1);	c.set(884);
	// and make a synth with two frequency arguments
	x = SynthDef("tutorial-map", { arg freq1 = 440, freq2 = 440; 
		Out.ar(0, SinOsc.ar([freq1, freq2], 0, 0.1));
	}).play(s);
	)
	// Now map freq1 and freq2 to read from the two busses
	x.map(\freq1, b, \freq2, c);
	
	// Now make a Synth to write to the one of the busses
	y = {Out.kr(b, SinOsc.kr(1, 0, 50, 880))}.play(addAction: \addToHead);

	// free y, and b holds its last value
	y.free;
	
	// use Bus-get to see what the value is. Watch the post window
	b.get({ arg val; val.postln; f = val; });
	
	// set the freq2, this 'unmaps' it from c
	x.set(\freq2, f / 2);
	
	// freq2 is no longer mapped, so setting c to a different value has no effect
	c.set(200);
	
	x.free; b.free; c.free;

Note that unlike audio rate busses, control rate busses hold their last value until something new is written. 

Also note that Bus-get takes a Function (called an action function) as an argument. This is because it takes a small amount of time for the server to get the reply and send it back. The function, which is passed the value (or Array of values in the case of a multichannel bus) as an argument, allows you to do something with the value once its come back.

This concept of things taking a small amount of time to respond (usually called latency) is quite important to understand. There are a number of other methods in SC which function this way, and it can cause you problems if you're not careful. To illustrate this consider the example below.

	// make a Bus object and set its values 
	b = Bus.control(s, 1); b.set(880);
	
	// execute this altogether
	(
	f = nil; // just to be sure
	b.get({ arg val; f = val; });
	f.postln;
	)
	
	// f equals nil, but try it again and it's as we expected!
	f.postln;

So why was f nil the first time but not the second time? The part of the language app which executes your code (called the interpreter), does what you tell it, as fast as it can, when you tell it to. So in the block of code between the parentheses above it sends the 'get' message to the server, schedules the Function to execute when a reply is received, and then moves on to posting f. Since it hasn't received the reply yet f is still nil when it's posted the first time.

It only takes a tiny amount of time for the server to send a reply, so by the time we get around to executing the last line of code f has been set to 880, as we expected. In the previous example this wasn't a problem, as we were only executing a line at a time. But there will be cases where you will need to execute things as a block, and the action function technique is very useful for that.

Getting it all in the Right Order

In the examples above, you may have wondered about things like Synth.after, and addAction: \addToHead. During each cycle (the period in which a block of samples is calculated) the server calculates things in a particular order, according to its list of running synths.

It starts with the first synth in its list, and calculates a block of samples for its first UGen. It then takes that and calculates a block of samples for each of its remaining UGens in turn (any of which may take the output of an earlier UGen as an input.) This synth's output is written to a bus or busses, as the case may be. The server then moves on to the next synth in its list, and the process repeats, until all running synths have calculated a block of samples. At this point the server can move on to the next cycle.

The important thing to understand is that as a general rule, when you are connecting synths together using busses it is important that synths which write signals to busses are earlier in the server's order than synths which read those signals from those busses. For instance in the audio bus example above it was important that the 'reverb' synth is calculated after the noise and sine wave synths that it processes.

This is a complicated topic, and there are some exceptions to this, but you should be aware that ordering is crucial when interconnecting synths. The file Order-of-execution covers this topic in greater detail.

Synth-new has two arguments which allow you to specify where in the order a synth is added. The first is a target, and the second is an addAction. The latter specifies the new synth's position in relation to the target.

	x = Synth("default", [\freq, 300]);
	// add a second synth immediately after x
	y = Synth("default", [\freq, 450], x, \addAfter);
	x.free; y.free;

A target can be another Synth (or some other things; more on that soon), and an addAction is a symbol. See Synth for a complete list of possible addActions.

Methods like Synth-after are simply convenient ways of doing the same thing, the difference being that they take a target as their first argument.

	// These two lines of code are equivalent
	y = Synth.new("default", [\freq, 450], x, \addAfter);
	y = Synth.after(x, "default", [\freq, 450]);

For more information see: 

Bus In OutputProxy Order-of-execution Synth

Suggested Exercise:

Experiment with interconnecting different synths using audio and control busses. When doing so be mindful of their ordering on the server.

____________________

This document is part of the tutorial Getting Started With SuperCollider.

Click here to go on to the next section: Groups

Click here to return to the table of Contents: Getting Started With SC


