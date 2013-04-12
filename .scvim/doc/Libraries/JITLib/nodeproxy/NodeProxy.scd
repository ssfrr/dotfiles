NodeProxy		a reference on a server 

Inherits from:  Object : AbstractFunction : BusPlug


Generally a proxy is a placeholder for something.  A node proxy is a placeholder for something playing on a server that writes to a limited number of busses (e.g. a synth or an event stream). NodeProxy objects can be replaced and recombined while they play. Also they can be used to build a larger structure which is used and modified later on. Overview: JITLib

NodeProxy is used internally in ProxySpace and it is a superclass of Ndef, allowing to easily access and combine a large number of placeholders.

Graphical editor for a node proxy: NodeProxyEditor.

Note:  NodeProxy plays on a private bus. If you want to hear the output, use play and stop.
To free inner players and stop listen:		end
Entirely removing all inner settings:   		clear


Further reading:
the_lazy_proxy
jitlib_efficiency 
jitlib_fading
jitlib_asCompileString
NodeProxy_roles


First Example

	s.boot;
	
	a = NodeProxy.new.play; // play to hardware output.
	a.fadeTime = 2; // fadeTime specifies crossfade
	// set the source
	a.source = { SinOsc.ar([350, 351.3], 0, 0.2) };
	a.source = { Pulse.ar([350, 351.3] / 4, 0.4) * 0.2 };
	a.source = Pbind(\dur, 0.03, \freq, Pbrown(0, 1, 0.1, inf).linexp(0, 1, 200, 350));
	
	b = NodeProxy.new;
	a.source = { Ringz.ar(b.ar, [350, 351.3] * 8, 0.2) * 4 };
	b.source = { Impulse.ar([5, 7]/2, [0, 0.5]) };
	
	a.clear(3); // clear after 3 seconds
	b.clear(3);
	


Creation / Class Methods

	*new(server, rate, numChannels, inputs)
	
		Return a new instance of NodeProxy.
		server - The server on which to run and where the bus is allocated (default: Server.default)
		rate  - If given, proxy is initialized to this rate
		numChannels  - If given, proxy is initialized to this number of channels
		inputs  - If given, proxy is initialized with the given inputs as objects on subsequent slots.		
		
		// new node proxy
		a = NodeProxy(s, \audio, 4);
		a.numChannels;
		a.clear; // remove bus.
		a.numChannels; // nil.

	*audio(server, numChannels)
	
		Return a new audio rate NodeProxy of a given number of channels.
		server - The server on which to run and where the bus is allocated (default: Server.default)
		numChannels  - If given, proxy is initialized to this number of channels (default: 2)

	*control(server, numChannels)
	
		Return a new control rate NodeProxy of a given number of channels.
		server - The server on which to run and where the bus is allocated (default: Server.default)
		numChannels  - If given, proxy is initialized to this number of channels (default: 1)	
		
	*for(bus)
	
		Return a new instance of NodeProxy using a given Bus


Listening to the output


	play(outbus, numChannels, target, multi, vol, fadeTime, addAction)
		plays to a bus index (outbus) with a number of channels (numChannels) within a target group, or a server.
				multi: keep old links and add new one
				vol: volume at which to monitor
				fadeTime: fade in fade out time
	
	playN(outs, amps, ins, vol, fadeTime, group, addAction)
				outs			array of destination channels
				amps		array of  amplitudes for each channel
				outs			array of source channels
				see playN

	stop(fadeTime)
		stop to play out public channels (private channels keep playing as others might listen still) this stops the monitoring. To stop the objects playing, use free, release
		fadeTime: decay time for this action
	
	end(fadeTime)
		releases the synths and stops playback
		fadeTime: decay time for this action
		
		
	ar(numChannels)
	kr(numChannels)
	
		return a link to my output, which is limited by [numChannels]
		causes an uninitialized proxy to create a matching bus.
	
	normally ar defaults to stereo, kr to mono. this can be set in the classvars:
	defaultNumAudio, defaultNumControl
	

Setting the source:
	NodeProxy keeps a number of slots which can be sources and are mixed on the same bus.. The default source is the slot 0. All objects can be exchanged while running, and also before and after. Normally, the source is active immediately. If sources are to be exchanged "quietly", set the node proxy to sleep (awake = false), or use the message prime().
			

