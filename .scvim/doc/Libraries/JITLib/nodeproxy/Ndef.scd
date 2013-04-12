Ndef				node proxy definition

Inherits from: Object : AbstractFunction : BusPlug : NodeProxy


Reference to a proxy, forms an alternative to ProxySpace. 
All methods are inherited from NodeProxy

Ndef(key) returns the instance
Ndef(key, obj) stores the object and returns the instance, like Tdef and Pdef.

Graphical editor overviewing all current Ndefs: NdefMixer
A general overview: JITLib


First Example

	s.boot;
	
	Ndef(\a).play; // play to hardware output.
	Ndef(\a).fadeTime = 2; // fadeTime specifies crossfade
	// set the source
	Ndef(\a, { SinOsc.ar([350, 351.3], 0, 0.2) });
	Ndef(\a, { Pulse.ar([350, 351.3] / 4, 0.4) * 0.2 });
	Ndef(\a, Pbind(\dur, 0.03, \freq, Pbrown(0, 1, 0.1, inf).linexp(0, 1, 200, 350)));
	
	Ndef(\a, { Ringz.ar(Ndef.ar(\b), [350, 351.3] * 8, 0.2) * 4 });
	Ndef(\b, { Impulse.ar([5, 7]/2, [0, 0.5]) });
	
	Ndef.clear(3); // clear all after 3 seconds


Creation / Class Methods


	*new(key, object)
		Return a new node proxy and store it in a global ProxySpace under the key. If there is already an Ndef there, replace its object with the new one. The object can be any supported class, see NodeProxy help.
		
		If key is an association, it is interpreted as key -> server name.  (order changed in SC3.3 !).
		If no name is given, it uses the default server that was default when Ndef was first called. (to change it, see defaultServer_(server)).
			
	*ar(key, numChannels, offset)
			equivalent to *new(key).ar(numChannels, offset) (see NodeProxy help for ar method)
	
	*kr(key, numChannels, offset)
			equivalent to *new(key).kr(numChannels, offset) (see NodeProxy help for kr method)
			
	*clear
			clear all proxies

	*at(server, key)
			return an instance at that key for that server
			
	*defaultServer_(a server)
			set the default server (default: Server.default)
			
	*all
			Return the dictionary of all servers, pointing to proxyspaces with Ndefs for each.
			
			Ndef.all;
	
			
	*dictFor(server)
			Return the proxyspace for a given server.
			
			Ndef.dictFor(s);





Example	

	
	s.boot;
	
	Ndef(\sound).play;
	Ndef(\sound).fadeTime = 1;
	Ndef(\sound, { SinOsc.ar([600, 635], 0, SinOsc.kr(2).max(0) * 0.2) });
	Ndef(\sound, { SinOsc.ar([600, 635] * 3, 0, SinOsc.kr(2 * 3).max(0) * 0.2) });
	Ndef(\sound, { SinOsc.ar([600, 635] * 2, 0, SinOsc.kr(2 * 3).max(0) * 0.2) });
	Ndef(\sound, Pbind(\dur, 0.17, \freq, Pfunc({ rrand(300, 700) })) );
	
	Ndef(\lfo, { LFNoise1.kr(3, 400, 800) });
	Ndef(\sound).map(\freq, Ndef(\lfo));
	Ndef(\sound, { arg freq; SinOsc.ar([600, 635] + freq, 0, SinOsc.kr(2 * 3).max(0) * 0.2) });
	Ndef(\lfo, { LFNoise1.kr(300, 400, 800) });
	

	
	Ndef.clear; //clear all
	

Simple audio routing with the <<> operator.

	
	(
	Ndef(\sound, {
		RHPF.ar(
			\in1.ar([0, 0]) * \in2.ar([0, 0]),
			\freq.kr(6000, 2),
			\rq.kr(0.2)
		) * 10
	}).play;
	);
	
	Ndef(\a, { SinOsc.ar(MouseX.kr(300, 1000, 1) * [1, 1.2], \phase.ar([0, 0]) * 0.2) });
	Ndef(\b, { LFDNoise3.ar(MouseY.kr(3, 1000, 1) * [1, 1.2]) });
	Ndef(\c, { LFTri.ar(MouseY.kr(3, 10, 1) * [1, 1.2]).max(0) });
	
	Ndef(\sound) <<>.in1 Ndef(\a);
	Ndef(\sound) <<>.in2 Ndef(\b);
	Ndef(\sound) <<>.in2 Ndef(\c);
	Ndef(\a) <<>.phase Ndef(\sound);
	Ndef(\a) <<>.phase nil; // unmap
	Ndef.clear(3);		// clear all Ndefs



Recursion:

Ndefs can be used recursively.
a structure like the following works:


	Ndef(\sound, { SinOsc.ar([600, 635], Ndef.ar(\sound) * 10, LFNoise1.kr(2).max(0) * 0.2) });
	Ndef(\sound).play;

This is because there is a feedback delay (the server's block size), usually 64 samples, so that calculation can reiterate over its own outputs. For single sample feedback, see:

	Document.open("Examples/demonstrations/single_sample_feedback.scd")


Using different servers:

	// create a new server
	a = Server(\foo, NetAddr("127.0.0.1", 57123)).boot.makeWindow;
	Ndef(\sound, { SinOsc.ar([600, 635]) * SinOsc.kr(2).max(0) * 0.2 }).play; // play on default
	Ndef(\sound -> \foo, { SinOsc.ar([700, 745]) * SinOsc.kr(2).max(0) * 0.2 }).play;// play on foo
	
	// clear definitions
	Ndef(\sound -> \foo).clear(3);
	Ndef(\sound).clear(3);	
	
	
GUI
	
	// create a window for a given Ndef
	Ndef(\sound).edit
	(
	Ndef(\sound, { |freq = 440, rate = 2| 
		SinOsc.ar(freq * [1, 1.625]) * SinOsc.kr(rate).max(0) * 0.2 
	}).play;
	);
	
	// set lags for controls:
	Ndef(\sound).lag(\freq, 0.2, \rate, 0.5);
	
	// create a mixer for all Ndefs:
	NdefMixer(s);
	
	
Using Associations
For a complete list, see NodeProxy, and NodeProxy_roles
	
	// setsrc
	(
	Ndef(\x, 
		\setsrc -> Pbind(\source, 
			Pseq([
				{ LFTri.ar(280 * Line.kr(1.1, 0.4, rrand(2, 3)) + [0,1]) * 0.1 },
				{ Pulse.ar(40 + [0,1]) * 0.1 },
				{ LFTri.ar(LFTri.kr(1).round(1.0.rand) + 1 * 180 + [0,1], 0.04) * 0.3 },
			], inf), 
			\dur, Prand([3, 2, 4], inf)
		)
	).play;
	)
	
	
	
	
	
	
	


