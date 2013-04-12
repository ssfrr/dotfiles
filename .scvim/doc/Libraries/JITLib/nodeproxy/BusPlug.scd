BusPlug		a listener on a bus

Inherits from:  Object : AbstractFunction


BusPlug is mainly in use as a basic superclass of NodeProxy, but it can be applied for other things  as well.
Most methods are documented in the NodeProxy helpfile.

See also: Bus


*new(server) 	
		Create a new (neutral) instance on the given server
				
*audio(server, numChannels) 
		Create a new audio rate instance on the given server
				
*control(server, numChannels) 
		Create a new audio rate instance on the given server
		
clear		
		Free the bus, end the monitor

ar(numChannels)
kr(numChannels)
	
		Return a link to my output, which is limited by numChannels. If uninitialized, creates a matching bus. Normally, ar defaults to stereo, kr to mono. 
		This can be set in the classvars: defaultNumAudio, defaultNumControl

play(out, numChannels, target, multi, vol, fadeTime, addAction)
		Plays from a bus index (out) with a number of channels to another index with a number of channels, within a target (a group, or a server).
			multi: keep old links and add new one
			volume: volume at which to monitor
			fadeTime: fade in fade out time

	
playN(outs, amps, ins, vol, fadeTime, group, addAction)
			outs			array of destination channels
			amps		array of  amplitudes for each channel
			outs			array of source channels

monitor
	returns the current monitor (see Monitor)



Example


// using as a control bus listener

s.boot;
z = Bus.control(s, 16);
a = BusPlug.for(z);

m = { Mix(SinOsc.ar(a.kr(16), 0, 0.1)) }.play;

z.setn(Array.rand(16, 300, 320).put(16.rand, rrand(500, 1000)));
z.setn(Array.rand(16, 300, 320).put(16.rand, rrand(500, 1000)));
z.setn(Array.rand(16, 300, 320).put(16.rand, rrand(500, 1000)));

m.free;


m = { SinOsc.ar(a.kr(2, MouseX.kr(0, 19)), 0, 0.1) }.play; // modulate channel offset

z.setn(Array.rand(16, 300, 1320).put(16.rand, rrand(500, 1000)));


m.free; z.free;

// using as a audio monitor

p = BusPlug.audio(s,2);
d = { Out.ar(p.index, PinkNoise.ar([0.1, 0.1])) }.play;


p.play; // monitor whatever plays in p (the execution order does not matter)



d.free;
d = { Out.ar(p.index, PinkNoise.ar([0.1, 0.1])) }.play;

p.stop;
p.play;

// also p can play to another bus:

p.stop;
p.play(12);

// listen to that bus for a test:
x = { InFeedback.ar(12,2) }.play;
x.free;