Supported sources:
	
	
	NodeProxy				played by reading from the other node proxie's bus.
	Function					interpreted as ugen function, and plays a Synth, similar to Function.play.
	SimpleNumber				write this value to the bus continuously
	Bus						reads from the bus
	SynthDef					plays a Synth using the SynthDef. This is useful for triggering.
	Symbol					plays a Synth from the SynthDef with this name. This is useful for triggering.
	Pattern					played as event pattern (using Pbind or other event patterns)
	Stream					played as event stream (a stream returning events)
	nil						Nil removes all objects.
	Pdef, EventPatternProxy		played like a stream
	Task						played, no output is assigned.
	Tdef						played like Task
	Event					played like in a pattern.
	
	Associations: 
	(\filter -> func)				filter previous input (with post control)
	(\filterIn -> func)			filter previous input (with pre control)
	(\set -> event pattern)		set controls with the event keys of the pattern
	(\setbus -> event pattern)		set bus with an event pattern. Bus value is the \value key of each event.
	(\setsrc -> event pattern)		set the source with an event pattern. source is the \source key of event.
	(\control -> array or number)	prepare an efficient way to set values by index
	(\mix -> func)				mix audio
	
	crucial library:
	AbstractPlayer				started in a separate bus, mapped to this bus
	Instr						converted to player and started
	
	Definitions for other sources can be added easily.



Setting the source:


	source_(anObject)
		Play a new synth through proxy and release/remove any old ones.
		anObject - can be one of the supported inputs (see above)
			
	prime(anObject)
		Set source without starting the synth. To start it, send can be used later. Running synths are released and proxy is initialized if still neutral.
		
	add(anObject, channelOffset, extraArgs)
		Add a new source to the present ones
	
	removeAt(index)
		Remove the object at index i and its synths, if they exist.
	
	removeLast
		Remove the last object and its synths, if they exist.
	
	
	put(index, obj, channelOffset, extraArgs, now)
		Set the source by index. Objects can be inserted at any index, only the order of indices is relevant. Internally, NodeProxy uses an Order to access the sources.
		
		index:	where the object should be placed in the internal  order. if -1, all objects are freed
		obj:		A valid source (see above).
		channelOffset: using a multichannel setup it can be useful to set this, when the objects numChannels is smaller than the proxy 
						
		extraArgs: 	Arguments that can be sent with the object directly (not cached)
			
		now			if set to false, only prepare the source and do not start the object (see prime)
		
		// put can be used with the array indexing syntax: 
		
		a = NodeProxy.new.play;
		a[0] = { SinOsc.ar(Rand(200, 899)) * 0.1.dup };
		a[2] = { SinOsc.ar(Rand(200, 899)) * 0.1.dup };
		a.sources.do(_.postcs);
		// using multiple index expands into multiple objects
		a[0..5] = { SinOsc.ar(Rand(200, 899)) * 0.1.dup };
		a.sources.do(_.postcs);
		a.send; // exchange synths, using the sources as definitions
		a.clear; 
	
	pause - Pause all objects and set proxy to paused
	
	resume - If paused, start all objects 
	
	rebuild - Rebuild all SynthDefs from sources.

	orderNodes(nodeProxy, nodeProxy...)
		Arrange the order of groups from this to the last. This can be important when external input is filtered in order to minimize latency.
		Note that if a parentGroup was provided, the nodes must be in the same parentGroup.
		
	proxyA <-- proxyB	
		Set proxyA source to proxyB and play proxyA. If proxyB was playing, fade it out. This is convenient in the following situation:
		b = NodeProxy.new.play;
		b.source = { PinkNoise.ar(0.2.dup) };
		// now I want to filter b through a new proxy.
		a = NodeProxy.new;
		a <-- b; a.source = { HPF.ar(b.ar, 7000) };
		a.source = { HPF.ar(b.ar, 3000) };// changing the source
		a.clear; b.clear;
	
	proxyA <<> proxyB	<<> proxyC <<> ...
		Chaining: Map proxyC source to proxyB \in argument, and proxyB to proxyA's in argument.
		a = NodeProxy.new.play;
		a.source = { RLPF.ar(\in.ar(0!2), [4600, 7000], 0.1) };
		b = NodeProxy.new.source_ { Impulse.ar([5, 7] / 2) };
		a <<> b;
		
	proxyA <>> proxyB	<>> proxyC <>> ...
		Inverse of the above.
	

Release and cleaning up:

	free(fadeTime)
		Release all running synths and the group. If patterns are playing, stop them.
		fadeTime: decay time for this action
	
	release(fadeTime)
		release running synths. If patterns are playing, stop them.
		fadeTime: decay time for this action
	
	clear(fadeTime)
		reset everything to nil, neutralizes rate/numChannels
		if a fadeTime is given, first fade out, then clear.
		


Accessing Instance and Class Variables
	
	sources	Returns an array of all sources
	source	Returns the first source.
	
	server	The node proxy's server (a Server).
	bus		The node proxy's private bus (a Bus). Because it has a private bus, it is not audible directly - monitoring it by (.play or playN) routs it to the hardware output channels.
	rate - The bus rate (default: nil) The rate and number of channels is determined either when the instance is created (.control/.audio) or by lazy initialisation from the first source (see the_lazy_proxy) 
	
	numChannels - The bus numChannels (default: nil)
	isNeutral - true if the proxy has no initialized bus.
	
	group	The node proxy's group (a Group). This is maintained by the proxy and serves as a context in which all synths are placed.
	parentGroup
	parentGroup_	Access the parentGroup (default: nil), which can be set to run the proxy's group in another group. This group has to be maintained (kept playing etc.) externally.


	clock_	A clock, which can be set to account for different timing schemes, such as beat accurate replacement of sources.
	quant_	A quant value, to specify quantizes replacement of sources. Compatible with the general use of quant in SuperCollider.
	quantize(... proxies)
		Synchronize the proxies by resending and adjusting to quant.	

	monitor
	monitor_	Access the Monitor object, which plays back the output of the proxy's private bus.
	loaded	Returns true if the object has been initialized on the server, e.g. a synthDef has been stored.
	paused	Returns true if the processes are paused.
	awake_	If set to false (default: true), a change of the source does not start a new synth immediately. This is useful when synths are triggered by spawn, and a change of sound should not duplicate sends.

	fadeTime_(time)
		set the crossfade time. See:  jitlib_fading.
			
		
	*defaultNumAudio_
	*defaultNumControl_
		set the default channel number for audio/control busses



	
Setting synth controls

	set(key, val, ...)
		NodeProxy behaves like its nodeMap (NodeMap)
		set, 
		setn, 
		unset, 
		unmap
		
	map(key(s), proxy,  key(s), proxy, .... )
		Map the arguments in keys to the subsequent channels of another proxy  (keys can be a symbol or a number)
		If the proxy has multiple channels, subsequent channels of the control, if present, are mapped. Note  that you should not map to more channels than the control has.
		
	setn(key, list, ...) 
		set ranges of controls
	
	run(flag)
		pause/unpause all synths in the group
	
	xset(key, val, ...)
		set with crossfade into new setting
		
	xmap(keys, proxy)
		map with crossfade into new setting
	
	xsetn()
		untested
	
	lag(key, val, ...)	
		set the lag values of these args (identical to setRates)
		to remove these settings, use: lag(\key1, nil, key2, nil, ...)
	
	setRates(key, rate1, ...)
		set the default rate (\tr, \ir, numerical) for synthDef arg
		rate of nil removes setting


	controlNames(except)
		Returns the ControlName objects of all slots, except the names of this list (default: [\out, \i_out, \gate, \fadeTime], which are used internally).
	
	controlKeys(except, noInternalKeys)
		Returns the keys (symbols) of all control names objects of all slots, except the names of this list.
		(default: none). If noInternalKeys is true (default: true), it ignores the keys  [\out, \i_out, \gate, \fadeTime].
	
	getKeysValues(keys, except, withDefaults = true, noInternalKeys = true)
		Get all key value pairs from both NodeMap (the settings) and default arguments.

	controlKeysValues(keys, except)
		Get all key value pairs from default arguments.
			


Bus-like behaviour:
In some ways, Node Proxy behaves like a Bus:


	line(value, dur)
		set my bus to the new value in dur time linearly
	xline(value, dur)
		set my bus to the new value in dur time exponentially
	gate(value, dur)
		gate my bus to the level value for dur time


	
Sending synths to server
	
	
	send(extraArgs, index, freeLast)
		Send a new synth without releasing the old one. If the source is a stream or a pattern, it starts a new one.
		extraArgs: Arguments used to set the synth. the argument list is applied to the synth only.
		index:	What slot to send a new synth with. If nil, uses all. (default: nil)
		freeLast: if to free the last synth at that index or not (default: true)
		
		
	sendAll(extraArgs, freeLast)
		Send all synths, or restart all objects.
		extraArgs: Arguments used to set the synth. the argument list is applied to the synth only.
		freeLast: if to free the last synth at that index or not (default: true)
		
	sendEach(extraArgs, freeLast)
		Like send, just iterating seperately over the objects.
		
		
	wakeUp 
		Until the proxy is not used by any output ( either .play or .ar/.kr ) it is not running on the server. you can wake it up to force it playing. Normally this is not needed.

	record(path, headerFormat, sampleFormat)
		record output to file (returns a [RecNodeProxy] that you can use for control)
		returns a [RecNodeProxy]
		

GUI

	edit 
		Returns a new instance of NodeProxyEditor for this proxy. 
	
		a = NodeProxy.new;
		a.edit;
		
		(
		a.source = { |freq = 440, rate = 2| 
			SinOsc.ar(freq * [1, 1.625]) * SinOsc.kr(rate).max(0) * 0.2 
		}
		);
	

	
		
Examples

For more, see ProxySpace	




///////////////////// using node proxy with ugen functions  ///////////////////// 

s.boot;

a = NodeProxy.audio(s, 2);
a.play; // play to hardware output, return a group with synths

// setting the source
a.source = { SinOsc.ar([350, 351.3], 0, 0.2) };

// the proxy has two channels now:
a.numChannels.postln;
a.source = { SinOsc.ar([390, 286] * 1.2, 0, 0.2) };

// exeeding channels wrap:
a.source = { SinOsc.ar([390, 286, 400, 420, 300] * 1.2, 0, 0.2) };

// other inputs
a.source = { WhiteNoise.ar([0.01,0.01]) };
a.source = 0;
a.source = \default; // synthDef on server
a.source = SynthDef("w", { arg out=0; Out.ar(out,SinOsc.ar([Rand(430, 600), 600], 0, 0.2)) });
a.source = nil; //  removes any object

// feedback
a.source = { SinOsc.ar(a.ar * 7000 * LFNoise1.kr(1, 0.3, 0.6) + 200, 0, 0.1) };
a.source = { SinOsc.ar(a.ar * 6000 * MouseX.kr(0, 2) + [100, 104], 0, 0.1) };

// fadeTime
a.fadeTime = 2.0;
a.source = { SinOsc.ar([390, 286] * ExpRand(1, 3), 0, 0.2) };


// adding nodes
a.add({ SinOsc.ar([50, 390]*1.25, 0, 0.1) });
a.add({ BrownNoise.ar([0.02,0.02]) });

// setting nodes at indices:
a[0] = { SinOsc.ar( 700 * LFNoise1.kr(1, 0.3, 0.6) + 200, 0, 0.1) };
a[1] = { LFPulse.kr(3, 0.3) * SinOsc.ar(500, 0, 0.1) };
a[2] = { LFPulse.kr(3.5, 0.3) * SinOsc.ar(600, 0, 0.1) };
a[3] = { SinOsc.ar([1,1.25] * 840, 0, 0.1) };

// filtering: the first argument is the previous bus content. more args can be used as usual.
a[3] = \filter -> { arg in; in * SinOsc.ar(Rand(100,1000)) };
a[2] = \filter -> { arg in; in * MouseY.kr(0,1) };
a[8] = \filter -> { arg in; in * MouseX.kr(0,1) };
a[4] = \filter -> { arg in; in * SinOsc.ar(ExpRand(1,5)).max(0) };



// setting controls
a.fadeTime = 2.0;
a.source = { arg f=400; SinOsc.ar(f * [1,1.2] * rrand(0.9, 1.1), 0, 0.1) };
a.set(\f, rrand(900, 300));
a.set(\f, rrand(1500, 700));
a.xset(\f, rrand(1500, 700)); // crossfaded setting
a.source = { arg f=400; RLPF.ar(Pulse.ar(f * [1,1.02] * 0.05, 0.5, 0.2), f * 0.58, 0.2) };

// control lags
a.lag(\f, 0.5); // the objects are built again internally and sent to the server.
a.set(\f, rrand(1500, 700));
a.lag(\f, nil);
a.set(\f, rrand(1500, 700));

a.fadeTime = 1.0;

// mapping controls to other node proxies

c = NodeProxy.control(s, 2);
c.source = { SinOsc.kr([10,20] * 0.1, 0, 150, 1300) };
a.map(\f, c);
a[0] = { arg f=400; RHPF.ar(Pulse.ar(f * [1,1.2] * 0.05, 0.5, 0.2), f * 0.58, 0.2) };
c.source = { SinOsc.kr([10,16] * 0.02, 0, 50, 700) };
c.source = { Line.kr(300, 1500, 10) + SinOsc.kr(20 * [1,2], 0, 100) };
a[1] = { arg f; LFPar.ar(f % MouseX.kr(1, 40, 1) * 4 + 360, 0, 0.2) };

// map multiple channels of one proxy to multiple controls of another
// recently changed behaviour!

a.source = { arg f=#[400, 400]; LPF.ar(Pulse.ar(f[0] * [0.4,1], 0.2, 0.2), f[1] * 3) };
a.map(\f, c); // multichannel proxy c is mapped to multichannel control of a
a.source = { arg f=#[400, 400]; LPF.ar(Pulse.ar(f, 0.2, 0.2), f[1]) };
a.source = { arg f=#[400, 400]; Formant.ar(140, f * 1.5, 100, 0.1)  };
c.source = { SinOsc.kr([Line.kr(1, 30, 10), 1], 0, [100, 700], [300, 700]) };
c.source = 400;


c.fadeTime = 5.5;
c.source = { LFNoise0.kr([2.3, 1.0], [100, 700], [300, 1700]) };
c.source = { SinOsc.kr([2.3, 1.0], 0, [100, 700], [300, 1700]) };
c.source = 400;


// behave like a sc2 plug
c.gate(1400, 0.1);
c.gate(1000, 0.1);
c.line(1000, 1);

// direct access
a.lineAt(\f, 300, 2);
a.xlineAt(\f, 600, 0.3);
a.gateAt(\f, 1600, 0.3);


// changing nodeMaps
a.unmap(\f);
n = a.nodeMap.copy;
n.set(\f, 700);
a.fadeToMap(n);
n = a.nodeMap.copy;
n.set(\f, 400);
a.fadeTime = 1.0;
a.fadeToMap(n, [\f]); // linear interpolation to new map: experimental
a.map(\f, c); // restore mapping


// sending envelopes (up to 8 levels)
w = Env.new(Array.rand(3, 400, 1000),Array.rand(2, 0.3, 0.001), -4);
c.env(w);
c.env(w);
w = Env.new(Array.rand(8, 400, 1000),Array.rand(7, 0.03, 0.1));
c.env(w);
c.env(w);

// stop synthesis, then wake up proxies:

a.stop; // stop the monitor
a.play; // start the monitor
a.end;	// release the synths and stop the monitor
c.free;  // free the control proxy c





///////////////////// channel offset/object index  ///////////////////// 


a = NodeProxy.audio(s,2);
a.play;
a[0] = { Ringz.ar(Impulse.ar(5, 0, 0.1), 1260) };
a.put(1, { Ringz.ar(Impulse.ar(5.3, 0, 0.1), 420) }, 1);
a.put(0, { Ringz.ar(Dust.ar([1,1]*15.3,  0.1), 720) }, 1);
a.put(1, { Ringz.ar(Impulse.ar(5.3, 0, 0.1), 420) }, 1);
a.end;




///////////////////// beat accurate playing  ///////////////////// 




a = NodeProxy.audio(s,2);
a.play;

a.clock = TempoClock(2.0).permanent_(true); // round to every 2.0 seconds
a.source = { Ringz.ar(Impulse.ar(0.5, 0, 0.3), 3000, 0.01) };
a[1] = { Ringz.ar(Impulse.ar([0.5, 1], 0, 0.3), 1000, 0.01) };
a[2] = { Ringz.ar(Impulse.ar([3, 5]/2, 0, 0.3), 8000, 0.01) };
a[3] = { Ringz.ar(Impulse.ar([3, 5]*16, 0, 0.3), 5000, 0.01) * LFPulse.kr(0.5, 0, 0.05) };

a.removeLast;
a.removeAt(2);

a.clear;




///////////////////// using patterns - event streams  ///////////////////// 


(
// must have 'out' or 'i_out' argument to work properly
SynthDef("who", { arg freq, gate=1, out=0, ffreq=800, amp=0.1; 
	var env;
	env = Env.asr(0.01, amp, 0.5);
	Out.ar(out, Pan2.ar(
		Formant.ar(freq, ffreq, 300, EnvGen.kr(env, gate, doneAction:2)), Rand(-1.0, 1.0))
	)
}).add;

)


(
s.boot;
a = NodeProxy.audio(s, 2);
a.fadeTime = 2;
b = NodeProxy.audio(s,2);
b.fadeTime = 3;
)

a.play; // monitor output

// play the pattern silently in b
b.source = Pbind(\instrument, \who, \freq, 500, \ffreq, 700, \legato, 0.02);

// play b out through a:
a.source = b;

// filter b with ring modulation:
a.source = {  b.ar  * SinOsc.ar(SinOsc.kr(0.2, 300, 330))  }; // filter the input of the pattern
a.source = {  b.ar * LFCub.ar([2, 8], add: -0.5)  }; // filter the input of the pattern

a.source = b;

// map b to another proxy
c = NodeProxy.control(s, 1).fadeTime_(1);
c.source = { SinOsc.kr(2, 0, 400, 700) };


// now one can simply embed a control node proxy into an event pattern.
// (this works not for \degree, \midinote, etc.)
// embedding in other patterns it will still return itself.


b.source = Pbind(\instrument, \who, \freq, 500, \ffreq, c, \legato, 0.02);

c.source = { SinOsc.kr(SinOsc.kr(0.2, 0, 10, 10), 0, 400, 700) };

c.source = { LFNoise1.kr(5, 1300, 1500) };
c.source = { MouseX.kr(100, 5500, 1) };

(
b.source = Pbind(
			\instrument, \who, 
			\freq, Pseq([600, 350, 300],inf),
			\legato, 0.1,
			\ffreq, Pseq([c, 100, c, 100, 300, 600], inf), // use proxy in a pattern
			\dur, Pseq([1, 0.5, 0.75, 0.25] * 0.4, inf),
			\amp, Pseq([0.2, 0.2, 0.1, 0.1, 0.2], inf)
		);
)

 

b[2] = Pbind(\instrument, \who, \freq, 620, \ffreq, Prand([500,c],inf), \legato, 0.1, \dur, 0.1);
b[3] = Pbind(\instrument, \who, \ffreq, 5000, \freq, Pseq([720, 800],inf), \legato, 0.1, \dur, 0.1, \amp, 0.01);
b[4] = Pbind(\instrument, \who, \freq, Pseq([700, 400],inf), \legato, 0.1, \ffreq, 200);
b[1] = { WhiteNoise.ar([0.01,0.01]) }; 
b[4] = { arg ffreq=800; Resonz.ar(WhiteNoise.ar([1,1]), ffreq, 0.05) }; 


b.map(\ffreq, c); // map the control to the proxy
b.removeLast;
b.removeLast;
a.source = {  b.ar * WhiteNoise.ar(0.1, 1)  }; 
a.source = {  b.ar * WhiteNoise.ar(0.1, 1) + (b.ar * SinOsc.ar(SinOsc.kr(0.01, 0, 50, 330)))  }; 

c.source = { XLine.kr(1900, 10, 10) };

a.clear(10); b.clear(10); c.clear(10); // fade out and clear all (free bus, group and synths)



